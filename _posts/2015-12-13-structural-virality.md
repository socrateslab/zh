---
layout: single
title: "在线扩散的结构性病毒特征"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-21.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "本文以《The Structural Virality of Online Diffusion》一文为基础，介绍了The Structural Virality在当下在线信息扩散中的特点。"
modified: 2015-12-13T11:55:22-04:00
comments: true
categories:
  - 传播网络
tags:
  - python
  - networkx
author_profile: true
author: "秦强"
---

本文以《The Structural Virality of Online Diffusion》文献为基础，通过对文献内容的介绍来阐述The Structural Virality在当下在线信息扩散中的特点，本文将按照作者简介、主要内容、主要贡献以及应用四个方面展开叙述。

# 一、人物介绍

沙拉德·戈埃尔（Sharad Goel） 美国计算社会学家，现供职于斯坦福大学管理科学与工程学院，研究领域是计算社会科学，擅长将现代计算与数据技术应用到研究和公共政策设计中，“The Structural Virality”正是由他和他的合作者2012年通过数学方法首次提出的。

邓肯·瓦茨（Duncan Watts） 现为美国纽约微软研究院的首席研究员。1998年他与史蒂夫·斯特罗加茨一起提出了“小世界网络”概念并建立“瓦茨—斯特罗加茨”模型（WS模型）。

艾什顿·安德森（Ashton Anderson） 现为纽约微软研究院计算社会科学组的博士后研究员，博士毕业于斯坦福大学计算机学院，主要研究旨趣在弥补计算机科学和社会科学之间的鸿沟。

杰克·霍夫曼（Jake Hofman） 现为纽约微软研究院研究员，之前就职于雅虎微观经济和社会系统组，研究领域为计算社会学，包括统计和机器学习在社会大数据中的应用。

# 二、主要内容

《The Structural Virality of Online Diffusion》一文，其研究思路是首先明确病毒性扩散的“结构性病毒式传播”概念以及结构特征，而后通过分析近十亿Twitter数据，将实际经验数据在不同网络结构中运行，模拟在线扩散），最后通过总结经验性观察的结果，尝试着去建构一个可以满足structural virality结构特征的简化的模型。

##  Part1

本文首先对“结构性病毒式传播（The Structural Virality）”做了严格的定义，即融合了广播和病毒传播特性的中间传播方式，不属于任一单一传播方式，并提出“结构性病毒式传播”概念不是对已有的病毒式传播概念的颠覆，而是一种补充。过往的传播生成模型将重点放在潜在的扩散机制本身，如扩散对象自身固有的传染性、扩散对象所在网络、关联过程的特性，本文对结构性病毒式传播的概念主要考察的是，有某些无法观察到的生成机制引起的可观察到的接受模型结构上独有的特征。

在将研究对象确定后，为了找出最佳辨别“结构性病毒式传播”结构的变量，本文对接受者的数量、层级数量以及结构规模分别做了比较，最终选择以“深度（depth）”作为区别病毒和广播扩散的变量，并对深度进行了反复优化，由depth&#8211;> average depth &#8211;> average distance，average distance 可以有效解决depth中的无法排除单一长链型广播结构和average depth 中单一长路径广播结构造成的数值虚高问题，并可以有效区别广播和病毒结构以及排除无效节点。

average distance(v(T)) 取自“Wiener index”，在此被定义为：树结构中全部成对节点最短路径的平均距离。概念界定清晰和衡量指标确定后，要做的就是代入实际数据中进行检验。

$$v(T)=\frac{1}{n(n-1)}\sum_{n}^{i=1}\sum_{n}^{j=1}d_{ij}$$

##  Part2

目前为止，过往研究样本选在一小群高病毒对象上，而这类经选择后的对象不仅十分稀少，还缺乏对普通病毒扩散事件的代表性。因此，本文第二个部分，用“结构性病毒式传播”概念观察近10亿Twitter推文（包括新闻、视频、图片、petition）的扩散结构，通过系统地探究Twitter近十亿内容的结构特性，估算结构性病毒层级出现频次，统计层级结构的多样性，并探究结构性病毒层级大小和结构之间的关系。 本研究样本选取方面，选自Twitter上近十亿的推文（包括外网链接），样本涵盖新闻、视频、图片、petition等主要数据，样本时间区间为2011年7月至2012年六月；数据建模基本模式：将数据中每一条内容建构一个扩散“树”（在这个“树”中可以追溯到每一接受节点的“根”节点，即信息的最初上传者）。

<strong>研究发现</strong>

