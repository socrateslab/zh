---
layout: single
title: "网络增长动力学：BA模型"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-22.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "在 1999的 一篇文章里, Barabasi 和 Albert 提出了网络增长的优先链接（preferential attachment）模型.他们假设新节点每次携带常数m条边，且每条边链接到老节点的概率与老节点的度成正比。为了获得度分布的解析式，他们在论文原文中用的是平均场方法（mean-field analysis）。"
modified: 2015-11-07T11:55:22-04:00
comments: true
categories:
  - 传播网络
tags:
  - python
  - networkx
author_profile: true
author: "吴令飞"
---


{% include toc title="Table" icon="file-text" %}


## Barabasi-Albert 模型及其主方程解法

在 1999的 <a href="http://www.barabasilab.com/pubs/CCNR-ALB_Publications/199910-15_Science-Emergence/199910-15_Science-Emergence.pdf">一篇文章里</a>, Barabasi 和 Albert 提出了网络增长的优先链接（preferential attachment）模型.

他们假设新节点每次携带常数m条边，且每条边链接到老节点的概率与老节点的度成正比。请注意该模型包含增长和优先链接两个部分，只有其中一者的话不足以形成度的长尾分布。为了获得度分布的解析式，他们在论文原文中用的是平均场方法（mean-field analysis）。所谓平均场，就是假设网络增长的过程是平滑、均匀、连续的，所以只要先写出单个节点的度在某一时刻增量的方程，对这个方程做时间上的积分，就可以得到单个节点的度随时间增长的方程。又因为节点是均匀地被添加到网络中的，所以时间t等于网络节点的N，度大于某一个数值的节点一定是在某个特定时刻之前就已经在网络中。从这些思路出发，最后得到网络节点度分布的近似表达，是一个幂指数为-3的幂律度分布。

一年之后，Dorogovstev, Mendes 和 Samukhin (<a href="http://arxiv.org/abs/cond-mat/0004434">2000</a>) 使用另一种叫做主方程的方法（master equation）获得了BA模型度分布的严格表达。 接下来就要对这个方法做一介绍。本文的介绍参考了Daron Acemoglu 和 Asu Ozdaglar 的 <a href="http://economics.mit.edu/files/4624">讲义</a>。

在网络中，我们定义以下几个量：n是网络中节点的数量；k是节点的度；m是每个节点携带的常数连边数量；p_k是网络中度为k的节点的比例；p_k,n是当网络中有n个节点时，网络中度为k的节点的比例。

这样，一个新节点的一条新连边，连接到网络中随机的一个节点的概率是1/n。如果根据BA模型的假设，链接概率与老节点的度成正比，这个概率变成k/sum(k)，也就是归一化以后的度。度为k的这批节点集合众人之力一起抢到一条连边的概率是

$$
\frac{k}{\sum_{k=1}^{k_{max}} k}n p_k = \frac{k}{\frac{1}{n}\sum_{k=1}^{k_{max}} k}p_k=\frac{k}{2m}p_k. (1)
$$

考虑到每个新节点会带m条连边进入网络，度为k的节点一起抢到的连边数为

$$
m\frac{k}{2m}p_k= \frac{k}{2}p_k.  (2)
$$

在网络增长的过程中，每个节点的度都只增不减。把度看做是财富的话，就相当于所有人的收入一直在增加。如下图所示，每个社会阶层的人口变动包括两个部分，新增的富人（从度k-1变成度为k）和流失的变成更富的人（从度k变成度为k+1）。前者减去后者，就是这个社会阶层的人口变化，可以表达为

$$
(n+1)p_{k,n+1}-np_{k,n} = \Delta k = \frac{k-1}{2}p_{k-1,n}-\frac{k}{2}p_{k,n},  (3)
$$

