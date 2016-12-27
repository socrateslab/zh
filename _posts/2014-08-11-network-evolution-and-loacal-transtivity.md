---
layout: single
title: "社交网络演化中的局部传递性"
tags:
  - 社交网络
  - 传递性
modified: 2014-08-11T11:55:22-04:00
author: "王成军"
---


人类动力学（human dynamics）研究者习惯于从系统的角度来分析问题；社会科学家则强调个体作为基本研究单位的重要性。系统的特性会作用于个体，个体的行动汇总起来可以塑造系统的全局特性。

### 连边局部特性

Leskovec等人(2008)尝试从个体出发，研究网络演化过程中的微观过程如何产生宏观的网络结构（如度分布、半径、聚类系数、社团结构）。Jure Leskovec, Lars Backstrom, Ravi Kumar, Andrew Tomkins在2008年KDD会议中发表了题为Microscopic Evolution of Social Networks的论文。他们发现除了偏好链接（preferential attachment），连边的局部特性（edge locality）在网络演化的过程中发挥着重要作用。

### 微观过程
他们首先将网络演化分为三个阶段：

- 节点的进入过程（node arrival process）：节点到达率（node arrival rate）的差异很大，可以使指数增长，也可以使亚线性增长，所以节点到达率作为模型的输入信息。
- 链接的发起过程（edge initiation process）：节点进入系统后，就开始建立链接，直到死掉。链接的间隔建立比率符合一个带有指数截断的幂率分布。Leskovec等发现链接的生成随着节点的中心度的增加而加速增长。
- 链接的闭合过程 （edge destination selection process）：leskovec等发现大多数链接的建立具有很强的局部性。局部性的测量通过起点和终点的距离来衡量（注意本文讨论的是有向网络的模型！！），因为多数起点和终点的距离是2，所以连边也就是在闭合三角形（close triangles）。说人话：多数链接是添加朋友的朋友（30%-60%）。什么样的三角闭合机制呢（即一个起点怎么选择终点呢）？他们发现节点从它所有的邻居中均匀地（uniformly）选择一个居中的节点建立链接具有最高的可能性（likelihood）。

### 最大似然准则
用来比较那些参数化模型生成的结果最好。应用方法：将网络演化看成链接逐条增加的过程。

1. 对于任何一个新的边的建立（已知起点，未知终点（endpoint）），测量使用一个特定的模型的话，选择一个终点的似然率。
2. 对于所有的连边都算一遍选择特定终点的似然率。
3. 对于所有可能的模型算一遍上面的过程
4. 根据这些似然率，选择最好的参数模型。

主要的竞争模型有$G_{n, p}$模型和PA模型，显然随机模型不靠谱，PA模型则主要考虑度分布、节点的年龄、共同作用。

![](http://chengjun.qiniudn.com/edges_leskovec.PNG)
真实数据链接数量随着节点距离（hops)的增加而指数下降；链接概率也跟节点距离负相关。两种度量PA和$G_{n, p}$模型的结果都不算好。

### 随机-随机三角闭合模型（RR）
![](http://chengjun.qiniudn.com/triangle-closing.PNG)
作者转而提出所谓的三角闭合模型，主要是强调关系传递性（transtivity）在网络演化中的重要性。将模型的设定摘抄到这里（懒得翻译了）：

多数起点和终点的距离是2，即大多数边跨越了两步。因此简单的随机-随机三角闭合模型（random-random triangle closing model）效果不错. 随机-随机三角闭合模型可以参数化为 $N(·)$, $\lambda$, $\alpha$, $\beta$, 具体定义如下.

1. 定义节点到达函数（新加入节点函数） N(·).
2. 节点 u 出现并且从指数分布中抽取一个生命周期 a $p_{l}(a) = \lambda  exp(−\lambda  \alpha)$.
3. 节点 u以正比于对方节点的度的概率添加第一条链接到节点v 。
4. 一个度为d的节点u从分布
$p_{g(\delta |d; \alpha, \beta)} = (1/Z) \delta^{ − \alpha}  exp(−\beta  d  \delta)$中抽取一个时间差（time gap） $\delta$  并休眠$\delta$ 个时间点.
5. 当一个节点醒来的时候，如果它的生命周期还没有结束，它就会根据随机-随机三角闭合模型（random-random triangle closing model）创造一个两步长的链接.
6. 如果一个节点的生命周期到尽头了，它就会停止添加链接；否则它会重复步骤4

![](http://chengjun.qiniudn.com/simulated_leskovec.PNG)
以flickr的数据来看，RR模型确实比PA要好。

### 参考文献
Jure Leskovec, Lars Backstrom, Ravi Kumar, Andrew Tomkins （2008）Microscopic Evolution of Social Networks. KDD. [link](http://vdisk.weibo.com/s/3nFsyZYcoo) [video link](http://videolectures.net/kdd08_leskovec_mesn/)
