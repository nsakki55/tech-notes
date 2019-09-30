from tensorflow.examples.tutorials.mnist import input_data
import tensorflow as tf

mnist=input_data.read_data_sets('../ch3/data/',one_hot=True)

num_seq=28
num_input=28

x=tf.placeholder(tf.float32,[None,784])
input=tf.reshape(x,[-1,num_seq,num_input])

stacked_cells=[]
for i in range(3):
    stacked_cells.append(tf.nn.rnn_cell.LSTMCell(num_units=128))

cell=tf.nn.rnn_cell.MultiRNNCell(cells=stacked_cells)

outputs, _ =tf.nn.dynamic_rnn(cell=cell,inputs=input,dtype=tf.float32)

last_output=outputs[:,-1,:]

w=tf.Variable(tf.truncated_normal([128,10],stddev=0.1))
b=tf.Variable(tf.zeros([10]))

out=tf.nn.softmax(tf.matmul(last_output,w)+b)

y=tf.placeholder(tf.float32,[None,10])
loss=tf.reduce_mean(tf.square(y-out))

train_step=tf.train.GradientDescentOptimizer(0.5).minimize(loss)

correct=tf.equal(tf.argmax(out,1),tf.argmax(y,1))
accuracy=tf.reduce_mean(tf.cast(correct,tf.float32))

init=tf.global_variables_initializer()

with tf.Session() as sess:
    sess.run(init)

    

    test_images=mnist.test.images
    test_labels=mnist.test.labels

    for i in range(1000):
        step=i+1
        train_images,train_labels=mnist.train.next_batch(50)
        sess.run(train_step,feed_dict={x:train_images,y:train_labels})

        if step %10==0:
            acc_val=sess.run(accuracy,feed_dict={x:test_images,y:test_labels})
            print('Step %d: accuracy = %.2f' % (step,acc_val))