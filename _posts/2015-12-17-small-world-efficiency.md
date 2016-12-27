---
layout: single
title: "小世界网络的输运效率"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-13.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "Latora（2001）的主要贡献
对于小世界网络的描述，可以简化为efficiency（记作E）一个变量即可，且efficiency本身有其物理意义。efficiency衡量了网络信息交换的效率。"
modified: 2015-12-17T11:55:22-04:00
comments: true
categories:
  - 传播网络
tags:
  - watts
author_profile: true
author: "陈志聪"
---


{% include toc title="Table" icon="file-text" %}


Latora V, Marchiori M.(2001)发表了题为“小世界的输运效率”的论文，讨论了小世界网络的效率（efficiency）概念，efficiency衡量了一个小世界网络信息交换的效率。Latora通过分析神经网络、传播及交通网络，得出的结论是：这些网络得以建立的一般准则（general principle）就是高效率的小世界法则。


##  Watts(1998)的工作

复杂系统都可以使用网络模型的描述，因此刻画网络的结构属性便成了许多研究的工作重点。在Watts等（1998）年的论文当中，他们使用了<strong>平均路径长度</strong>和<strong>聚集系数</strong>这两个量来刻画小世界网络的结构属性。他们定义了图G，记其节点数为N，边数为K。给出了图G需要满足的三个条件：

<ul>
<li>图G的边没有权重（unweighted）</li>
<li>图G是稀疏的（sparse），满足 $K &lt;&lt; N(N-1)/2$</li>
<li>图G是连通的（connected） </li>
</ul>
对于这样的图，其节点的度（degree）的平均值为$$k = \frac{2K}{N}$$ 其平均路径长度L定义为 $$L = \frac{1}{N(N-1)} \sum_{i\neq j}^{ }d_{ij}$$ 其聚集系数C定义为 $$C = \frac{1}{N} \sum_{i}^{ }C_{i}$$

##  Latora（2001）的主要贡献
<ol>
<li>对于小世界网络的描述，可以简化为efficiency（记作E）一个变量即可，且efficiency本身有其物理意义</li>
<li>1/L和C分别可以看做是在global和local尺度上对E的近似值</li>
<li>对于Watts(1998)中给出的对图G的限制(unweightedness,sparseness,connectedness)可以摒弃，图G可以是带权的、非稀疏的、非连通的。</li>
</ol>
Latora给出了对任意一个节点数为N,边数为K的图G的考察方法，他们采用两个矩阵来描述它，一个是把图G作为unweighted graph求得的邻接矩阵$a_{ij}$，另一个是矩阵$l_{ij}$，简单的说就是一个权重矩阵，这里的权重可以是两个节点之间实际地理上的距离，也可以指Internet上两个路由器之间交换一个包的信息所花的时间。

##  最短带权重路径长度
Latora所定义的两点之间的最短路径长度矩阵$d_{ij}$由$a_{ij}和l_{ij}$算出，它<em>更准确的表达</em>是任意两点i,j之间<strong>最短的带权路径长度</strong>，当无权重时，可以认为权重值为1。文中的原句为

<blockquote>
The shortest path length $d_{ij}$ between two generic points i and j is the smallest sum of the physical distances throughout all the possible paths in the graph from i to j.

</blockquote>
边的权重必须是数值类型的，最短带权重路径长度距离是最小的边的权重之和。（Edge weight attributes must be numerical. Distances are calculated as sums of weighted edges traversed. 参见networkx对single_source_dijkstra_path的介绍 ）

由于任意两点之间不一定都存在连边，所以$$d_{ij} \geq l_{ij},\forall i,j$$当i和j之间存在一条边时，取等号。

假设这个系统是并行的，每个节点通过与之相连的边同步地在网络上传播信息，则i,j两点之间的efficiency（记为$\epsilon_{i,j}$）可定义为 $\epsilon_{i,j}=1/d_{i,j}, \forall i,j$，对于图G中的所有节点（global）而言，图G的平均效率（average efficiency）为 $$E(G)= \frac{\sum_{i\neq j \in G}^{ }\epsilon_{ij}}{N(N-1)} = \frac{1}{N(N-1)}\sum_{i\neq j \in G}^{ }\frac{1}{d_{ij}}$$

