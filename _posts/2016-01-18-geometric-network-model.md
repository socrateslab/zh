---
layout: single
title: "标度行为的几何模型"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-5.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "这个几何模型，不仅适用于物理空间，也适用于抽象空间（abstracted space）。前者包括城市、因特网的autonomous systems、大脑，后者包括相似性空间（similarity space，如引文网络、科学合作网络、在线社区）、语义空间、生态位空间（niche space）。"
modified: 2016-01-18T11:55:22-04:00
comments: true
author_profile: true
author: "王成军"
---

{% include toc title="Table" icon="file-text" %}

张江等提出了一个几何网络模型，该模型主要强调了一种空间受限的链接机制。模型假设：每个时间点$t$ 一个新的节点 $P$ 出现在几何空间里的一个随机的位置, 如果 $P$ 在至少一个老节点$Q$的几何半径$r$的范围内，$P$ 才会被加入该网络，否则就会被删除。

![geometric-grpah-model](http://oaf2qt3yk.bkt.clouddn.com/c2386f54ace597b90525c29f36fb42c2.png)

具体而言：

- 网络的增长来源于新节点点的加入；
- 新节点落入几何空间中的位置是随机的，但是只有当新节点的位置处于至少某一个老节点的半径中时，新节点才会被真正加入进来，否则则会被删除。
- 新节点与老节点之间建立链接的方式可以分为至少四种方式：
  - 任意一个老节点，只要新节点在它的半径内，就与之建立链接；
  - 对于那些新节点在其半径内的老节点，新节点只与链接最多的那个建立链接；
  - 对于那些新节点在其半径内的老节点，新节点只与链接最少的那个建立链接；
  - 对于那些新节点在其半径内的老节点，新节点以一定的概率选择只与链接最多的那个建立链接，或者只与链接最少的那个建立链接；

这个几何模型，不仅适用于物理空间，也适用于抽象空间（abstracted space）。前者包括城市、因特网的autonomous systems、大脑，后者包括相似性空间（similarity space，如引文网络、科学合作网络、在线社区）、语义空间、生态位空间（niche space）

## 网络模拟

可以采用python作为编程环境来实现这个过程。首先导入一下常用的科学计算、网络算法和绘图的包。

```python
import numpy as np
from scipy.sparse import *
from scipy import *
import random
import matplotlib.pyplot as plt
import pickle
import networkx as nx
from scipy.optimize import leastsq
from rtree import index #必备包，为了让模型加速
```

之后我们来定义一个模型初始化的函数，输入L、d、r三个参数。

```python
def initiate(L,d,r):
  # input: L range, d dimension, r radius
  # generate nodes that carry coordinates
  coordinate=np.ones(d)*L/2
  nodelist={1:{1:coordinate,3:1,4:0,5:0}}
  # 1: coordinate, 3: borning time, 4: In degree, 5: out degree

  # Create 2D index, Using Rtree to accelerate
  p = index.Property()
  if d>=2:
      p.dimension = d
  else:
      p.dimension = 2
  idxnd = index.Index(properties=p)
  limitt=np.zeros(2*d)
  for key in nodelist:
      ele=nodelist[key]
      xs=ele[1]
      rectangle1=xs-r
      rectangle2=xs+r
      if d==1:
          idxnd.insert(key,[rectangle1,0,rectangle2,0])
      else:
          idxnd.insert(key,list(np.r_[rectangle1,rectangle2]))
      limitt=np.r_[rectangle1,rectangle2]
  # nodelist: a list of nodes, idxnd: Rtree indices, limitt: Rectangle boundary
  return (nodelist,idxnd,limitt)
```
接下来，可以定义一个网络模型生长迭代的函数onestep。

```python
def onestep(nodelist,idxnd,L,network,limit,time,d,r):
  #计算几何图占方形区域面积
  aa=1
  for i in range(d):
      aa=aa*(limit[i+d]-limit[i])
  locallambda=aa/(L**d)
  # Bias sample the area of aa (valid area) to accelerate.
  # And the average time interval between two random valid nodes
  # follow an exponential distribution, some time can generated virtually
  time+=random.expovariate(locallambda)
  # Generate a random node within the valid area
  newpoint=np.array([random.random()*(limit[d+v]-limit[v])+limit[v] for v in range(d)])

  #Search for neighbors
  if d==1:
      hits=list(idxnd.intersection((newpoint,0,newpoint,0)))
  else:
      hits=list(idxnd.intersection(tuple(np.r_[newpoint,newpoint])))
  neighbors={}
  newedges=0;
  if len(hits)>0:
      for i in hits:
          node=nodelist[i]
          distance=np.linalg.norm(node[1]-newpoint)
          if distance<r:
              ind=i
              neighbors[i]=ind
  if len(neighbors)>0:
      # Real adding nodes and links
      nodelist[len(nodelist)+1]={1:newpoint,3:time,4:0,5:len(neighbors)}
      for i in range(d):
          limit[i]=min(limit[i],newpoint[i]-r)
          limit[i+d]=max(limit[i+d],newpoint[i]+r)
      for nd in neighbors:
          node=nodelist[nd]
          node[4]=node[4]+1
          newedges=newedges+1
      if d==1:
          idxnd.insert(len(nodelist),[newpoint-r,0,newpoint+r,0])
      else:
          rectangle1=newpoint-r;
          rectangle2=newpoint+r;
          rectangle=np.r_[rectangle1,rectangle2];
          idxnd.insert(len(nodelist),rectangle)
  return (nodelist,idxnd,newedges,network,limit,time)
```

##  Basic implementation

接下来可以按照给定的参数来进行模拟了。


```python
L=10**10 # Hypercube length
maxnode=10**5#The wanted number of nodes
d=2#spatial dimension
r=1#interaction area;
ndlist,idx,limit=initiate(L,d,r)

t=1
edges=[0];
network={};

time=1
while len(ndlist) < maxnode:
ndlist,idx,newedge,network,limit,time=onestep(ndlist,idx,L,network,limit,time,d,r)
if newedge>0:
    edges=np.r_[edges,edges[-1]+newedge];
if np.remainder(t,1000)==0:
    print len(ndlist)
t=t+1;
```

##  参考
[匹配生長隨機幾何圖模型](http://wiki.swarma.net/index.php/匹配生长随机几何图模型)
