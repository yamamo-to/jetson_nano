import argparse
import numpy as np
import tensorrt as trt
import pycuda.driver as cuda
import pycuda.autoinit

from PIL import Image
from chainer import links as L


TRT_LOGGER = trt.Logger(trt.Logger.INFO)


def load_engine(filename):
    with open(filename, 'rb') as f:
        with trt.Runtime(TRT_LOGGER) as runtime:
            return runtime.deserialize_cuda_engine(f.read())


def load_image(filename):
    img = Image.open(filename)
    img = L.model.vision.vgg.prepare(img)
    img = img[np.newaxis]
    img = np.array(img, dtype=np.float32)
    return img


def show_ranking(data, top=10):
    indexes = np.argsort(-data)[0:top]
    labels = []
    with open('labels.txt') as f:
        for line in f:
            labels.append(line)
    
    for index in indexes:
        print('{prob:.5f} {index} {label}'.format(
            prob=data[index], index=index, label=labels[index]), end='')
 

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('engine_file_path')
    parser.add_argument('image_file_path')
    args = parser.parse_args()

    engine = load_engine(args.engine_file_path)
    img = load_image(args.image_file_path)

    with engine.create_execution_context() as context:
        # allocate memory
        input_shape = engine.get_binding_shape(0)[:]
        output_shape = engine.get_binding_shape(1)[:]
        h_input = cuda.pagelocked_empty(shape=input_shape, dtype=np.float32)
        h_output = cuda.pagelocked_empty(shape=output_shape, dtype=np.float32)
        d_input = cuda.mem_alloc(h_input.nbytes)
        d_output = cuda.mem_alloc(h_output.nbytes)
        bindings = [int(d_input), int(d_output)]

        # set input image
        h_input[:] = img

        # do inference
        stream = cuda.Stream()
        cuda.memcpy_htod_async(d_input, h_input, stream)
        context.execute_async(bindings=bindings, stream_handle=stream.handle)
        cuda.memcpy_dtoh_async(h_output, d_output, stream)
        stream.synchronize()

        # show result
        show_ranking(h_output)


if __name__ == '__main__':
    main()
