---
layout: single
title: "PageRank算法浅介"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-15.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "一个页面的“得票数”由所有链向它的页面的重要性来决定，到一个页面的超链接相当于对该页投一票。一个页面的PageRank是由所有链向它的页面（“链入页面”）的重要性经过递归算法得到的。"
modified: 2015-12-07T11:55:22-04:00
comments: true
categories:
  - 模型算法
tags:
  - pagerank
author_profile: true
author: "王成军"
---


{% include toc title="Table" icon="file-text" %}


PageRank算法是互联网发展过程中的一个里程碑，斯坦福大学的两个博士生凭借这一发现构建了谷歌搜索，对整个互联网产生了巨大影响。

## PageRank让链接来投票

一个页面的“得票数”由所有链向它的页面的重要性来决定，到一个页面的超链接相当于对该页投一票。一个页面的PageRank是由所有链向它的页面（“链入页面”）的重要性经过递归算法得到的。一个有较多链入的页面会有较高的等级，相反如果一个页面没有任何链入页面，那么它没有等级。

假設一個由4個頁面組成的小團體：A，B，C和D。如果所有頁面都鏈向A，那麼A的PR（PageRank）值將是B，C及D的Pagerank總和。

$$PR(A)= PR(B) + PR(C) + PR(D)$$ 繼續假設B也有連結到C，並且D也有連結到包括A的3個頁面。一個頁面不能投票2次。所以B給每個頁面半票。以同樣的邏輯，D投出的票只有三分之一算到了A的PageRank上。

$$PR(A)= \frac{PR(B)}{2}+ \frac{PR(C)}{1}+ \frac{PR(D)}{3}$$ 換句話說，根據鏈出總數平分一個頁面的PR值。

$$PR(A)= \frac{PR(B)}{L(B)}+ \frac{PR(C)}{L(C)}+ \frac{PR(D)}{L(D)}$$ 最後，所有這些被換算為一個百分比再乘上一個係數d。由於「沒有向外連結的頁面」傳遞出去的PageRank會是0，所以，Google通過數學系統給了每個頁面一個最小值(1 - d)/N。其逻辑是对于网页A, 用户以d的概率随机选择这个网页A浏览；而以剩下的（1 - d）/N的概率从每一个网页跳转到这个网页A，具体如下：

$$PR(A)=\left( \frac{PR(B)}{L(B)}+ \frac{PR(C)}{L(C)}+ \frac{PR(D)}{L(D)}+\,\cdots \right) d + \frac{1 - d}{N}$$

采用d概率来刻画两种浏览行为有着更为实际的原因：防止投票泄露现象。d称之为阻尼系数（Damping factor）。在共振时,阻尼可能限制稳定振动的振幅。d在这里也可以起到平衡两种机制的作用。

這個方程式引入了隨機瀏覽的概念，即有人上網無聊隨機打開一些頁面，點一些連結。一個頁面的PageRank值也影響了它被隨機瀏覽的機率。為了便於理解，這裡假設上網者不斷點網頁上的連結，最終到了一個沒有任何鏈出頁面的網頁，這時候上網者會隨機到另外的網頁開始瀏覽。

為了處理那些「沒有向外連結的頁面」（這些頁面就像「黑洞」會吞噬掉用戶繼續向下瀏覽的機率）帶來的問題，d=0.85（這裡的d被稱為阻尼係數（damping factor），其意義是，在任意時刻，用戶到達某頁面後並繼續向後瀏覽的機率。1-d=0.15（就是用戶停止點擊，隨機跳到新URL的機率）的算法被用到了所有頁面上，估算頁面可能被上網者放入書籤的機率。

所以，這個等式如下：

$${PageRank}(p_i) = \frac{1-d}{N} + d \sum_{p_j \in M(p_i)} \frac{{PageRank} (p_j)}{L(p_j)}$$

$p_1$, $p_2$, ..., $p_N$是被研究的頁面，$M(p_i)$是鏈入$p_i$頁面的集合，$L(p_j)$ 是 $p_j$ 鏈出頁面的數量，而N是所有頁面的數量。

PageRank值是一個特殊矩陣中的特徵向量。這個特徵向量為

<img src="http://upload.wikimedia.org/math/5/e/8/5e8c730eefdf62660f4cee0dd97c6028.png" alt="Image Title" />

## python程序模拟

首先生成一个简单地网络：

```python
import networkx as nx
G = nx.DiGraph()
G.add_edge('A','B')
G.add_edge('A', 'C')
G.add_edge('B','C')
G.add_edge('C','A')
pos=nx.spring_layout(G) #设置网络的布局
nx.draw(G, pos, node_color = 'orange', with_labels = True)  
```

我们用PR表示网页排名（page rank， pr）。

PR(A) = PR(C) PR(B) = PR(A)/2 PR(C) = PR(A)/2 + PR(B)

对于整个例子可以得到：PR(A) = PR(C) = 2*PR(B)

设A、B、C的初始的重要性均为1，通过上面的方程组进行迭代，每次迭代后会更新A、B、C的重要性。为了方面，先把方程组转换为矩阵运算。

PR(A) = 0<em>PR(A) + 0</em>PR(B) + PR(C) PR(B) = 0.5<em>PR(A) + 0</em>PR(B) + 0<em>PR(C) PR(C) = 0.5</em>PR(A) + PR(B) + 0*PR(C)

```python
import numpy as np
# 第一个例子：无漏洞
M = np.matrix([[0, 0, 1],[0.5, 0, 0],[0.5,1,0]])  
PR= np.matrix([1, 1, 1]).transpose()

for i in range(1,101):
  PR = M*PR
  print str(i)+'\n', PR
```

但是这种简单地迭代有一个局限，就是当流量随着迭代不断流入一些节点时，这些流量不会再流出的时候，就会出现少数节点占有所有网页排名，其它节点排名为0的情况出现。一个极端的例子是：

PR(A) = PR(B) + PR(C)

```python
import numpy as np
# 第二个例子：引入漏洞
M = np.matrix([[0, 1, 1],[0, 0, 0],[0,0,0]])  
PR= np.matrix([1, 1, 1]).transpose()

for i in range(1,101):
  PR = M*PR print str(i)+'\n', PR
```

此时，最终收敛的结果是：PR(A) = PR(B) = PR(C) = 0

<img src="http://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/PageRanks-Example.svg/800px-PageRanks-Example.svg.png" alt="Image Title" />

如上图中，最终所有的投票都集中在ABC三个节点上，其它节点收到的投票为0。随着迭代进行全部节点的得票都是0。因而，需要有一个平衡的调节机制，将那些只索取不奉献的节点的PageRank取一部分平均分配。

```python
import numpy as np
# 第二个例子漏洞问题的解决方法：平衡两种机制
M = np.matrix([[0, 1, 1],[0, 0, 0],[0,0,0]])  
PageRank= np.matrix([1, 1, 1]).transpose()
for i in range(1,101):
  PR = 0.15/3 + 0.85*M*PR
  print str(i)+'\n', PR

# 第一个例子采用pagerank算法重新计算的结果

M = np.matrix([[0, 0, 1],[0.5, 0, 0],[0.5,1,0]])  
PR = np.matrix([1, 1, 1]).transpose()
for i in range(1,101):
  PR = 0.15/3 + 0.85*M*PR
  print str(i)+'\n', PR
```

可以将以上计算的结果和networkx的pagerank函数得到的结果做比较：

```python
nx.pagerank(G)
```
