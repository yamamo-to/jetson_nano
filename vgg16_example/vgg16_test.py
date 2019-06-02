import argparse
import cupy as cp
from chainer import links as L
from PIL import Image
from utils import show_ranking


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('filename')
    args = parser.parse_args()

    vgg16 = L.VGG16Layers()
    vgg16.to_gpu()

    img = Image.open(args.filename)
    img = L.model.vision.vgg.prepare(img)
    img = img[cp.newaxis]
    img = cp.array(img, dtype=cp.float32)

    result = vgg16(img)
    probs = cp.asnumpy(result['prob'][0].data)
    show_ranking(probs)


if __name__ == '__main__':
    main()
