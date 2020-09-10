import pandas as pd
import matplotlib.pyplot as plt

FILE_NAME = '../data/disney_shanghai.csv'


def main():
    disney_sh = pd.read_csv(FILE_NAME)


if __name__ == '__main__':
    main()
