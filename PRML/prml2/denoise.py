import itertools
import numpy as np
from imageio import imread, imsave
from functools import reduce

ORIGINAL_IMAGE = "qiita_binary.png"
NOISY_IMAGE = "qiita_noise.png"
DENOISED_IMAGE = "qiita_denoised.png"


class Node(object):

    def __init__(self):
        self.neighbors = []
        self.messages = {}
        self.prob = None

        self.alpha = 10.
        self.beta = 5.

    def add_neighbor(self, node):
        """
        add neighboring node

        Parameters
        ----------
        node : Node
            neighboring node
        """
        self.neighbors.append(node)

    def get_neighbors(self):
        """
        get neighbor nodes

        Returns
        -------
        neighbors : list
            list containing neighbor nodes
        """
        return self.neighbors

    def init_messeges(self):
        """
        initialize messages from neighbor nodes
        """
        for neighbor in self.neighbors:
            self.messages[neighbor] = np.ones(shape=(2,)) * 0.5

    def marginalize(self):
        """
        calculate probability
        """
        prob = reduce(lambda x, y: x * y, self.messages.values())
        self.prob = prob / prob.sum()

    def send_message_to(self, node):
        """
        calculate message to be sent to the node

        Parameters
        ----------
        node : Node
            node to send computed message

        Returns
        -------
        message : np.ndarray (2,)
            message to be sent to the node
        """
        message_from_neighbors = reduce(lambda x, y: x * y, self.messages.values()) / self.messages[node]
        F = np.exp(self.beta * (2 * np.eye(2) - 1))
        message = F.dot(message_from_neighbors)
        node.messages[self] = message / message.sum()

    def likelihood(self, value):
        """
        calculate likelihood via observation, which is messege to this node

        Parameters
        ----------
        value : int
            observed value -1 or 1
        """
        
        assert (value[0] == -1) or (value[0] == 1), "{} is not 1 or -1".format(value)
        message = np.exp(self.alpha * np.array([-value, value]))
        self.messages[self] = message / message.sum()


class MarkovRandomField(object):

    def __init__(self):
        self.nodes = {}

    def add_node(self, location):
        """
        add a new node at the location

        Parameters
        ----------
        location : tuple
            key to access the node
        """
        self.nodes[location] = Node()

    def get_node(self, location):
        """
        get the node at the location

        Parameters
        ----------
        location : tuple
            key to access the corresponding node

        Returns
        -------
        node : Node
            the node at the location
        """
        return self.nodes[location]

    def add_edge(self, key1, key2):
        """
        add edge between nodes corresponding to key1 and key2

        Parameters
        ----------
        key1 : tuple
            The key to access one of the nodes
        key2 : tuple
            The key to access the other node.
        """
        self.nodes[key1].add_neighbor(self.nodes[key2])
        self.nodes[key2].add_neighbor(self.nodes[key1])

    def sum_product_algorithm(self, iter_max=10):
        """
        Perform sum product algorithm
        1. initialize messages
        2. send messages from each node to neighboring nodes
        3. calculate probabilities using the messages

        Parameters
        ----------
        iter_max : int
            number of maximum iteration
        """
        for node in self.nodes.values():
            node.init_messeges()

        for i in range(iter_max):
            print(i)
            for node in self.nodes.values():
                for neighbor in node.get_neighbors():
                    node.send_message_to(neighbor)

        for node in self.nodes.values():
            node.marginalize()


def denoise(img, n_iter=20):
    mrf = MarkovRandomField()
    len_x, len_y = img.shape[0], img.shape[1]
    X = range(len_x)
    Y = range(len_y)

    for location in itertools.product(X, Y):
        mrf.add_node(location)

    for x, y in itertools.product(X, Y):
        for dx, dy in itertools.permutations(range(2), 2):
            try:
                mrf.add_edge((x, y), (x + dx, y + dy))
            except Exception:
                pass

    for location in itertools.product(X, Y):
        node = mrf.get_node(location)
        node.likelihood(img[location])

    mrf.sum_product_algorithm(n_iter)

    denoised = np.zeros_like(img)
    for location in itertools.product(X, Y):
        node = mrf.get_node(location)
        denoised[location] = 2 * np.argmax(node.prob) - 1

    return denoised


def main():
    img_original = 2 * (imread(ORIGINAL_IMAGE) / 255).astype(np.int) - 1
    img_noise = 2 * (imread(NOISY_IMAGE) / 255).astype(np.int) - 1

    img_denoised = denoise(img_noise, 10)

    print("error rate before")
    print(np.sum((img_original != img_noise).astype(np.float)) / img_noise.size)
    print("error rate after")
    print(np.sum((img_denoised != img_original).astype(np.float)) / img_noise.size)
    imsave(DENOISED_IMAGE, (img_denoised + 1) / 2 * 255)

if __name__ == '__main__':
    main()