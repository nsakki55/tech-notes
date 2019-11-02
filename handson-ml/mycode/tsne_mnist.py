import numpy as np
from logging import getLogger, basicConfig, StreamHandler,DEBUG, INFO, Formatter, FileHandler
import matplotlib.pyplot as plt
import os 
from matplotlib.offsetbox import AnnotationBbox, OffsetImage

from sklearn.datasets import fetch_openml
from sklearn.manifold import TSNE
from sklearn.preprocessing import MinMaxScaler

def load_mnist():
    mnist = fetch_openml('mnist_784', version=1)
    mnist.target = mnist.target.astype(np.int64)

    m = 1000
    idx = np.random.permutation(60000)[:m]
    return mnist['data'][idx], mnist['target'][idx]

def plot_mnist(data,y):
    plt.scatter(data[:,0],data[:,1], c=y, cmap = 'jet')
    plt.axis('off')
    plt.colorbar()

def plot_digits(X, y, min_distance=0.05, images=None, figsize=(13,10)):
    X_normalized = MinMaxScaler().fit_transform(X)
    neighbors = np.array([10,10])
    plt.figure(figsize=figsize)
    cmap = mpl.cm.get_cmap('jet')
    digits = np.unique(y)
    for digit in digits:
        plt.scatter(X_normalized[y == digits,0],X_normalized[y == digit,1],c=[cmap(digit/9)])

        plt.axis("off")
    ax = plt.gcf().gca()  # get current axes in current figure
    for index, image_coord in enumerate(X_normalized):
        closest_distance = np.linalg.norm(np.array(neighbors) - image_coord, axis=1).min()
        if closest_distance > min_distance:
            neighbors = np.r_[neighbors, [image_coord]]
            if images is None:
                plt.text(image_coord[0], image_coord[1], str(int(y[index])),
                         color=cmap(y[index] / 9), fontdict={"weight": "bold", "size": 16})
            else:
                image = images[index].reshape(28, 28)
                imagebox = AnnotationBbox(OffsetImage(image, cmap="binary"), image_coord)
                ax.add_artist(imagebox)

def main():
    logger.info('load mnist')
    X, y = load_mnist()
    logger.info('transform tsne')
    tsne = TSNE(n_components=2, random_state=0)
    X_reduced = tsne.fit_transform(X)

    logger.info('plot tsne')
    
    plot_digits(X,y)

if __name__ == '__main__':

    log_fmt = Formatter('%(asctime)s %(name)s %(lineno)d [%(levelname)s][%(funcName)s] %(message)s ')
    
    # ハンドラはログ記録の適切な送り先等を決める
    handler = StreamHandler()

    # level よりも深刻でないログメッセージは無視される
    handler.setLevel('INFO')
    logger = getLogger(__name__)
    logger.addHandler(handler)

    # 保存先ファイル名
    if not os.path.exists('logs'):
        os.mkdir('logs')

    log_file = os.path.basename(__file__)+'.log'
    log_file = os.path.join('logs',log_file)

    # ログの保存先
    handler = FileHandler(log_file, 'a')

    # ログレベルをDEBUGに設定することで、コマンドラインにログが出力される
    handler.setLevel(DEBUG)
    handler.setFormatter(log_fmt)

    logger.setLevel(DEBUG)
    logger.addHandler(handler)

    main()