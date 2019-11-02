import pandas as pd
import numpy as np
import warnings
warnings.filterwarnings('ignore')
from logging import getLogger, basicConfig, DEBUG, INFO, StreamHandler
import os 


from sklearn.datasets import fetch_openml
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier, VotingClassifier, ExtraTreesClassifier
from sklearn.svm import SVC
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import accuracy_score



def load_mnist():
    mnist = fetch_openml('mnist_784', version=1)
    mnist.target = mnist.target.astype(np.int64)
    return mnist['data'], mnist['target']

def main():
    logger.info('load mnist')
    X, y = load_mnist()
    logger.info('mnist datasets:X shape {}, y shape {}'.format(X.shape,y.shape))

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)
    X_trn, X_val, y_trn, y_val = train_test_split(X_train, y_train, test_size=0.2, random_state=0)
    logger.info('train shape:{} test shape{}'.format(X_train.shape,X_test.shape))

    rf_clf = RandomForestClassifier(n_estimators=10, random_state=0)
    extra_clf = ExtraTreesClassifier(n_estimators=10, random_state=0)
    svm_clf = SVC(C=10, random_state=0)
    nn_clf = MLPClassifier(random_state=0)

    estimators = [rf_clf, extra_clf, svm_clf, nn_clf]
    for estimator in estimators:
        logger.info('train {}'.format(estimator.__class__.__name__))
        estimator.fit(X_trn,y_trn)
        pred_val = estimator.predict(X_val)
        logger.info('{} accuracy:{}'.format(estimator.__class__.__name__,accuracy_score(y_val,pred_val)))

    named_estimators = [('random_forest', rf_clf),
                        ('extra_tree', extra_clf),
                        ('svm', svm_clf),
                        ('nn', nn_clf),
                        ]
    voting_clf = VotingClassifier(named_estimators)
    voting_clf.fit(X_trn,y_trn)
    pred_val = voting_clf.predict(X_val)
    logger.info('Voting accuracy:{}'.format(accuracy_score(y_val,pred_val)))


if __name__ == '__main__':

    log_format = '%(levelname)s : %(asctime)s : %(message)s'
    if not os.path.exists('logs'):
        os.mkdir('logs')

    log_file = os.path.basename(__file__)+'.log'
    log_file = os.path.join('logs',log_file)
    basicConfig(level=DEBUG, format=log_format, filename=log_file)

    logger = getLogger(__name__)
    handler = StreamHandler()
    logger.addHandler(handler)

    logger.setLevel(INFO)
    
    logger.info('ready main')
    main()