# cf. https://keras.io/ja/applications/
import argparse
import numpy as np
from tensorflow.keras.preprocessing import image
from tensorflow.keras.applications.resnet50 import ResNet50
from tensorflow.keras.applications.resnet50 import preprocess_input, decode_predictions


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('img_path')
    args = parser.parse_args()

    model = ResNet50(weights='imagenet', include_top=True)
    img = image.load_img(args.img_path, target_size=(224, 224))
    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    x = preprocess_input(x)

    preds = model.predict(x)
    results = decode_predictions(preds, top=10)[0]

    for result in results:
        print('{0} {2:.5f} {1}'.format(*result))


if __name__ == '__main__':
    main()
