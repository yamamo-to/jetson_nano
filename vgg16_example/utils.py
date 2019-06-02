import numpy as np


def show_ranking(data, top=10):
    indices = np.argsort(-data)[0:top]
    labels = []
    with open('labels.txt') as f:
        for line in f:
            labels.append(line)
    for index in indices:
        print('{prob:.5f} {index} {label}'.format(
            prob=data[index], index=index, label=labels[index]), end='')
