---
layout: single
title: "Fitting exponential truncated power law using Python"
header:
  teaser: "/assets/images/unsplash-gallery-image-2-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-12.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "指数截尾的幂律分布如何拟合？本文介绍使用scipy的解决方案"
modified: 2017-04-18 19:49:48
comments: true
author: "陈志聪"
tags:
  - power law
categories:
  - Python
---


There is an equation of exponential truncated power law in the article of Gonzalez[^1] below:

[^1]: Gonzalez, M. C., Hidalgo, C. A., & Barabasi, A. L. (2008). Understanding individual human mobility patterns. Nature, 453(7196), 779-782.


$$P(r_g) = (r_g + r_g^0)^{-\beta_r} e^{-r_g/K}$$

To solve this problem, we asked it on [stackoverflow](http://stackoverflow.com/questions/43444794/how-to-estimate-the-parameters-of-an-exponential-truncated-power-law), and Michael suggested to `have a look at scipy.optimize.curve_fit`.

## Toy Data


```python
import numpy as np
rg = np.array([ 20.7863444 ,   9.40547933,   8.70934714,   8.62690145,
     7.16978087,   7.02575052,   6.45280959,   6.44755478,
     5.16630287,   5.16092884,   5.15618737,   5.05610068,
     4.87023561,   4.66753197,   4.41807645,   4.2635671 ,
     3.54454372,   2.7087178 ,   2.39016885,   1.9483156 ,
     1.78393238,   1.75432688,   1.12789787,   1.02098332,
     0.92653501,   0.32586582,   0.1514813 ,   0.09722761,
     0.        ,   0.        ])
```


```python
# calculate P(rg)
rg = sorted(rg, reverse=True)
rg = np.array(rg)
prg = np.arange(len(rg)) / float(len(rg)-1)
```


## Solution

```python
def func(rg, rg0, beta, K):
    return (rg + rg0) ** (-beta) * np.exp(-rg / K)

from scipy import optimize
popt, pcov = optimize.curve_fit(func, rg, prg, p0=[1.8, 0.15, 5])
print popt
print pcov

```

    [  1.04303608e+03   3.02058550e-03   4.85784945e+00]
    [[  1.38243336e+18  -6.14278286e+11  -1.14784675e+11]
     [ -6.14278286e+11   2.72951900e+05   5.10040746e+04]
     [ -1.14784675e+11   5.10040746e+04   9.53072925e+03]]



```python
%matplotlib inline
import matplotlib.pyplot as plt

plt.plot(rg, prg, 'bs', alpha = 0.3)
plt.plot(rg, (rg+popt[0])**-(popt[1])*np.exp(-rg/popt[2]), 'r-' )
plt.yscale('log')
plt.xscale('log')
plt.xlabel('$r_g$', fontsize = 20)
plt.ylabel('$P(r_g)$', fontsize = 20)
plt.show()
```


![fitted exponential truncated power law](http://oaf2qt3yk.bkt.clouddn.com/d661b220e4c594b771e08ccdb799dd42.png)

# 参考文献