为了将E(G)归一化，我们令 $G_{id}$ 为一个完全图，则 $$E(G_{id})= \frac{\sum_{i\neq j \in G}^{ }\epsilon_{ij}}{N(N-1)} = \frac{1}{N(N-1)}\sum_{i\neq j \in G}^{ }\frac{1}{l_{ij}}$$ 用E(G)除以$E(G_{id})$，得到归一化的全局的输运效率 $$0 \leq E_{glob}(G) \leq 1 $$

与$E_{glob}$相对应的，在一个非连通图中，对每一个节点i而言（local），给出$E_{loc}$的定义如下$$E_{loc} = \frac{1}{N} \sum_{i \in G} E(G_{i})$$ $G_{i}$为<strong>由i的相邻节点构成的子图</strong>，因为$i \notin G_{i}$，所以它体现了一个系统的容错性，也即当节点i被移除时，与i相邻的那些节点之间的运输效率


##  对efficiency的讨论

下面讨论E(G)和L、C之间的对应关系，$E_{glob}$和1/L相对应，$E_{loc}$与C相对应。

$E_{glob}$和1/L之间的差别在于，$E_{glob}$反映了一个并行工作的网络中的输运效率（网络中各个节点同时在进行信息传播），而1/L反映了一个串行工作的网络中的输运效率，（网络中只有一条信息流），当网络中节点之间距离差别不大时，1/L可以看做是对$E_{glob}$的近似值，这也是为什么L在无权重网络中能够work well的原因。尽管如此，$E_{glob}$相比于1/L还是有比较明显的优势，举例而言，在一个Internet中，如果有个别几台计算机之间有着极慢的信息交换速率，而其他大部分计算机的信息交换效率都很高，那么这几台较慢的计算机的影响完全可以被忽略，不会影响整体网络的输运效率，但在计算时，L会趋向于$+\infty$，1/L趋向于0，这显然与事实不符，而$E_{glob}$则可以很好地反映出网络的整体效率。

聚集系数C反映了图中节点的聚集程度，当图G的大部分子图$G_{i}$是非稀疏时，C就是$E_{loc}$的近似值。总的来说，$E_{loc}$代替了聚集系数C，反映了系统中某个节点所在的子图的输运效率，以及网络系统的容错性。

模仿Watts(1998)文中随机重连(rewiring randomly)方法，对给定N=1000，K=20的图，以不同的p随机重连，求得相应得到的图的全局和局部效率$E_{glob}$和$E_{loc}$，作出图如下



