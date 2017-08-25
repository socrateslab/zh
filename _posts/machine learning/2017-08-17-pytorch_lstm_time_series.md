---
layout: single
title: "使用LSTM进行时间序列预测——基于PyTorch框架"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-2.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "本文基于PyTorch框架使用LSTM模型对时间序列数据进行预测"
modified: 2017-08-17T11:55:22-04:00
comments: true
author_profile: true
author: "陈志聪"
---

之前在网上看到了一篇使用LSTM进行时间序列预测的教程，采用的是Keras框架，本文的主要工作是尝试理解这整个过程并改用PyTorch框架重写一遍。在此之前，笔者只安装过TensorFlow和PyTorch的编程环境（还是基于CPU的），然后跑过官网上一两个Getting Started之类的Tutorial，因此可以说是Start From Scratch了。

原文在此：[Multivariate Time Series Forecasting with LSTMs in Keras](http://machinelearningmastery.com/multivariate-time-series-forecasting-lstms-keras/)。此外，还有一篇相关的文章，也是用Keras做的：[LSTM Neural Network for Time Series Prediction](http://www.jakob-aungiers.com/articles/a/LSTM-Neural-Network-for-Time-Series-Prediction), 可以在Github上看到[Source Code](https://github.com/jaungiers/LSTM-Neural-Network-for-Time-Series-Prediction)

下面开始解剖整个过程

# 数据准备
首先是数据准备，在原文中，使用的是环境监测的数据集，包含的属性主要有：
- No: row number
- year: year of data in this row
- month: month of data in this row
- day: day of data in this row
- hour: hour of data in this row
- pm2.5: PM2.5 concentration
- DEWP: Dew Point
- TEMP: Temperature
- PRES: Pressure
- cbwd: Combined wind direction
- Iws: Cumulated wind speed
- Is: Cumulated hours of snow
- Ir: Cumulated hours of rain

原来的DataFrame长这样
```python
No,year,month,day,hour,pm2.5,DEWP,TEMP,PRES,cbwd,Iws,Is,Ir
1,2010,1,1,0,NA,-21,-11,1021,NW,1.79,0,0
2,2010,1,1,1,NA,-21,-12,1020,NW,4.92,0,0
……
```
将日期数据用pandas合并成一列

```python
def parse(x):
	return datetime.strptime(x, '%Y %m %d %H')
dataset = read_csv('raw.csv',  parse_dates = [['year', 'month', 'day', 'hour']], index_col=0, date_parser=parse)
```
得到新的DataFrame

```python
date,pollution,dew,temp,press,wnd_dir,wnd_spd,snow,rain
2010-01-02 00:00:00,129.0,-16,-4.0,1020.0,SE,1.79,0,0
2010-01-02 01:00:00,148.0,-15,-4.0,1020.0,SE,2.68,0,0
2010-01-02 02:00:00,159.0,-11,-5.0,1021.0,SE,3.57,0,0
2010-01-02 03:00:00,181.0,-7,-5.0,1022.0,SE,5.36,1,0
2010-01-02 04:00:00,138.0,-7,-5.0,1022.0,SE,6.25,2,0
……
```

接下来需要做的工作是把时间序列数据转化为可以进行监督学习的数据，参见[这篇文章](http://machinelearningmastery.com/convert-time-series-supervised-learning-problem-python/)。

下面是代码，定义了一个函数series_to_supervised，用来把原来的时间序列数据转化成监督学习的数据集。在调用这个函数之前，用Sci-kit Learn中的两个类进行了数据预处理，先是用LabelEncoder把数据中非数值特征（风向-wnd_dir）转化成了从0开始的数值特征，然后用MinMaxScaler对整个数据集进行了标准化。

```python
# convert series to supervised learning
def series_to_supervised(data, n_in=1, n_out=1, dropnan=True):
	n_vars = 1 if type(data) is list else data.shape[1]
	df = DataFrame(data)
	cols, names = list(), list()
	# input sequence (t-n, ... t-1)
	for i in range(n_in, 0, -1):
		cols.append(df.shift(i))
		names += [('var%d(t-%d)' % (j+1, i)) for j in range(n_vars)]
	# forecast sequence (t, t+1, ... t+n)
	for i in range(0, n_out):
		cols.append(df.shift(-i))
		if i == 0:
			names += [('var%d(t)' % (j+1)) for j in range(n_vars)]
		else:
			names += [('var%d(t+%d)' % (j+1, i)) for j in range(n_vars)]
	# put it all together
	agg = concat(cols, axis=1)
	agg.columns = names
	# drop rows with NaN values
	if dropnan:
		agg.dropna(inplace=True)
	return agg

# load dataset
values = dataset.values
# integer encode direction

from sklearn.preprocessing import MinMaxScaler
from sklearn.preprocessing import LabelEncoder

encoder = LabelEncoder()
values[:,4] = encoder.fit_transform(values[:,4])
# ensure all data is float
values = values.astype('float32')
# normalize features
scaler = MinMaxScaler(feature_range=(0, 1))
scaled = scaler.fit_transform(values)

# frame as supervised learning
reframed = series_to_supervised(scaled, 1, 1)
# drop columns we don't want to predict
reframed.drop(reframed.columns[[9,10,11,12,13,14,15]], axis=1, inplace=True)
print(reframed.head())
```

这样可以得到的DataFrame长这样，一共是8个特征，作为X，预测值Y是其中的第一个特征，即pm2.5的污染量，因为是预测时间序列数据，所以Y可以是X中的某一个特征，只不过是利用t-1时刻的值预测t时刻的值。

```python
   var1(t-1)  var2(t-1)  var3(t-1)  var4(t-1)  var5(t-1)  var6(t-1)  \
1   0.129779   0.352941   0.245902   0.527273   0.666667   0.002290
2   0.148893   0.367647   0.245902   0.527273   0.666667   0.003811
3   0.159960   0.426471   0.229508   0.545454   0.666667   0.005332
4   0.182093   0.485294   0.229508   0.563637   0.666667   0.008391
5   0.138833   0.485294   0.229508   0.563637   0.666667   0.009912

   var7(t-1)  var8(t-1)   var1(t)
1   0.000000        0.0  0.148893
2   0.000000        0.0  0.159960
3   0.000000        0.0  0.182093
4   0.037037        0.0  0.138833
5   0.074074        0.0  0.109658
```

# 构建LSTM网络

关于LSTM模型的介绍可以参考这篇：[理解LSTM网络(译)](http://www.jianshu.com/p/9dc9f41f0b29)

在LSTM模型中，每个cell都包含一个hidden state和一个cell state，分别记为h和c，对应于这个cell的输入，在cell中通过定义一系列的函数，有点类似于数字电路中的“门”的概念，从而实现一些诸如“遗忘”的功能。这些具体的函数已经被PyTorch等深度学习框架封装好了，因此我们需要做的就是定义h和c。在原文中，作者使用了Keras进行神经网络的搭建，他把隐层定义为50个神经元（我的理解其实就是说hidden state包含有50个feature），在这之后又接了一个Dense层，这应该是为了把隐层的计算结果映射出一个output值。

```python
# design network
model = Sequential()
model.add(LSTM(50, input_shape=(train_X.shape[1], train_X.shape[2])))
model.add(Dense(1))
```

在PyTorch中，采用如下的方法定义这个网络。建立一个有两个LSTMCell构成的Sequence网络，然后给定初始化的h0和c0，把输入和输出喂给这两个cell即可。

```python
class Sequence(nn.Module):
    def __init__(self):
        super(Sequence, self).__init__()
        # the hidden_size is 51
        self.lstm1 = nn.LSTMCell(1, 51)
        self.lstm2 = nn.LSTMCell(51, 1)

    def forward(self, input, future=0):
        outputs = []
        # both the input(h_t, c_t) and output(h_t2, c_t2) are initialized to zeros
        h_t = Variable(
            torch.zeros(input.size(0), 51), requires_grad=False)
        c_t = Variable(
            torch.zeros(input.size(0), 51), requires_grad=False)
        h_t2 = Variable(
            torch.zeros(input.size(0), 1), requires_grad=False)
        c_t2 = Variable(
            torch.zeros(input.size(0), 1), requires_grad=False)

        for i, input_t in enumerate(input.chunk(input.size(1), dim=1)):
            h_t, c_t = self.lstm1(input_t, (h_t, c_t))
            h_t2, c_t2 = self.lstm2(c_t, (h_t2, c_t2))
            outputs += [c_t2]

        outputs = torch.stack(outputs, 1).squeeze(2)
        return outputs
```

这里参考了以下三篇文档：
- https://github.com/pytorch/examples/tree/master/time_sequence_prediction
- http://pytorch.org/docs/master/nn.html#lstm
- http://pytorch.org/tutorials/beginner/nlp/sequence_models_tutorial.html

# 模型训练

训练这样一个网络，需要定义相应的损失函数loss function和优化算法，然后就可以套一下代码的模板进行训练了。

```python
# build the model
seq = Sequence()
criterion = nn.MSELoss()
# use LBFGS as optimizer since we can load the whole data to train
optimizer = optim.LBFGS(seq.parameters())

loss_list = []
test_loss_list = []
epoch_num = 50

# begin to train
for epoch in range(epoch_num):
    print('epoch : ', epoch)

    def closure():
        optimizer.zero_grad()
        out = seq(train_X)
        loss = criterion(out, train_y)
#         print('loss:', loss.data.numpy()[0])
        loss_list.append(loss.data.numpy()[0])
        loss.backward()
        return loss

    optimizer.step(closure)

    pred = seq(test_X)
    loss = criterion(pred, test_y)
#     print('test loss:', loss.data.numpy()[0])
    test_loss_list.append(loss.data.numpy()[0])

    y = pred.data.numpy()
```

详细代码参见[这里](http://nbviewer.jupyter.org/github/zhicongchen/ml-beginners/blob/master/Multivariate%20Time%20Series%20Forecasting%20with%20LSTMs%20in%20PyTorch.ipynb)。
