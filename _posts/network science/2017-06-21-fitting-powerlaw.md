---
layout: single
title: "使用powerlaw拟合重尾分布"
header:
  teaser: "/assets/images/unsplash-gallery-image-2-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-34.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "幂律分布的存在非常广泛， 对于很多科学研究问题具有重要意义。但是，因为幂律分布的长尾具有很大的波动，因而确定长尾的范围尤为复杂。最小二乘方法估计幂律分布会有很大的误差，即使没有误差，也并未能确定这一分布是否幂律分布，因为没有同其他的分布的形式做比较，比如指数、对数正态、截尾的幂律。Clauset等人2009年发表了题为Power-law distributions in empirical data，提出了拟合幂律分布数据的思路[^clauset]。这一思路使用最大似然的方法拟合，使用Kolmogorov-Smirnov检验统计量和似然率为基础来评估拟合的结果"
modified: 2017-06-21 19:49:48
comments: true
author: "王成军"
tags:
  - powerlaw
  - python
categories:
  - algorithm
---

幂律分布的存在非常广泛， 对于很多科学研究问题具有重要意义。但是，因为幂律分布的长尾具有很大的波动，因而确定长尾的范围尤为复杂。最小二乘方法估计幂律分布会有很大的误差，即使没有误差，也并未能确定这一分布是否幂律分布，因为没有同其他的分布的形式做比较，比如指数、对数正态、截尾的幂律。比较是一个数据是否符合多个分布中的一个，通常采用KS检验（[Kolmogorov-Smirnov test](https://en.wikipedia.org/wiki/Kolmogorov%E2%80%93Smirnov_test)）的方法。

![ks test](http://oaf2qt3yk.bkt.clouddn.com/a23f96a8247d118985675c9bb579f75b.png)

上图红线表示累计概率密度函数CDF, 蓝线是实证数据的累计概函数 ECDF, 黑色箭头代表K–S 统计量.


$$F_n(x)={1 \over n}\sum_{i=1}^n I_{[-\infty,x]}(X_i)$$

其中，$I_{[-\infty,x]}(X_i)$ 是一个指标函数, 如果 $X_i \le x$它等于1 ，否则为0.

KS统计量表达为：

$$D_n= \sup_x |F_n(x)-F(x)|$$

当$D_n$足够大的时候，就可以拒绝原假设。

Clauset等人2009年发表了题为Power-law distributions in empirical data，提出了拟合幂律分布数据的思路[^clauset]。这一思路使用最大似然的方法拟合，使用Kolmogorov-Smirnov检验统计量和似然率为基础来评估拟合的结果。



[^clauset]: A. Clauset, C.R. Shalizi, and M.E.J. Newman, "Power-law distributions in empirical data" SIAM Review 51(4), 661-703 (2009). (arXiv:0706.1062, doi:10.1137/070710111)


按照这一思路，在不同的软件当中有不同的实现方式。Clauset等人罗列 了一系列的[实现方式](http://tuvalu.santafe.edu/~aaronc/powerlaws/)，并推荐使用Alstott等人开发的powerlaw工具[^powerlaw]。

[^powerlaw]: Alstott, J., Bullmore, E., & Plenz, D. (2014). Powerlaw: a Python package for analysis of heavy-tailed distributions. Plos One, 9(1), e85777.

```python
%matplotlib inline
import re
import sys
import powerlaw
import numpy as np
import matplotlib.cm as cm
import networkx as nx
import statsmodels.api as sm
from collections import Counter, defaultdict
import matplotlib.pyplot as plt
```


```python
with open("/Users/Weibo Landscape/data/aggregate.txt", 'rb') as f:
    dat = f.readlines()
```


```python
len(dat)
```




    741754




```python
G=nx.DiGraph() # G = nx.DiGraph() # æåçœç»

for line in dat:
    a, b = line.strip().split('\t')[:2]
    if b:
        G.add_edge(a, b)

```


```python
nx.info(G)
```




    'Name: \nType: DiGraph\nNumber of nodes: 151937\nNumber of edges: 279499\nAverage in degree:   1.8396\nAverage out degree:   1.8396'




```python
import powerlaw

def plotPowerlaw(data,ax,col,xlab):
    fit = powerlaw.Fit(data,xmin=1)
    fit.plot_pdf(color = col, linewidth = 2)
    fit = powerlaw.Fit(data)
    fit.power_law.plot_pdf(color = col, linestyle = 'dotted', ax = ax)
    a,x = (fit.power_law.alpha,fit.power_law.xmin)
    minx,maxx=ax.get_xlim()
    miny,maxy=ax.get_ylim()
    ax.text(minx*5,maxy/10,r"$\alpha = %d \:\:, x_{min} = %d$" % (a,x), fontsize = 20)
    ax.set_xlabel(xlab, fontsize = 20)
    ax.set_ylabel('$P(k)$', fontsize = 20)

```


```python
d = G.degree()
degree = d.values()
```


```python
fig = plt.figure(figsize=(6, 6),facecolor='white')
cmap = cm.get_cmap('rainbow_r',6)

ax = fig.add_subplot(1,1,1)
plotPowerlaw(degree,ax,cmap(6),'$k$')
plt.savefig('/Users/chengjun/çŸåºŠäºåæ­¥ç/Writing/Weibo Landscape/data/Figure2_powerlaw_PDF.png',
            dpi = 400, bbox_inches="tight",transparent = True)
```

    Calculating best minimal value for power law fit



![powerlaw](http://oaf2qt3yk.bkt.clouddn.com/5319cfe727b9dcb893d64b3b61ab85b4.png)


```python
fitted = powerlaw.Fit(degree, xmin = 3)

fitted.alpha, fitted.D
```

    (2.3663242775904081, 0.034385401350230271)


    ```python
    help(fitted_pl.distribution_compare)
    ```

        Help on method distribution_compare in module powerlaw:

        distribution_compare(self, dist1, dist2, nested=None, **kwargs) method of powerlaw.Fit instance
            Returns the loglikelihood ratio, and its p-value, between the two
            distribution fits, assuming the candidate distributions are nested.

            Parameters
            ----------
            dist1 : string
                Name of the first candidate distribution (ex. 'power_law')
            dist2 : string
                Name of the second candidate distribution (ex. 'exponential')
            nested : bool or None, optional
                Whether to assume the candidate distributions are nested versions
                of each other. None assumes not unless the name of one distribution
                is a substring of the other.

            Returns
            -------
            R : float
                Loglikelihood ratio of the two distributions' fit to the data. If
                greater than 0, the first distribution is preferred. If less than
                0, the second distribution is preferred.
            p : float
                Significance of R


R是拟合两统计分布的似然率， p值是R的显著性程度。

```python


r1, p1 = fitted.distribution_compare('power_law', 'exponential', nested = True)
r2, p2 = fitted.distribution_compare('power_law', 'lognormal', nested = True)
r3, p3 = fitted.distribution_compare('power_law', 'truncated_power_law', nested = True)
r4, p4 = fitted.distribution_compare('power_law', 'stretched_exponential', nested = True)


print r1, p1
print r2, p2
print r3, p3
print r4, p4
```

    Assuming nested distributions


    25001.9789239 0.0
    5.97249455121 0.000547945514698
    2.61348956987e-05 0.99423151641
    665.388668948 0.0

可见该分布是幂律分布或截断幂律分布（二者无差异），但显著不同于指数分布、广延指数分布[^stretched]、对数正态分布。

[^stretched]: stretched exponential function $f_\beta (t) = e^{ -t^\beta }$

常见的分布律 [^complex]

- 正态/高斯分布Normal distribution / Gaussian distribution
- 对数正态分布Log-normal distribution
- 指数/负指数分布Exponential distribution / Negative exponential distribution
- 泊松分布Poisson distribution
- 幂律分布Power law distribution
- 指数截断的幂律分布Power law with exponential cutoff
-  截断幂律Truncated power law
-  广延指数分布Stretched exponential distribution
-  漂移幂律Shifted power law

[^complex]: 复杂性科学研究中常见分布律及数据拟合方法 http://blog.sciencenet.cn/blog-419840-601485.html

![formula](http://oaf2qt3yk.bkt.clouddn.com/8b22fa094fcac40ca66141e75d47eb79.png)

## 另外一个例子

```python
from networkx.utils import powerlaw_sequence

pl_sequence = powerlaw_sequence(1000,exponent=2.5)

fitted_pl = powerlaw.Fit(pl_sequence)

fitted_pl.alpha
```

    2.4627497555168394




```python
fitted_pl.D
```




    0.016086740927675369



```python
r1, p1 = fitted_pl.distribution_compare('power_law', 'exponential', nested = True)
r2, p2 = fitted_pl.distribution_compare('power_law', 'lognormal', nested = True)
r3, p3 = fitted_pl.distribution_compare('power_law', 'truncated_power_law', nested = True)
r4, p4 = fitted_pl.distribution_compare('power_law', 'stretched_exponential', nested = True)


print r1, p1
print r2, p2
print r3, p3
print r4, p4

```

    438.9629348 0.0
    0.00543046554532 0.916998102815
    -0.0013573718109 0.958446461888
    5.13999579922 0.00134480559265


# 参考文献