![network_efficicency_loc_global](http://oaf2qt3yk.bkt.clouddn.com/2033eed62d5042486164ff166048dfc9.png)

从图中的走势可以看出，$E_{glob}$和$E_{loc}$和Watts（1998）文中所用的L和C的走势相似，可见其对应关系。


##  在真实网络中的实验

### 神经网络
<table>
<thead>
<tr>
<th align="center">\</th>
<th align="center">$E_{glob}$</th>
<th align="center">$E_{loc}$</th>
</tr>
</thead>
<tbody>
<tr>
<td align="center">Macaque</td>
<td align="center">0&#46;52</td>
<td align="center">0&#46;70</td>
</tr>
<tr>
<td align="center">Cat</td>
<td align="center">0&#46;69</td>
<td align="center">0&#46;83</td>
</tr>
<tr>
<td align="center">C.elegans</td>
<td align="center">0&#46;46</td>
<td align="center">0&#46;47</td>
</tr>
</tbody>
</table>
文中研究了Macaque和Cat大脑皮层的神经解剖学结构和C.elegans简单的神经系统中神经元之间的连接，得出它们的全局效率和局部效率都较高，而且在两者间取得了较好的平衡，从中可见生命系统的设计之精巧。

### 传播网络
<table>
<thead>
<tr>
<th align="center">\</th>
<th align="center">$E_{glob}$</th>
<th align="center">$E_{loc}$</th>
</tr>
</thead>
<tbody>
<tr>
<td align="center">WWW</td>
<td align="center">0&#46;28</td>
<td align="center">0&#46;36</td>
</tr>
<tr>
<td align="center">Internet</td>
<td align="center">0&#46;29</td>
<td align="center">0&#46;26</td>
</tr>
</tbody>
</table>
WWW的数据来源：<a href="http://www3.nd.edu/~networks/resources.htm">http://www3.nd.edu/~networks/resources.htm</a>

Internet的数据来源：<a href="http://moat.nlanr.net">http://moat.nlanr.net</a>

虽然WWW（World Wide Web）是一个人工的虚拟的网络，而Internet是一个物理上存在的网络，但两者的$E_{glob}$大小极其相近，可见其全局效率是差不多的，而WWW的局部效率明显高于Internet可以解释为，万维网上存在大大小小的社区，同一个社区中的网页之间很容易产生大量的链接，与此同时，同一个网站根目录下的网页之间的也往往会存在大量的链接，这都会导致万维网上的局部效率大大提高。


### 交通运输网络
<table>
<thead>
<tr>
<th align="center">\</th>
<th align="center">$E_{glob}$</th>
<th align="center">$E_{loc}$</th>
</tr>
</thead>
<tbody>
<tr>
<td align="center">MBTA (unweighted)</td>
<td align="center">0&#46;10</td>
<td align="center">0&#46;006</td>
</tr>
<tr>
<td align="center">MBTA (weighted)</td>
<td align="center">0&#46;63</td>
<td align="center">0&#46;03</td>
</tr>
</tbody>
</table>
MBTA数据来源：<a href="http://www.mbta.com/rider_tools/developers/default.asp?id=21895">http://www.mbta.com/rider_tools/developers/default.asp?id=21895</a> 对此网络的分析详见下一个标题


##  波士顿地铁网络的输运效率

真实世界的输运网络（transportation networks）是小世界的吗？基于上述理论，Vito Latora 等（2002）于次年又发表了一片论文，专门讨论分析了波士顿地铁网络的结构（小世界）。

随机网平均直径低，规则网聚类系数高。小世界网络在平均路径长度方面接近随机网，而在聚类系数方面接近规则网。Latora等认为我们对于小世界的两种衡量方式（平均直径L和聚类系数C）有缺陷（ill-defined），因为仅仅强调了链接是否存在，而忽略了链接的<strong>权重</strong>，比如链接的实际长度（the physical length of the link）。他们试图提出一种考虑权重的衡量小世界特征的测量:邻接矩阵$a_{ij}$表示任意两个节点i、j之间是否有链接;$l_{ij}$ 表示任意两个节点i、j之间的权重（比如地铁站之间的空间距离;使用邻接矩阵 $a_{ij}$ 可以得到节点间的最短路径矩阵 $d_{ij}$。

此时，无法算出聚类系数，因为很多地铁站只有两个邻居，算出的平均直径的信息也很少，$$\varepsilon_{ij} = \frac{1}{d_{ij}} $$ 表示输运效率，可以在globa和local两个层面计算，分别对应平均路径长度L和聚类系数C。当两个节点无链接时，其$d_{ij}$无穷大，$\varepsilon_{ij} = 0$。避免了计算平均路径长度无穷大的问题。同时可以定义输运成本$cost = \frac{\sum_{i\neq j} a_{ij}*l_{ij}}{\sum_{i\neq j}l_{ij} }$。如此计算波斯顿地铁的MBTA全局输运效率为0.63，局部输运效率为0.03，成本为0.002。即网络整体输运效率可以达到理想情况的63%，但是局部输运效率很差，不过整个网络的成本很小。如果加上公交网络MBTA+bus，全局效率上升为 0.72，局部效率大幅度上升为0.46，花费的成本仅仅上升为0.004。


##  编程实现

利用Python中的networkx包，可以比较方便地实现对网络中efficiency的计算。

<a href="http://www.quanturb.com/data.html">http://www.quanturb.com/data.html</a>页面提供了2009年世界几个主要大城市的地铁网络数据，以此为基础，计算的结果见

<a href="https://github.com/zhicongchen/datalab/blob/master/subwayNetworkEfficiency.ipynb">https://github.com/zhicongchen/datalab/blob/master/subwayNetworkEfficiency.ipynb</a>

<iframe src="http://nbviewer.ipython.org/github/zhicongchen/datalab/blob/master/subwayNetworkEfficiency.ipynb
" width="1000" height="4000"> </iframe>

##  参考文献
Latora V, Marchiori M.(2001) Efficient behavior of small-world networks[J]. Physical review letters, 2001, 87(19): 198701.

Watts D J, Strogatz S H.(1998) Collective dynamics of ‘small-world’networks[J]. nature, 393(6684): 440-442.

Vito Latora（2002）Is the Boston subway a small-world network? Physica A
