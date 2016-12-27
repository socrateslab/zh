---
title: "使用networkx计算平均最短路径长度"
tags:
  - networkx
  - python
modified: 2014-10-31T11:55:22-04:00
author:"王成军"
---

## 问题
小可老师给我提了一个问题：为什么一个微博扩散网络的平均最短路径长度是0.001？


## 平均最短路径长度的定义
给定一个网络G(n, e), n是节点数量，e是链接数量。对于网络中的任意一对节点source s和target t，我们可以计算它们之间的最短距离$d_{s, t}$。将这些距离相加除以$n(n-1)$，就可以得到网络的平均最短路径长度。公式如下[^1]：

 $$
 a = \sum \frac{d_{s,t}}{n(n-1)}
 $$


## 代码

首先，生成一个实例网络。

```python
import networkx as nx
import matplotlib.pyplot as plt
# 生成一个有向网络
G=nx.DiGraph()
#网络构成
G.add_edges_from([(1, 2), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (2, 3), (2, 4), (6, 7)])
#绘制网络
pos=nx.spring_layout(G, iterations=5000) #设置网络的布局
plt.figure()
nx.draw(G, pos)
```

![avrage—nx-path](http://oaf2qt3yk.bkt.clouddn.com/5336451cfec4520b87dd8d05751b00d3.png)

这样我们生成了一个较为典型的星形有向扩散网络。

来看一下节点之间的最短路径长度：

```python
nx.average_shortest_path_length(G) # 网络平均最短距离0.181
```
果然有向网再次出现小于1的平均最短距离。
按照定义，我们需要统计任意一对节点之间的距离，节点1作为起点与其它节点之间的最短距离的和是10， 2是2， 6是1， 其它节点`不存在`最短路径的问题。
这样 $a =\frac {10 + 2 + 1}{9*8} = 0.181$

上述手工计算过程可以通过nx.all_pairs_shortest_path_length(G)实现。

```python
nx.all_pairs_shortest_path_length(G)
```

    Out[29]:
    {1: {1: 0, 2: 1, 3: 2, 4: 2, 5: 1, 6: 1, 7: 1, 8: 1, 9: 1},
     2: {2: 0, 3: 1, 4: 1},
     3: {3: 0},
     4: {4: 0},
     5: {5: 0},
     6: {6: 0, 7: 1},
     7: {7: 0},
     8: {8: 0},
     9: {9: 0}}


由上述结果，可知道对于类似节点3和4之间距离的问题，networkx就是认为不存在的。所以没有列出，测试一下：

```python
nx.shortest_path_length(G, source = 1, target =2)
# 1
nx.shortest_path_length(G, source = 1, target =3)
# 2
nx.shortest_path_length(G, source = 3, target =4)
#error: NetworkXNoPath: No path between 4 and 3.
```
因为有些节点之间距离不存在而不被计算（被认为是0而非无穷大），所以产生了节点数量的平方大于最短距离之和的情况，进而平均最短距离小于1这种反直觉的情况在有向网络中出现了。

当我们把网络转化为无向网络的时候，这种情况就消失了。

```python
UG=G.to_undirected()
nx.average_shortest_path_length(UG) #1.93
```

对于这种星形扩散网络，很多节点对之间的最短路径并不存在，应该被计算为无穷大，而不是0，所以对于这种网络计算平均最短路径长度没有太大的意义了。与其如此，不如计算所有节点对当中，不存在最短路径长度的比例。

## 参考
[^1]: http://networkx.lanl.gov/reference/generated/networkx.algorithms.shortest_paths.generic.average_shortest_path_length.html
