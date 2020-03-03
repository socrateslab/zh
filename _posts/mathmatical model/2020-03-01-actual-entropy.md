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

但是这个算法的计算复杂度比较高，对于观察窗口为秒或者毫秒的长时间序列，很难算出来。一开始我们在stackover flow上提了[这个问题](https://stackoverflow.com/questions/46296891/entropy-estimator-based-on-the-lempel-ziv-algorithm-using-python)。后来才发现Song也是按照小时为观察窗口计算的!

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

反常：也就是是说第二个序列的信息更丰富，熵越小。换句话说：序列越不规律，越难以预测，反而熵越小! Something is wrong!
