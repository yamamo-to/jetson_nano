import chainer.links as L
import argparse


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('input_caffe_model')
    parser.add_argument('output_chainer_model')
    args = parser.parse_args()

    L.VGG16Layers.convert_caffemodel_to_npz(
        args.input_caffe_model, args.output_chainer_model)


if __name__ == "__main__":
    main()
