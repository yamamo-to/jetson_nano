import argparse
import tensorrt as trt


TRT_LOGGER = trt.Logger(trt.Logger.INFO)


def build_engine(onnx_file_path, engine_file_path):
    with trt.Builder(TRT_LOGGER) as builder:
        builder.max_workspace_size = 1 << 20
        builder.max_batch_size = 1

        with builder.create_network() as network:
            with trt.OnnxParser(network, TRT_LOGGER) as parser:

                with open(onnx_file_path, 'rb') as model:
                    parser.parse(model.read())

                engine = builder.build_cuda_engine(network)

                with open(engine_file_path, 'wb') as f:
                    f.write(engine.serialize())


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('onnx_file_path')
    parser.add_argument('engine_file_path')
    args = parser.parse_args()
    build_engine(args.onnx_file_path, args.engine_file_path)


if __name__ == '__main__':
    main()
