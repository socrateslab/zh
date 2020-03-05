---
layout: single
title: "思考真实熵"
header:
  teaser: "/assets/images/unsplash-gallery-image-2-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-16.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "在Limits of Predictability in Human Mobility一文（Song, 2010, Science）当中，Song等人提出人类移动行为的可预测性问题。强调了采用香农熵或随机熵不能捕捉到移动位置的时间序列特点，主张采用一种真实熵(the actual entropy)的测量方式，表示为S; 以一个小时为一个观察窗口，观察一段连续的时间里的人类个体移动轨迹，一个人到过的地点总数是N。"
modified: 2020-03-01 19:49:48
comments: true
author: "王成军"
tags:
  - human mobility
categories:
  - Python
---

{% include toc title="Table" icon="file-text" %}


## 真实熵

在之前的[一篇文章](https://computational-communication.com/python/predicatability/)当中，我们介绍了真实熵。

在Limits of Predictability in Human Mobility一文（Song, 2010, Science）当中，Song等人提出人类移动行为的可预测性问题。强调了采用香农熵或随机熵不能捕捉到移动位置的时间序列特点，主张采用一种真实熵(the actual entropy)的测量方式，表示为S; 以一个小时为一个观察窗口，观察一段连续的时间里的人类个体移动轨迹，一个人到过的地点总数是N。

计算真实熵的方法是采用一种称之为**Lempel-Ziv的算法**来进行估计。

$$E= (\frac{1}{n} \sum_i \Lambda_i )^{-1} ln (n)$$

where $\Lambda_i$ is the length of the shortest substring starting at position i which doesn't previously appear from position 1 to i-1.

The estimated entropy converges to the real entropy of the time series when n approaches to infinity.[^lz]

[^lz]: Kontoyiannis I., Algoet P. H., Suhov Yu. M., Wyner A. J. Nonparametric Entropy Estimation for Stationary Processes and Random Fields, with Applications to English Text, IEEE Transactions on Information Theory 44, 1319-1327 (1998).


## Lempel-Ziv Compression Algorithm

> In Haifa, Israel in 1977, Abraham Lempel and Jacob Ziv develop a highly flexible algorithm that compresses data with no data loss. First published in the IEEE Transactions on Information Theory in May 1977 and improved in 1978, it enabled efficient data transmission via the internet.

> These algorithms, originally known as LZ77 and LZ78 and now referred to as LZ1 and LZ2, respectively, were foundational to the development of subsequent compression algorithms and are the root of compression programs like GIF and DEFLATE, which is used in PNG files.

**Lempel and Ziv’s 1977 algorithm compressed data by replacing repeated instances of data with a single reference copy of that data as it appeared earlier in the uncompressed, or input, data stream**. These data matches were registered as a pair of numbers known as the length-distance pair. To code the matches, LZ77 used so-called sliding window compression. The most recent data in the stream would be held for a length of time, during which the encoder would search for matches. The longer the sliding window, the greater the ability of the encoder to build references.

LZ78 changed the encoding scheme by replacing repeated instances of data with references to a dictionary. This dictionary was built to match the data entering the input stream. Subsequent modifications of LZ78, such as LZW, used an algorithm that was pre-initialized with all possible characters.

```python
import math
def contains(small, big):
    for i in range(len(big)-len(small)+1):
        if big[i:i+len(small)] == small:
            return True
    return False

def actual_entropy(l):
    n = len(l)
    sequence = [l[0]]
    sum_gamma = 0
    shortest_substrings = [[0, l[0], None]]
    for i in range(1, n):
        for j in range(i+1, n+1):
            s = l[i:j]
            if not contains(list(s), sequence): # s is not contained in previous sequence
                shortest_substrings.append([i,l[i], list(s)])
                sum_gamma += len(s)
                sequence.append(l[i])
                break

    ae = 1 / (sum_gamma / n ) * math.log(n)            
    return ae, sum_gamma, n, shortest_substrings
```

但是这个算法的计算复杂度比较高，对于观察窗口为秒或者毫秒的长时间序列，很难算出来。一开始我们在stackoverflow上提了[这个问题](https://stackoverflow.com/questions/46296891/entropy-estimator-based-on-the-lempel-ziv-algorithm-using-python)。后来才发现Song也是按照小时为观察窗口计算的!

> To construct a time series for each user we segment the three month observation period into hour-long intervals. Each interval is assigned a tower ID if one is known (i.e. the phone was used in that time interval). If multiple calls were made in a given interval, we choose one of them at random. Finally if no call is made in a given interval, we assign it an ID “?”, implying an unknown location. Thus for each user i we obtain a string of length $L = 24 * 7 * 14 = 2352$ with $N_i + 1$ distinct symbols, each denoting one of the Ni towers visited by the user and one for the missing location “?”. ([Supporting Online Material](http://science.sciencemag.org/content/suppl/2010/02/18/327.5968.1018.DC1) for Limits of Predictability in Human Mobility, page 4)

基于这种思路，就可以计算出来任何一个时间序列的真实熵。


```Python
D1='1212121212'
D2='2112221121'
```

![一个例子](/assets/2019/2020-actual-entropy-Snip20200303_15.png)

```Python
actual_entropy(D1)

(1.3544618194082623,
 17,
 10,
[[0, '1', None],
 [1, '2', ['2']],
 [2, '1', ['1', '2', '1']],
 [3, '2', ['2', '1', '2']],
 [4, '1', ['1', '2', '1', '2', '1']],
 [5, '2', ['2', '1', '2', '1', '2']]])

 actual_entropy(D2)

 (1.2118868910494978,
  19,
  10,
 [[0, '2', None],
   [1, '1', ['1']],
   [2, '1', ['1', '2']],
   [3, '2', ['2', '2']],
   [4, '2', ['2', '2']],
   [5, '2', ['2', '1', '1', '2', '1']],
   [6, '1', ['1', '1', '2', '1']],
   [7, '1', ['1', '2', '1']]])
```

我把gamma的取值全部手工找了一遍，如上。的确是第二个序列的sum_gamma更大19，第一个序列的sum_gamma是17。所以计算没错。

### 问题：第二个序列的信息更丰富，熵越小？错误❌


换句话说：序列越不规律，越难以预测，反而熵越小! Something is wrong!

因为这里的例子有问题：太短了。不满足n趋近于无穷大的条件。

![zhicong](/assets/2019/zhicong.png)

这里的推导由香港城市大学媒体与传播系陈志聪同学提供。

> 因此，可以构造更长的序列来检验，此时期待随机化序列的真实熵更大。


![undraw_news](/assets/2019/undraw_news.svg)

```python
import random
random.seed(2020)

D2 = []

for i in range(200):
    if random.random() >= 0.5:
        D2.append('1')
    else:
        D2.append('2')
D2  = ''.join(D2)
D1 = '12'*100

actual_entropy(D1), actual_entropy(D2)
```

> (0.21197508967985743, 0.7645479605408423)

问题解决。

```python
import random
import numpy as np

random.seed(2020)
ent_list = []

for n in range(5, 200):
    D2 = []
    for i in range(n*2):
        if random.random() >= 0.5:
            D2.append('1')
        else:
            D2.append('2')
    D2  = ''.join(D2)
    D1 = '12'*n
    ent_list.append([n, actual_entropy(D1), actual_entropy(D2)])  

n, ent1, ent2 = np.array(ent_list).T

import pylab as plt

plt.plot(2*n, ent1, label = 'regular string')
plt.plot(2*n, ent2, label = 'random string')
plt.axhline(y=0.8,ls=":",c="red", alpha = 0.3)#添加水平直线
plt.axhline(y=0.7,ls=":",c="red", alpha = 0.3)#添加水平直线
plt.axhline(y=0.2,ls=":",c="red", alpha = 0.3)#添加水平直线
plt.axhline(y=0.1,ls=":",c="red", alpha = 0.3)#添加水平直线

plt.ylim(0, 2)
plt.legend(fontsize = 15)
#plt.xscale('log', basex=2)
plt.xlabel('length of string',fontsize = 15)
plt.ylabel('actual entropy',fontsize = 15)
plt.show()
```

![actual_ent](/assets/2019/actual_ent.png)

对这个例子，随机字符串的真实熵在0.7-0.8之间稳定波动，而规则字符的真实熵则不断下降到0.2以下。