这些扩散树中绝大多数仅仅传递一层即止，99%的接受节点既是根节点，也是它本身根节点的追随者。之后，作者对扩散树的选择标准做了更新，规定将研究范围缩小到最少有100个节点的tree（0.025%），由此将研究样本量缩小到了219855。

![sample_cascade](http://oaf2qt3yk.bkt.clouddn.com/a3656a7dc2c8b6b896c3afed5ba8771e.png)

图1为按v(T)值排序的一些大小在100至1000接受节点的随机样本，经分析发现：

<ul>
<li>最不具结构性病毒式结构的扩散曲线（top left）与最典型结构性病毒式扩散曲线（bottom right）相似</li>
<li>没有一个恒定的关系存在于diffusion time与structural virality之间，即各个结构增速与结构大小不一</li>
<li>一个成功的扩散事件是由病毒、广播共同作用结果，而不是之前研究中认为的广播、病毒分段（分界点为tipping point）发挥效力的结果</li>
<li>按平均距离v(T)值对这些结构的排名与通过病毒性特征进行的排名保持一致</li>
</ul>

2.  Popularity and structural virality

![structural_virality](http://oaf2qt3yk.bkt.clouddn.com/fe6cee92a6aa36929ebcdeb480aeff37.png)

针对不同类型信息的扩散过程，本文也做了一个规模和结构的对比。(见图2)

<ul>
<li>视频和图片相较于新闻和petition更加受欢迎，扩散规模更大</li>
<li>Petition的扩散结构比其他三类内容更具有结构性病毒式结构</li>
<li>最受欢迎内容、规模最大的扩散结构并不具备典型的structural viralrity，反而规模最小的内容最具structural virality，暗示着扩散规模与structural virality之间不具相关关系。</li>
</ul>

3.  Box Plot of Structural Virality

![boxplot_structural_virality](http://oaf2qt3yk.bkt.clouddn.com/bf96f000577e0f75a865d108783b78d3.png)

petition在任一扩散规模下均比其他三类信息表现出与更高的structural virality，新闻扩散的大小与结构之间有很高的相关性（见图3）。

##  Part3

作者根据先前的数据分析，尝试着构建一个简化的模型，适用于所观察到的经验数据，其总共构建了四个模型，其中主要的变量：

$$\beta =a\;constant\;of\;infectiousness$$

$$\bar{k}=the\;average\;node\;degree$$

$$\sigma ^{2}=the\;degree\;variance$$

$$r=\bar{k}\beta $$

<strong>Model 1</strong>

随机选取一个节点作为扩散的“种子”，依照传染常数β在随机网络ER（Erd˝os–Rényi）中进行扩散而形成的结构。

缺陷：不论平均网络度或者感染率是多少，扩散层级都会聚集在平均值附近（成同心圆状），这与我们所观察到的在尾部大规模扩散的实际状况不符，因此，排除model 1。

<strong>Model 2</strong>

假设Twitter上的内容扩散主要是由内容本身的趣味性和影响力决定，由此可推出model 2，传播网络仍为ER，但是考虑到model 1中的错误有可能是常数β的原因，因此在此将每条信息的传染值设为β，具体取值从幂律$$Pr(\beta -{i})\sim \beta -{i}^{-\alpha }$$，由此β值的高低就决定了其扩散范围的大小。

缺陷：此模型中会持续观察到在扩散规模与structural virality之间有很强的关联性，而这又与我们的经验数据相悖。对于这一点，作者认为这是由于ER网络的特殊性造成的，因为ER网络中大规模扩散事件必然是多重层次的。

<strong>Model 3</strong>

β为一个常数，Network为一个基本遵循Twitter内容扩散的幂律$$P(k)\sim k^{-\alpha }$$(Bakshy et al.2011）而构建的scale-free random network，这个网络的大小、节点数与我们已分析过的Twitter网络规模很接近。并得出其在probability of popular、mean structural virality、correlation between size and structural virality 都与已观测到的数据相符。

缺陷：模型结果与实际结果一个十分明显的差异就是：模型数据的四分位差（interquartile）比实际要小，即意味着实际结构更加复杂。原因可归纳为，一、没有考虑传播内容本身质量因素，而是由不变常数β表示内容质量，这样就无法确定成功与失败病毒事件在内在质量上有差别；二、此问模型没能够充分抓取到实际数据中structural virality的多样性特征。

<strong>Model 4</strong>

第四个模型中将常数β定义为从幂律中具体取值的β，结果显示此模型没能显著使结构更具多样性，反而显示structural virality 与size之间的强关联度。这是由于β值变高，会增加的是事件规模，而不是改变结构。

缺陷：β值的变化不会对扩散structural virality产生影响。

# 三、主要贡献

1.  本研究对viral communication做了新的探究，不同于以往对传播主体本身特点、传播结果的研究，本文着重试图找出了viral diffusion 在普遍意义上可能存在的结构上的特性，不同于其他网络的特性，为日后的研究提供了新思路；

2.  本研究通过对Twitter上近十亿数据的分析得出structural virality本身结构不会随着扩散规模的增大而变得更明显；

3.  本研究印证了社交网络中，99%的扩散仅仅停留在第一重上，少之又少的事件可以大范围扩散起来；

4.  本文通过对数据分析得出，过往研究中认为的tipping point现象并不符实，即一次成功的viral diffusion中先是广播起作用，达到某一点后再由病毒扩散主导，本研究中发现，无论什么类型的扩散事件，从头至尾都是广播和病毒共同起作用；

5.  在任意的一个信息扩散网络中，任意两个分享事件之间平均距离会随着树型图规模增长而增长。

# 四、python程序模拟

1、v(T)的计算方法 $$v(T)=\frac{1}{n(n-1)}\sum_{n}^{i=1}\sum_{n}^{j=1}d_{ij}$$ 平均最短路径长度是衡量信息扩散结构structural virality特征的重要标准，v(T)越大， structural virality特征越明显。其计算方法可通过Python中“average_shortest_path_length”包完成。 例如，我们生成一个12个节点的有向网络G，其平均最短路径长度

```python
import networkx as nx
import matplotlib.pyplot as plt

G=nx.DiGraph()
G.add_edges_from([(1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (2, 7), (2, 8), (2, 9), (7, 10),(7,11),(10,12),(7,9)])
pos=nx.spring_layout(G, iterations=5000)
plt.figure()
nx.draw(G,pos,with_labels = True)

nx.average_shortest_path_length(G)
A1=nx.average_shortest_path_length(G)
print "%.2f" % A1
#结果输出为1.13
```

![networkx_network_example](http://oaf2qt3yk.bkt.clouddn.com/8ef22599d9e6548320c6e967c690f167.png)

2、depth和average depth的反例

<strong><em>depth反例</em></strong>

depth仅以扩散的深度来作为考量扩散结构复杂程度的依据，这一标准过于简单，对于大规模、复杂的扩散过程是可以应用的，但是对于某些较简单的扩散过程反而有bug，如某信息的扩散仅仅沿着一条线路向下一个一个垂直传递，没有左右的枝杈节点，这种状况就会使得depth极高，但根本不具structural virality。

```python
#depth反例
G=nx.DiGraph()
G.add_edges_from([(1, 2), (2, 3), (3, 4), (4, 5), (5, 6), (6, 7), (7, 8), (8, 9), (9, 10), (10, 11), (11,12)])
pos=nx.spring_layout(G, iterations=5000)
plt.figure()
plt.savefig("depth.png")
nx.draw(G,pos,with_labels = True)
```

![depth_exmaple](http://oaf2qt3yk.bkt.clouddn.com/29ee2bdf0c7a4db2729cd1a168b8dba6.png)

<strong><em>average depth反例</em></strong>

average depth 相较于depth来说，可以更好的区分出不具结构性的扩散网络，并且可以有效区分广播结构和多层传染结构，但是，对于某些扩散结构它还是不能很好识别，例如，如果某一信息从根节点传出后沿着某一条路径扩散了很远，但是在这过程中并没有产生其他分支路径，而是在达到某一点后突然四面八方的进行多层传染扩散。这样的情形下，扩散过程average depth会很高，但是并不是典型的structural virality。

```python
#average depth反例
G=nx.DiGraph()
G.add_edges_from([(1, 2), (2, 3), (3, 4), (4, 5), (5, 6), (5, 7), (5, 8), (6, 9),(6, 10), (7, 11),(7, 12)])
pos=nx.spring_layout(G, iterations=5000)
plt.figure()
plt.savefig("average_depth.png")
nx.draw(G,pos,with_labels = True)
```

![depth_example_2](http://oaf2qt3yk.bkt.clouddn.com/4540f9bf6c0e869f3905af2256c0997a.png)

2、ER随机网络模拟

```python
import networkx as nx
import matplotlib.pyplot as plt

n=20
p=0.2
ER = nx.random_graphs.erdos_renyi_graph(n,p)  #生成包含20个节点、以概率0.2连接的随机图
pos = nx.shell_layout(ER)          #定义一个布局，此处采用了shell布局方式
nx.draw(ER,pos,with_labels=True,node_size = 500)
plt.savefig("ER111.png")
plt.show()
```

![depth_example_3](http://oaf2qt3yk.bkt.clouddn.com/ec477319165fcc657431fa342c7b481f.png)
