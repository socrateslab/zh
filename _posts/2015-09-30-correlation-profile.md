---
title: 演员网络中的度相关：随机洗牌的影响
date: 2015-09-30 11:09
tags:
  - 网络
  - 度相关
author:"王成军"
---

演员网络是一个被广泛研究的网络数据。这个数据的规模很大，分析起来并不如想得那么简单。我们首先读取数据。

```python
import re
import sys
import random
import numpy as np
from numpy import delete
from numpy import linalg as LA
%matplotlib inline
import matplotlib.cm as cm
import matplotlib.pyplot as plt
from urlparse import urlparse
from scipy.stats.stats import pearsonr
import networkx as nx
import statsmodels.api as sm
from collections import Counter, defaultdict
from math import sin, cos, sqrt, atan2, radians
import Image

# refreshing results
def flushPrint(variable):
    sys.stdout.write('\r')
    sys.stdout.write('%s' % variable)
    sys.stdout.flush()

W = defaultdict(int) # user mobility in real and virtual world
n = 0 # counter
with open ('/Users/chengjun/bigdata/actor.dat.gz.txt') as f:
    for i in f:
        n += 1
        if n % 10**4 == 0:
            flushPrint(n)
        line = i.strip().split(' ')
        line = [int(j) for j in line]
        if len(line)==1:
            pass
        else:
            for i, j in zip(line[:-1], line[1:]):
                if i != j:
                    W[ tuple( sorted( [i, j]) )] += 1
```

然后，构造网络。

```python
G = nx.Graph()
for x,y in W:
    G.add_edge(x,y,weight=W[(x,y)])
nx.info(G)
```
'Name: \nType: Graph\nNumber of nodes: 382219\nNumber of edges: 1259892\nAverage degree:   6.5925'

需要指出的是这个网络当中含有多个子图。

```python
graphs = list(nx.connected_component_subgraphs(G))
```
我们感兴趣的是其中的度相关情况，即构成链接的每个节点的度之间的相关。需要注意的是，这个时候需要考虑零模型的情况，即剔除随机网络的影响。S Maslov, K Sneppen 2002年的时候，在Science杂志上发表了一篇论文专门讨论这种情况。

calculated the likelihood P(K0,K1) that two proteins with connectivities K0 and K1 are connected to each other by a link and compared it to the same quantity Pr(K0,K1) measured in a randomized version of the same network. In this “null model” network, all proteins have exactly the same connectivity as in the original one, whereas the choice of their interaction partners is totally random.

得到度相关矩阵后，可以采用热力图的形式进行展示，为了使得展示更容易观察，采用高斯过滤的方法对矩阵进行处理。

```python
#P(K0,K1)
def getNKK(g, maxd):
    nkk = np.zeros([maxd+1, maxd+1])
    for i, j in g.edges():
        m = g.degree(i)
        n = g.degree(j)
        nkk[m, n] +=1
        nkk[n, m] +=1
    return nkk

def matrixToList(matrix):
    x = [];y = [];z = []
    for i,j in np.ndenumerate(matrix):
        if not np.isnan(j) and not np.isinf(j) and j!= 0.0:
            x.append(i[0])
            y.append(i[1])
            z.append(j)
    x, y, z = map(np.array, [x, y, z])   
    return x, y, z

import scipy.ndimage as ndi

def grid_density_gaussian_filter(x0, y0, x1, y1, w, h, data):
    kx = (w - 1) / (x1 - x0)
    ky = (h - 1) / (y1 - y0)
    r = 20
    border = r
    imgw = (w + 2 * border)
    imgh = (h + 2 * border)
    img = np.zeros((imgh,imgw))
    for xi, yi, zi in data:
        ix = int((xi - x0) * kx) + border
        iy = int((yi - y0) * ky) + border
        iz = zi
        if 0 <= ix < imgw and 0 <= iy < imgh:
            img[iy][ix] += zi # this could be a problem.
    return ndi.gaussian_filter(img, (r,r))  ## gaussian convolution

from matplotlib.colors import LogNorm

def plotHeatMap(mat, title):
    # generate data
    x, y, z = matrixToList(mat)

    # data points range
    data_ymin = np.min(y)+0.001
    data_ymax = np.max(y)
    data_xmin = np.min(x)+0.001
    data_xmax = np.max(x)

    # view area range
    view_ymin = data_ymin
    view_ymax = data_ymax
    view_xmin = data_xmin
    view_xmax = data_xmax

    zd = grid_density_gaussian_filter(view_xmin, view_ymin, view_xmax, view_ymax, 500, 500, zip(x, y, z))
    plt.imshow(zd , origin='lower', extent=[view_xmin, view_xmax, view_ymin, view_ymax])# norm = LogNorm()
    #plt.xscale('log'),plt.yscale('log')
    plt.ylabel('$K_{1}$'); plt.xlabel('$K_{0}$')
    plt.title(title)
    plt.colorbar()
    plt.tight_layout()

def shuffleNetwork(Graph):
    g = Graph
    H = g.copy()
    import timeit
    start = timeit.default_timer()
    #Your statements here
    nx.double_edge_swap(H,nswap=500000, max_tries=400000000)
    stop = timeit.default_timer()
    print stop - start
    maxd = np.max(g.degree().values())
    nkk = getNKK(g, maxd)    
    nrk = getNKK(H, maxd)
    rkk = nkk/nrk
    return nkk, nrk, rkk
```
这样我们可以得到nkk， nrk， rkk

```python
nkk, nrk, rkk = shuffleNetwork(graphs[0])
```
画出来看看：

```python
fig = plt.figure(figsize=(12, 4),facecolor='white')
ax = fig.add_subplot(1,3,1)
plotHeatMap(rkk, 'Correlation Profile')
ax = fig.add_subplot(1,3,2)
plotHeatMap(nkk, 'Original')
ax = fig.add_subplot(1,3,3)
plotHeatMap(nrk, 'Reshuffled')
plt.tight_layout()
```

![k1k2](http://oaf2qt3yk.bkt.clouddn.com/798b31bd2c2455f772e774af87461cad.png)

当然了，我们可以考虑另一种情况，即一个节点的度为k，它的邻居的平均度是$<k_{nn}>$, 那么他们之间是什么关系呢？

```python
def degreeCor(g,ax,lab,mar):
    l=defaultdict(list)
    for i in g.nodes():
        k = []
        for j in g.neighbors(i):
            k.append(g.degree(j))
        l[g.degree(i)].append(np.mean(k))   
    x = l.keys()
    y = [np.mean(i) for i in l.values()]
    ax.plot(x, y, mar, label = lab)
    ax.legend(loc=1,fontsize=10, numpoints=1)
    ax.set_xscale('log'); ax.set_yscale('log')
    ax.set_ylabel(r'<knn(k)> ')
    ax.set_xlabel('k')
```

显然，如下图所示，经过彻底洗牌之后的网络不再具有同质性。

```python
g = graphs[0]
H = g.copy()
import timeit
start = timeit.default_timer()
#Your statements here
nx.double_edge_swap(H,nswap=9000000, max_tries=4000000000)
stop = timeit.default_timer()
fig = plt.figure(figsize=(12, 4),facecolor='white')
ax = fig.add_subplot(1,2,1)
degreeCor(g,ax,'Actors','bs')
ax = fig.add_subplot(1,2,2)
degreeCor(H,ax,'shuffled','gv')
```

![correlation_shuffling](http://oaf2qt3yk.bkt.clouddn.com/4d1f2ea9918c3492acb9d60e5132bf1a.png)