![pyramid_ba](http://oaf2qt3yk.bkt.clouddn.com/34fd6c6adb73fc0de28f2432a586f4b8.png)如上图所示。

Eq.(3) 只适用于k > m的情况. 当k = m, 因为没有更穷的人了，所以不会有从度为 k-1 到 k这部分，唯一可能的阶层新成员是当前时间步新加入网络的那个节点，所以我们应该修改方程为

$$
(n+1)p_{m,n+1}-np_{m,n} = \Delta m = 1-\frac{m}{2}p_{m,n},  (4)
$$

现在让我们假设社会已经发展到一个平衡态，各个财富阶层的人口比例不再变化，也就是

$$
p_{k,n+1} = p_{k,n} = p_k,  (5)
$$

即

$$
p_k = \frac{k-1}{2}p_{k-1}-\frac{k}{2}p_k,(6)
$$

和

$$
p_m = 1-\frac{m}{2}p_m,  (k=m)  (7)
$$

从以上两个方程中我们可以推得

$$
\frac{p_k}{p_{k-1}} = \frac{k-1}{k+2} (8)
$$

和

$$
p_m = \frac{2}{m+2}  (k=m)  (9)
$$

为了得到p_k的表达式，我们构建以下序列

$$
\frac{p_k}{p_m} = \frac{p_{m+1}}{p_m} ...\frac{p_{k-1}}{p_{k-2}}\frac{p_k}{p_{k-1}}  (10)
$$

并且找到解

$$
p_k = \frac{2m(m+1)}{k(k+1)(k+2)}.  (11)
$$

当k比较大时，Eq.(11) 就是一个指数为-3的幂律富分布。这与Barabasi的原文中给出的解是一致的。

## BA模型的Python代码

本代码使用了networkx这个包，代码改造自<a href="http://networkx.lanl.gov/_modules/networkx/generators/random_graphs.html#barabasi_albert_graph">这里</a>

```python
import random
import networkx as nx
# 从一个叫做seq的list中随机选择m个不重复元素
def random_subset(seq,m):
  targets=set()
  while len(targets)<m:
    x=random.choice(seq)
    targets.add(x)
  return targets

# 优先链接模型，n为节点数量，m为连边数量
def BA(n, m):
  G=nx.empty_graph(m) #构造包含m个节点0条连边的网络
  targets=list(range(m)) #第m+1节点进来的时候，把之前的m个节点都当做是连边的终点（数字序号即节点名称）
  repeated_nodes=[] #包含了所有节点的一个list，每个节点重复出现的次数等于它的度
  source=m #第m+1个节点作为连边的起点，其名称是m，因为数字序号从0开始计算
  while source<n:
    G.add_edges_from(zip([source]<em>m,targets)) #起点给每一个终点一条连边
    repeated_nodes.extend(targets) #抢到边的终点产生一个分身，包含到repeated_nodes里
    repeated_nodes.extend([source]</em>m) #给出m条的新节点产生m个分身，包含到repeated_nodes里
    targets = random_subset(repeated_nodes,m) #进入下一轮，在repeated_nodes里随机选择m个节点作为新的终点，分身越多的节点被选中概率越大
    source += 1 #进入下一轮，在当前最大数值的节点序号上+1，引入一个新的节点作为起点
  return G
```
## 对模拟的BA模型的度分布进行分析

![ba_lingfei](http://oaf2qt3yk.bkt.clouddn.com/3d1bea362850b0cdcf989ffa77b5661f.png)

上图展示了BA模型在m=2,n=200,500,1000的参数情况下的度分布。观察发现幂律度分布的指数总是与理论预测值吻合，与节点的数量无关。从Eq.(11)可以看出来，实际上富分布与每个节点携带的连边数也无关。需要注意的事为了避免被模拟得到的数据中的噪音干扰，本处使用了rank-order曲线，也就是Zipf’s law来展示度分布。因为只有斜率是1才是用严格的Zipf‘s law，所以我们一般仍只称为rank-order曲线。在画这种曲线时，纵轴是节点的度，横轴是度的降序排名，如果两个节点度相等，则随机排名。最后，采取双对数坐标系。根据Lada Adamic的<a href="http://www.hpl.hp.com/research/idl/papers/ranking/ranking.html">说明</a>，幂律分布在rank-order曲线的下的斜率b与原始的幂指数a的关系是a=1+1/b。因为我们的解析解是a=3，所以b应该是0.5（图中红线）。对数据进行双对数坐标系下的OLS拟合及绘图的python代码请参考<a href="http://wiki.swarma.net/index.php/Python">集智百科</a>。如果想要使用更严格的幂律拟合方法，可以使用Python的<a href="https://pypi.python.org/pypi/powerlaw">powerlaw</a>这个模块。

## 其他网络增长模型

### 随机增长网络
现在让我们考虑其他可能的网络规则。

最简单的是其他条件都不变，但新节点每次以1/n的概率随机选择老节点进行连边。此时，新节点连接到度为k的一批节点的概率是(1/n)<em>n</em>p_k = p_k。考虑每个新节点携带m条边，则这批节点获得的新连边数量是m*p_k。类似于前文中的思路，我们可以得到


$$(n+1)p_{k,n+1}-np_{k,n}$$


$$(n+1)p_{k,n+1}-np_{k,n} = \Delta k = mp_{k-1}-mp_k,  (12)$$

和

$$
(n+1)p_{m,n+1}-np_{m,n} = \Delta m = 1-mp_m.  (13)
$$

考虑系统达到平衡态，分布不再变化，如 Eq. (5) 所描述，则有

$$
p_k = mp_{k-1}-mp_k,  (k>m) (14)
$$

和

$$
p_m = 1-mp_m.  (k=m), (15)
$$

从上述方程可以得到

$$
\frac{p_k}{p_{k-1}} = \frac{m}{m+1}  (k>m), (16)
$$

和

$$
p_m = \frac{1}{m+1}  (k=m). (17)
$$

根据 Eq. (16)， 我们发现概率比例与k无关，这是合理的，因为我们连边时根本不考虑节点的度。我们使出老招式，构造 Eq. (10) 并解得

$$
p_k = \frac{1}{m+1}(\frac{m}{m+1})^{k-m}.  (18)
$$


![random_ba](http://oaf2qt3yk.bkt.clouddn.com/b894ba0084baab3a1bc46d6cd77369c2.png)

上图展示了对模拟的随机增长网络的度分布分析，构造该网络的Python代码如下：

```python
# 随机增长网络
def ranG(n, m):
  G=nx.empty_graph(m)
  targets=list(range(m))
  unique_nodes=set()
  source=m
  while source<n:
    G.add_edges_from(zip([source]*m,targets))
    unique_nodes.update(targets)
    unique_nodes.add(source)
    targets = _random_subset(list(unique_nodes),m) #其他的部分都与BA模型的代码一致，只不过repeated_nodes变成了unique_nodes，用set而不是list来构造
    source += 1
  return G
```

### 反BA网络

如果我们把BA的规则反过来会发生什么？我们假设老节点获得新连接的概率与其度数成反比，即

$$
\sum_{i=1}^{n} \frac{1}{k} \approx n\frac{1}{2m}.  (19)
$$

那么m条连边被分配给度为k的一批节点的数量是

$$
\frac{\frac{1}{k}}{\sum_{i=1}^{n} \frac{1}{k}} np_k m \approx \frac{2m^2}{k}p_k.  (20)
$$

考虑系统平衡态，有

$$
(n+1)p_{k,n+1}-np_{k,n} = \Delta k = p_k = A - B \approx\frac{2m^2}{k}p_k-\frac{2m^2}{k-1}p_{k-1},  (21)
$$

和

$$
(n+1)p_{m,n+1}-np_{m,n} = \Delta m = p_m = 1 - B = 1-\frac{2m^2}{m}p_{m},  (22)
$$

从中可以导出

$$
\frac{p_k}{p_{k-1}}=\frac{k}{k-1}\frac{2m^2}{k+2m^2},  (23)
$$

和

$$
p_m = \frac{1}{1 + 2m}.  (24)
$$

因为m一般是一个小数值(在经典BA模型中m=2)，我们可以假设当k很大时2m^2/(k+2m^2)约等于1/k，从而得到

$$
\frac{p_k}{p_{k-1}} \sim \frac{1}{k-1},  (25)
$$

并导出

$$
p_k \approx \frac{1}{1 + m} \frac{1}{m(m+1)(m+2)...(k-1)}=\frac{1}{1 + 2m}\frac{(m-1)!}{(k-1)!}=\frac{1}{1 + m}\frac{e^{ln[(m-1)!]}}{e^{ln[(k-1)!]}},  (26)
$$

根据<a href="http://en.wikipedia.org/wiki/Stirling's_approximation">Stirling近似公式</a>, 有

$$
ln(n!) \approx nln(n) - n.  (27)
$$

因此

$$
p_k \approx \frac{1}{1 + 2m} \frac{(m-1)^{m-1}}{(k-1)^{k-1}}e^{k-m},  (27)
$$

特别地，当 m = 2时， $p_k = 0.2*(k-1)^{1-k}  e^{k-2} $。

![reverse_ba](http://oaf2qt3yk.bkt.clouddn.com/a93cbd5d9eec5aabd9fd41309151fa99.png)

上图展示了模拟数据和理论预测曲线的关系。因为我们使用了好几次近似，所以理论曲线与模拟数据的匹配，没有之前BA模型和随机增长网络的效果好。其实，在Volkan Sevim1和Per Arne Rikvold 2006年的<a href="http://arxiv.org/abs/cond-mat/0510763">文章</a>中，曾经讨论过反BA机制，但他们给出得度分布近似解析解效果也不好，而且还是建立在假设m很大的情况下。我们认为本文的基于m很小的假设做的近似，是更合理的。以下代码可用于生成反BA网络。

```python
# 为定义带权重的随机选择函数做准备
def weighted_choice_sub(weights):
  rnd = random.random() * sum(weights)
  for i, w in enumerate(weights):
    rnd -= w
    if rnd < 0:
      return i

# 带权重的随机选择函数, gamma为度k的指数，gamma=1即为BA网络，gmma=0为随机网络，gamma=-1为反BA网络
def weightedDegreeSelection(nodeOccurance,m,gamma):
  c = collections.Counter(nodeOccurance)
  w = np.array(c.values())**float(gamma)
  wcs = [weighted_choice_sub(w) for i in range(m)]
  s = [c.keys()[j] for j in wcs]
  return s

# 反BA机制
def rBA(n, m):
  G=nx.empty_graph(m)
  targets=list(range(m))
  repeated_nodes=[]
  source=m
  while source < n:
    G.add_edges_from(zip([source]<em>m,targets))
    repeated_nodes.extend(targets)
    repeated_nodes.extend([source]</em>m)
    targets = weightedDegreeSelection(repeated_nodes,m,-1)
    source += 1
  return G
```



### 随机增长网络和BA网络的混合

我们假设一个新的节点，以概率a随机选择老节点，以概率1-a选择度高的节点。这种情况下，会发生什么？

此时度为k的一批节点从新节点带来的m条边中，获得连边总数是

$$
(a \frac{1}{n} + (1-a) \frac{k}{\sum k}) n p_k m = (a m + \frac{1 - a}{2}k)p_k,  (28)
$$

我们可以得到

$$
\frac{p_k}{p_{k-1}} = \frac{2am + (1-a)(k-1)}{2 + 2am +(1-a)k} = 1- \frac{3-a}{2+2am+ (1-a)k} (29)
$$

和

$$
p_m = \frac{1}{1+\frac{1+a}{2}m}  (30)
$$

当k很大时，2 + 2am 相对(1-a)k来说很小，因此我们可以将Eq. (29)写作

$$
\frac{p_k}{p_{k-1}} \approx 1- \frac{3-a}{1-a} \frac{1}{k} \approx (1-\frac{1}{k})^{\frac{3-a}{1-a}}=\frac{k}{k-1}^{-\frac{3-a}{1-a}} (31)
$$

老规矩，构造Eq. (10)来展开p_k/p_m得到

$$
p_k \approx \frac{1}{1+\frac{1+a}{2}m} \frac{k}{m}^{-\frac{3-a}{1-a}}  (30)
$$

![mixedrandom_ba](http://oaf2qt3yk.bkt.clouddn.com/f3e7139fd829c8a1cbc862c5c13907bf.png)

上图展示了（1）混合模型的rank-order曲线，参数a从0变化到10（相对于模型中的0-1参数范围，为了代码中随机选择函数的方便，将a设置为0-10的整数）。（2）使用双对数坐标系下最小二乘回归拟合rank-order曲线的斜率。蓝色线（total-fit）使用全集数据拟合，绿色线（tail-fit）使用最大的100个数值拟合。绿色线效果更好，因为在a比较大时，只有分布的尾部符合幂律分布。（3）模拟数据得到的幂律指数与理论预测曲线。注意随着a接近1，度分布退化为指数函数，Eq. (18)，所以a越大估计参数越偏离理论曲线。

## 反BA网络与BA网络的混合

现在，我们假设新节点以概率a选择度低的节点，以概率1-a选择度高的节点。

此时度为k的一批节点从新节点带来的m条边中，获得连边总数是

$$
(a\frac{\frac{1}{k}}{\sum \frac{1}{k}} + (1-a) \frac{k}{\sum k}) n p_k m \approx (a \frac{2m^2 }{k} +(1-a)\frac{k}{2})p_k,  (31)
$$

可以导出

$$
\frac{p_k}{p_{k-1}} =\frac{\frac{2am^2}{k-1}+\frac{(1-a)(k-1)}{2}}{1+\frac{2am^2}{k}+\frac{(1-a)k}{2}}, (32)
$$

和

$$
p_m = \frac{2}{3ma+m+2}.  (33)
$$

当k比较大时, 2am^2/(k-1) 接近0， 因此我们可以将Eq. (33)写为

$$
\frac{p_k}{p_{k-1}} \approx\frac{\frac{(1-a)(k-1)}{2}}{1+\frac{(1-a)k}{2}}=\frac{k-1}{k+\frac{2}{1-a}}. (34)
$$

构造Eq. (10)来展开p_k/p_m得到


$$
\frac{p_k}{p_m} =\frac{p_{m+1}}{p_m}\frac{p_{m+2}}{p_{m+1}}...\frac{p_{k-1}}{p_{k-2}}\frac{p_{k}}{p_{k-1}}=\frac{m}{m+1+\frac{2}{1-a}}\frac{m+1}{m+2+\frac{2}{1-a}}...\frac{k-2}{k-1+\frac{2}{1-a}}\frac{k-1}{k+\frac{2}{1-a}}=m(m+1)...\frac{1}{k-1+\frac{2}{1-a}}\frac{1}{k+\frac{2}{1-a}}, (35)
$$

其中包含了k的项一共有h，且h满足

$$
k+\frac{2}{1-a}-h =k-1. (36)
$$

这是因为最后一项的分子是k-1，而k只取自然数，所以从尾巴往回走h项之后，k-h+2/(1-alpha)将等于k-1。于是整个数列都彼此相消，只剩下最初的h项包含m的分子和最后h项包含k的分母。所以最终的分布是幂律分布，其指数为-h。从Eq. (36) 我们得知

$$
h = \frac{3-a}{1-a}, (37)
$$

所以度分布可写成

$$
p_k \approx \frac{2m^{\frac{3-a}{1-a}}}{3ma+m+2}k^{-\frac{3-a}{1-a}}. (38)
$$

下图展示了模拟的效果与理论曲线的比较。

![mixed_reversed_ba](http://oaf2qt3yk.bkt.clouddn.com/3b61f6b4c80df0a35a94d34e6a8ebdb7.png)

如果将随机增长网络与反BA网络混合，也能得到一个模型，但因为它不具备长尾特性，所以比较trivial，我们在这里就不讨论了。

## Q&A社区中的注意力动力学

一个好的问答社区，需要平衡答案的质量与问题覆盖率。然而这两者常常是矛盾的。为了提高答案质量，需要提倡不同用户对一个问题进行多次回答，从而使好的答案脱颖而出。但是，从问题覆盖率提高的角度，这样做是在浪费用户的注意力，每个问题只回答一次才是最高效的方案。

如果我们把问题看做节点，用户在问题间的回答行为看做连边，那么一个问答社区就变成了一个随时间增长的网络。提升答案质量的策略要求度分布越不均匀约好，这样那些重要或有争议的难题才能得到足够的重视，获得很多连边（备选答案）。但提升问题覆盖率的策略却要求度分布越均匀约好，最好每个节点的度都是1，这样社区才能以最小的总注意力消耗（总答案数）覆盖尽可能多的问题。

我们推测，真实社区的增长，是对两者的一个平衡。这两个策略，落实到问答网络增长的注意力动力学上面来，就是BA策略与反BA策略的混合模型。基于这种假设，我们采集了StackOverflow(SO)的问答数据，并发现，当a=0.3时，混合模型很好地预测了问答网络的度分布。

![networks_ba-rba](http://oaf2qt3yk.bkt.clouddn.com/bab29147fcdc684639184b55c436484d.png)

上图比较了三个模型得到的网络，和SO在一周内形成的问答网络结构。为了强调度的分布，节点的大小与度平方成正比。可以看出，混合模型比BA和反BA模型都更接近真实网络。

![compare_ba-data-rba](http://oaf2qt3yk.bkt.clouddn.com/f8f706a04318b809c84f18258ace8c72.png)

上图展示了50天累积形成的SO问答网络，包含10381个问题（节点），可以看a=0.3时的混合模型很好地预测了真实的度分布。
