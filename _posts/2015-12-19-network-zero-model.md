---
layout: single
title: "复杂网络零模型构造的方法及应用"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-8.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "关心真实网络和该网络随机化零模型比较后的相对值，通过相对结果的统计结果来说明实证网络的性质，此时如何构造出一个合理的复杂网络零模型作为参照物就变得非常重要。"
modified: 2016-12-19T11:55:22-04:00
comments: true
author_profile: true
author: "许小可"
---

{% include toc title="Table" icon="file-text" %}

<p><em>复杂网络</em>是指由数量巨大的节点在一定时间尺度上关联影响共同构成的<code>复杂系统</code>，网络科学的研究中重点关注复杂网络中存在的<code>非平凡性质</code>以及这些特殊性质的产生<code>机理</code>。在实证网络的研究中，研究者一般会使用多种<code>统计量</code>来刻画复杂网络的性质，如描述静态无权网络的常见统计量有平均度、度分布、匹配系数、聚类系数和平均路径长度等。</p>

<p>鉴于各种统计量的绝对数值往往是<code>无量纲</code>的，而且由于不同复杂网络的规模大小各异、结构千差万别，仅仅计算出上述统计量的绝对数值来判断网络的宏观特性不仅定量分析上不够精确，有些时候甚至连定性分析的结果都不准确。因此在研究中学者们往往不仅关注实际网络统计量的绝对值，更关心真实网络和该网络随机化零模型比较后的相对值，通过相对结果的统计结果来说明实证网络的性质，此时如何构造出一个合理的复杂网络零模型作为参照物就变得非常重要。</p>

## 一、生成随机网络方法

<p>通常，我们把与一个实际网络<code>具有某些相同性质的随机网络</code>称为该实际网络的随机化副本，这类随机化网络在统计学上被称为<code>零模型</code>。一个好的复杂网络零模型能为原始网络提供一个准确的参照，结合统计量指标就可以准确描述出实际复杂网络的非平凡特性。复杂网络的零模型构造方式主要有两种：网络模型方法和随机置乱的方法。</p>

<p>网络模型的方法是:</p>
<ul>
<li>
<p>首先计算实证网络的一些重要统计量</p>
</li>
<li>
<p>然后根据这些统计量的数值来推断网络的形成机制</p>
</li>
<li>
<p>最终通过模拟网络的形成机制来生成和原始网络某些统计特征类似的新网络，即原始网络的零模型。</p>
</li>
</ul>

### 优点和缺点
<p>网络模型方法的<code>优点</code>是可以从无到有生成零模型网络，而且生成网络的规模等参数可以人为控制，具有很好的灵活性。</p>

<p>网络模型方法的<code>缺点</code>是一方面建模方法对真实网络生成机制的推断不一定是正确的，使用模型从无到有生成实际网络零模型的时候往往只能保持少量特征和实际网络相似，而在更多的特征上两者还是有很大差异，既能保持形式简洁又能深刻描述复杂系统内在的物理机制的网络模型很难生成。另一方面，基于模型方法来生成的零模型往往对于真实网络的某些统计特征的模拟是<code>有偏的</code>，即基于零模型生成的多个网络的某个统计量往往都大于（或小于）实际网络，我们在使用的时候无法判断出模型的这种有偏特性会对真实网络其他特性有哪些方面的影响。</p>

## 二、网络置乱方法

<p>基于置乱方式产生的复杂网络零模型不是一个从无到有生成新网络的过程，这种方法主要是将实际网络的数据进行随机化后得到的。置乱算法既可以将网络上的连接关系进行<em>随机化断边重连</em>，也可以在保持原有连接的前提下<em>随机化某些因素</em>。这种由原始数据直接生成新数据的思想不仅在复杂网络领域得到广泛应用，也是<em>时间序列</em>处理领域的常用方法。</p>

<p>基于置乱方式产生的复杂网络零模型数据通过使用不同的约束条件，可以保持或破坏实际网络数据多尺度的时变和拓扑性质。置乱算法不仅仅能够保持和破坏网络的平均度、度分布、匹配特性、聚类特性等，还可以任意地保持和破坏网络的权重分布和时变特性。</p>

<blockquote>
<p>置乱算法不但能让研究者细致分析网络的不同特性，而且这种随机化方法不需要高深的理论，很容易理解和编程实现。因此它为实际网络提供了一套从“形似”到“形神兼备”的随机化参照物，在有些问题的研究中，它甚至是唯一的零模型构造方法，尤其在社交网络和计算传播学研究中，由置乱算法产生的随机模型在众多研究中有实际应用。</p>
</blockquote>

## 三、零模型的意义

<p>网络零模型研究的意义主要有以下两点：一是可以检测的非平凡性质，二是对这些性质产生的原因进行探究。一个好的网络零模型能为原始网络提供一个准确的基准，结合统计量指标就可以准确描述出实际复杂网络的非平凡特性以及这种非平凡特性的来源。若实证网络和最简单的零模型在性质上没有差别，那么说明该网络没有非平凡性质。若已知实证网络和最简单的零模型在性质上具有统计意义上的差别，则说明该网络具有非平凡性质。对于这样的网络，我们下一步应该检测这种非平凡性质的来源。这时候，我们应该从简单到复杂，从低到高逐渐来提高零模型和实证网络的吻合程度。</p>

<p>传统意义上的零模型是在缺乏实证参照时构建出来的参照对象，它应该尽量不包含我们关心的机制或变量而保留其他特征，在构造复杂网络零模型时我们也采用了相似的方式。比如，在研究网络同配性质时，应该尽可能在保留原网络低阶性质基础上充分随机化，这样才能看出实际网络是否有足够的异于随机网络的同配性质。如果随机化不够，零模型带有过多的实际网络的同配特性，则由于无法在统计上区分两者而导致否定实际网络的同配性。</p>

<p>鉴于置乱算法产生复杂网络零模型的重要性，在本书中我们将整理和总结无权网络、符号网络、加权网络、时变网络、双层网络和空间网络上经常使用的各种置乱算法，同时简单介绍了这些算法在社交网络和计算传播学的实际应用。通过对这些置乱算法的分析和比较，有助于社交网络以及传播学领域的学者正确使用置乱算法来产生社交网络零模型，在参考零模型的前提下合理计算各种统计量的相对值，进一步深化我们对各种信息扩散系统的理解和利用。</p>

## 第二章 无权网络零模型的构造及应用
<p>主要介绍无权网络零模型的分类以及零模型的产生过程。无权无向网络的零模型产生方法有两种：</p>
<ul>
<li>
<p>一种是基于网络模型的方法，基于网络模型生成的零模型网络可分为ER随机图和配置模型两种方式，其中ER随机图一般只能产生0阶零模型，而配置模型可产生1阶、2阶或更高阶零模型。</p>
</li>
<li>
<p>另一种是将原始网络进行置乱(断边重连)的方法，原始网络断边重连既可以进行随机断边重连，也可以使用有倾向性的断边重连。随机断边重连可以产生0、1、2、2.5阶网络零模型，其中1阶零模型可以用来检测原始网络的度匹配特性。</p>
</li>
</ul>
<p>有倾向性断边重连有两方面的应用：</p>
<ul>
<li>
<p>一是可用来检测网络是否具有富人俱乐部特性，</p>
</li>
<li>
<p>二是可以用来检测网络的匹配特性。</p>
</li>
</ul>

<p>无权有向网络的零模型只介绍一种构造方式，即将原始网络断边重连，一般使用该方法来产生的1阶零模型，适用于检测有向网络中节点与节点之间的出入度匹配特性。</p>

## 2.2 不同阶数网络零模型的定义

<p>使用网络零模型主要的目的是检测实证网络的非平凡特性，这就需要从粗糙到精确逐步逼近原始网络的性质。Mahadeven 等为了逐步逼近实证网络，根据原始网络的基本特性，可将网络中的基本组成单元分成不同的小模块如图 2-3(a)所示，最左端为原始网络，右端从右到左依次介绍了产生不同阶数的零模型所需要原始网络的基本性质，从而引入了不同阶数网络零模型的概念[1, 2]，如图 2-3(b)所示。不同阶数网络零模型之间并不是独立的，按照约束条件从少到多，存在一种包含关系，即 ，任何一个 n阶零模型都会包含(n-1)阶零模型的性质<a href="http://computational-communication.com/wp-content/uploads/2015/12/null_model_program.zip">3</a>。</p>

<p>0 阶零模型是最简单也是最随机化的网络零模型，只需要与原始网络具有相同的节点数和平均度。平均度k是指原始网络中所有节点的度的平均值，设m为原始网络连边的数量，n为原始网络节点的数量，则k = 2m/n 。</p>

<p>1 阶零模型与原始网络不但具有相同的节点数、相同的平均度，更重要的是具有相同的节点度分布p(k)，度分布是指原始网络中节点度的概率或数目的分布。若n(k)为原始网络中度为k的节点的数目，则度分布为p(k)= n(k)/n 。1 阶零模型主要是保证与原始网络具有相同的节点度分布。</p>

<p>2 阶零模型与原始网络具有相同的联合度分布$p(k_{1}, k_{2})$ ,联合度分布是指每条边两端连接节点的度值数目(概率)。若$m(k_{1}, k_{2}$为度为$k_{1}$和$k_{2}$的节点之间连边的总数，则$ p(k_{1}, k_{2}) = \frac{m(k_{1}, k_{2}) \mu(k_{1}, k_{2}) }{2m} $ 其中，若$k_{1} = k_{2}$,则$\mu(k_{1}, k_{2}) = 2$, 否则$\mu(k_{1}, k_{2})=1$。</p>

<p>2.25 阶零模型是根据原始网络中的联合度分布和平均聚类系数这两个物理属性构造的，要求与原始网络具有相同的联合度分布$p(k_{1}, k_{2})$和平均聚类系数$\bar{C}$。假设网络中的一个节点i有$m_{i}$条边将它和其他节点相连，这$m_{i}$个节点就称为节点i的邻居节点。显然，在这$m_{i}$个节点之间最多可能有$\frac{m_{i}(m_{i} &#8211; 1)}{2}$条边。$m_{i}$个节点之间实际存在的边数$M_{i}$和总的可能边数$\frac{m_{i}(m_{i} &#8211; 1)}{2}$之比就定义为节点i的聚类系数$C_{i}$，即 $\frac{2M_{i}}{m_{i}(m_{i} &#8211; 1)}$。平均聚类系数$\bar{C}$定义为在原始网络中，所有节点的聚类系数的平均值，即$\bar{C} = \frac{1}{N}\sum_{i}^{}C_{i}$</p>

<p>2.5 阶零模型与原始网络具有相同的联合度分布$p(k_{1}, k_{2})$和度相关的平均聚类系数$\bar{C}(k)$，即$\bar{C(k)} = \frac{1}{N_{i}}\sum_{i\in N_{k}}^{}C_{i}$。其中，$N_{k}$表示度为k的节点的集合。</p>

<p>3 阶零模型与原始网络具有相同的联合边度分布$p(k_1, k_2, k_3)$ ，联合边度分布考虑到三个节点之间的相互连接性，主要有两种情况，一种是开三角形，即 3 个节点用 2 条边来连接称为$p_{\Lambda}(k_1, k_2, k_3)$;另一种是闭三角形如图 2-4(b)所示，3 个节点形成一个环称为$p_{\Delta}(k_1, k_2, k_3)$ 。与原始网络具有相同的联合边度分布$p(k_1, k_2, k_3)$，就要求零模型网络和原始网络具有相同的开三角形和闭三角形分布。</p>

<p>随着生成零模型的约束条件逐步增加，构造的高阶零模型比低阶模型更接近于原始网络，因此精确的 3 阶零模型比 0，1，2，2.25 和 2.5 阶零模型更接近于原始网络。以此类推下去，理论上我们还可以定义更高阶的零模型<a href="http://computational-communication.com/wp-content/uploads/2015/12/Snip20151220_27.png">3</a>。随着约束条件越多，可以被置乱的连边数也就越少，生成的网络零模型越接近于原始网络，但是这样进行连边置乱也就越困难。对于 3 阶网络零模型，该零模型受到的约束条件已经很多，很多情况下我们不能在一个有限的计算时间内生成相应的零模型，因此不具备实用性，2.5 阶零模型是现在能够实现的最高阶的实用零模型[1, 2]。因此，在本文中我们重点介绍可以将原始网络进行较高程度随机化的 0-2.5 阶网络 零模型。</p>
<blockquote>
<p>构造静态无权网络零模型的方法主要有基于模型的 ER 随机图、配置模型和基于随机断边重连这 3 种。</p>
</blockquote>

## 2.3 基于 ER 随机图的 0 阶零模型
<p>此外，我们也可以采用随机断边重连的方式产生 0 阶零模型，但是无论采用哪种方式，0 阶零模型只和原始网络具有相同的节点数和边数，生成的网络结构随机性很强，性质和原始网络相差较大。ER 随机图的生成过程可以使用基于 Python 语言的 NetworkX 包来实现，具体语句为：</p>

```python
import networks as nx
n = 1000
p = 0.2
G = nx.random_graphs.erdos_renyi_graph(n, p)   
```
<p>其中，输入的参数n为原始网络的节点个数, 指定生成边的概率p ， p值应为原始网络的连边数m与节点数n平方的比值，即$p = \frac{2m}{n^2}$ 。因此，给定一个网络G0，通过ER随机图的方法构造0阶零模型的方法如下：</p>

```python
def ER_model(G0):
    n=len(G0.nodes())
    m=len(G0.edges())
    p=2.0*m/(n*n)
    G = nx.random_graphs.erdos_renyi_graph(n, p, directed=False)
    return G
```
## 2.4 基于配置模型的零模型

<blockquote>
<p>配置模型是在 ER随机图的基础之上进行扩展产生的一种广义随机图。由配置模型生成零模型的基本思想是：根据产生不同阶数零模型所需要的基本特性，将原始网络拆成相应的含有某种特性的基本子图，并通过不同的约束条件将基本子图重新随机组合到一起的过程。</p>
</blockquote>
<p>为了比 ER 随机图更精确地拟合原始网络，构造出与真实网络度分布相同的零模型，Molloy等提出了广义随机图，也就是我们熟知的配置模型。</p>
<ul>
<li>
<p>1 阶配置模型中通过给定原始网络的度序列来构造零模型网络</p>
</li>
<li>
<p>2 阶配置模型通过给定原始网络中的联合度分布序列来构造零模型网络</p>
</li>
<li>
<p>3 阶配置模型更具体的给定了每个节点中边角的分布情况，即原始网络中的“线”和“角”序列来构造零模型网络</p>
</li>
</ul>

### 2.4.1 基于配置模型的 1 阶零模型

<p>NetworkX 算法包中已经实现了网络的 1 阶配置模型，假定原始网络为 G，应首先调G0.degree().values()方法得到原始网络的度序列，然后根据该度序列生成配置网络图 G。具体代码为：</p>

```python
import network as nx
def config_model(G0):
    degree_seq = list(G0.degree().values())
    G = nx.configuration_model(degree_seq)
G1 = config_model(G0)
```

### 2.4.2 基于配置模型的 2 阶零模型
<p>2 阶零模型网络要求与原始网络具有相同的联合度分布，使用配置模型也可以生成原始网络的 2 阶零模型。假定原始网络有m条边，首先我们将该网络拆成m个子图，每个子图为两个节点{i,j}配对的形式。然后随机选取一个子图，并将子图中度值为$k_i$的节点i视为起始节点。随机的在网络中挑选$k_i &#8211; 1$个子图，并且每个子图中至少含有一个度值为$k_i$的节点，最后将这$k_i$个节点重新组合成一个新的度为$k_i$的节点。持续随机选取一个分支节点作为起始节点重复上述过程，直到将所有的子图都重新组合就完成了 2 阶零模型的生成。</p>

### 2.4.3 基于配置模型的 3 阶零模型
<p>许多实际网络都具有明显的聚类特性，而实际网络的高聚类性却没有在低阶配置模型，如 0 阶、1 阶和 2 阶模型中体现出来。为了解决这一缺陷，Newman 等提出了能够保持实际网络聚类特性的零模型，这也就是下面要介绍的 3 阶配置模型[13]。</p>
<p>在 3 阶零模型中将原始网络分成“线”和“角”两种基本元素，这种形式的拆分保证了网络中各节点的聚类系数不变。我们定义$s_i$为与节点i相连的不构成三角形的单条边的数目，$t_i$为节点i所参与的三角形中角的数目。因此，对于每个节点都可以得到它的联合“线”和“角”序列，即${s_i, t_i}$，每一个线角序列也可以称为一个线角子图。在给定网络联合线角序列的前提下，可以随机选取一对线连接它们形成一条连边，也可以随机选择不是同一节点的三个角连接它们形成完整的三角形。上述线和角聚合的过程可以同时进行，也可以随机进行，重复聚合过程用完所有的线角子图后就生成了 3 阶零模型。</p>

## 2.5 基于随机断边重连的零模型
<p>用 ER 随机图或配置模型的方法构造的零模型是从无到有生成新网络的过程，而用置乱算法构造的零模型则是将原始网络随机化的过程[16, 17]。</p>

### 2.5.1 基于随机断边重连的 0 阶零模型
```python
def random_0k(G0, nswap=1, max_tries=100):    #基于随机断边重连的0阶零模型
    G = copy.deepcopy(G0)      
    if nswap<max_tries:
            raise nx.NetworkXError("Number of swaps < number of tries allowed.")
    if len(G) < 3:
        raise nx.NetworkXError("Graph has less than three nodes.")
    n = 0
    swapcount = 0
    while swapcount < nswap:
        u,v = random.choice(G.edges())      #随机选网络中的一条要断开的边
        x,y = random.sample(G.nodes(),2)    #随机找两个不相连的节点
        if (x,y) not in G.edges() and (y,x) not in G.edges():
            G.remove_edge(u,v)              #断旧边
            G.add_edge(x,y)                 #连新边
            swapcount+=1
        if n <= max_tries:
            e=('Maximum number of swap attempts (%s) exceeded '%n +
            'before desired swaps achieved (%s).'%nswap)
            print e
            break
        n += 1
    return G

def random_0kc(G0, nswap=1, max_tries=100): #保持连通性的情况下基于随机断边重连的0阶零模型
    """
    在random_0k()的基础上增加连通性判断，若置乱后的网络不保持连通性则撤销该置乱操作
    注：G0为连通网络
    """
    G = copy.deepcopy(G0)
    if nswap<max_tries:
            raise nx.NetworkXError("Number of swaps < number of tries allowed.")
    if not nx.is_connected(G):
        raise nx.NetworkXError("Graph not connected")
    if len(G) < 3:
        raise nx.NetworkXError("Graph has less than three nodes.")
    n=0
    swapcount=0
    while swapcount < nswap:
        swapped = []
        u,v = random.choice(G.edges())      #随机选网络中的一条要断开的边        
        x,y = random.sample(G.nodes(),2)    #随机找两个不相连的节点
        if (x,y) not in G.edges() and (y,x) not in G.edges():
            G.remove_edge(u,v)              #断旧边
            G.add_edge(x,y)                 #连新边
            swapped.append((u, v, x, y))
            swapcount+=1
        if not nx.is_connected(G):  
            while swapped:
                (u, v, x, y) = swapped.pop()
                G.remove_edge(x,y)          #撤销连新边操作
                G.add_edge(u,v)             #撤销断边操作
                swapcount -= 1
        if n <= max_tries:
            e=('Maximum number of swap attempts (%s) exceeded '%n +
            'before desired swaps achieved (%s).'%nswap)
            print e
            break
        n+=1
    return G
```

### 2.5.2 基于随机断边重连的 1 阶零模型
<p>由于在 networkX 算法包中已经编写了 nx.double_edge_swap()方法完成从原始网络中任选两条边进行断边重连，因此基于随机断边重连生成 1 阶网络零模型比较容易，具体程序如下所示：</p>

```python
G = nx.double_edge_swap(G0, nswap, max_tries)

def random_1k(G0, nswap=1, max_tries=100):  #随机断边重连的1阶零模型
    """
    随机取两条边 u-v 和 x-y, 且节点u和x,v和y无连边, 则断边重连
    """
    if nswap<max_tries:
            raise nx.NetworkXError("Number of swaps < number of tries allowed.")
    if len(G0) < 4:
        raise nx.NetworkXError("Graph has less than four nodes.")
    G = copy.deepcopy(G0)
    n=0
    swapcount=0
    keys,degrees=zip(*G.degree().items())
    cdf=nx.utils.cumulative_distribution(degrees)  
    while swapcount < nswap:
        (ui,xi)=nx.utils.discrete_sequence(2,cdistribution=cdf)
        if ui==xi:
            continue
        u=keys[ui]
        x=keys[xi]
        v=random.choice(list(G[u]))
        y=random.choice(list(G[x]))
        if v==y:
            continue
        if (y not in G.neighbors(u)) and (v not in G.neighbors(x)) and ((u,v) in G.edges()) and ((x,y) in G.edges()):  
            G.add_edge(u,y)                           #断旧边
            G.add_edge(v,x)
            G.remove_edge(u,v)                        #连新边
            G.remove_edge(x,y)
            swapcount+=1
        if n <= max_tries:
            e=('Maximum number of swap attempts (%s) exceeded '%n +
            'before desired swaps achieved (%s).'%nswap)
            print e
            break
        n+=1
    return G

def random_1kc(G0, nswap=1, max_tries=100):     #保持连通性下随机断边重连的1阶零模型
    """
    在random_1k()的基础上增加连通性判断，若置乱后的网络不保持连通性则撤销该置乱操作
    注：G0为连通网络
    """
    if not nx.is_connected(G0):
       raise nx.NetworkXError("Graph not connected")
    if len(G0) < 4:
        raise nx.NetworkXError("Graph has less than four nodes.")
    G = copy.deepcopy(G0)
    n=0
    swapcount=0
    keys,degrees=zip(*G.degree().items())
    cdf=nx.utils.cumulative_distribution(degrees)  
    while swapcount < nswap:
        swapped=[]
        (ui,xi)=nx.utils.discrete_sequence(2,cdistribution=cdf)
        if ui==xi:
            continue
        u=keys[ui]
        x=keys[xi]
        v=random.choice(list(G[u]))
        y=random.choice(list(G[x]))
        if v==y:
            continue
        if (y not in G.neighbors(u)) and (v not in G.neighbors(x)) and ((u,v) in G.edges()) and ((x,y) in G.edges()):
            G.add_edge(u,y)         
            G.add_edge(v,x)
            G.remove_edge(u,v)      
            G.remove_edge(x,y)
            swapped.append((u,v,x,y))
            swapcount+=1
        if not nx.is_connected(G):      
            while swapped:
                (u, v, x, y) = swapped.pop()
                G.add_edge(u,v)         #撤销断边操作
                G.add_edge(x,y)
                G.remove_edge(u,x)      #撤销连新边操作
                G.remove_edge(v,y)
                swapcount -= 1
        if n <= max_tries:
            e=('Maximum number of swap attempts (%s) exceeded '%n +
            'before desired swaps achieved (%s).'%nswap)
            print e
            break
        n+=1
    return G
```


### 2.5.3 基于随机断边重连的 2 阶零模型

```python
def random_2k(G0, nswap=1, max_tries=100):
    """
    2阶置乱是在1阶置乱的基础上，增加约束条件：
    要求断开的边u-v和新连的边u-y中v,y度相同
    """
    if nswap<max_tries:
        raise nx.NetworkXError("Number of swaps < number of tries allowed.")
    if len(G0) < 4:
        raise nx.NetworkXError("Graph has less than four nodes.")
    G = copy.deepcopy(G0)
    n=0
    swapcount=0
    while swapcount < nswap:
        (u,x)=random.sample(G.nodes(),2)     #随机找两个不相连的点
        v=random.choice(list(G[u]))
        y=random.choice(list(G[x]))
        if G.degree(v)!=G.degree(y) or v==y:
            continue                        #若节点v,y度不相同，重新选择
        if (y not in G.neighbors(u)) and (v not in G.neighbors(x)) and ((u,v) in G.edges()) and ((x,y) in G.edges()):
            G.add_edge(u,y)
            G.add_edge(x,v)
            G.remove_edge(u,v)
            G.remove_edge(x,y)
            swapcount+=1
        if n <= max_tries:
            e=('Maximum number of swap attempts (%s) exceeded '%n +
            'before desired swaps achieved (%s).'%nswap)
            print e
            break
        n+=1
    return G

def random_2kc(G0, nswap=1, max_tries=100):
    """
    在random_2k()的基础上增加连通性判断，若置乱后的网络不保持连通性则撤销该置乱操作
    注：G0为连通网络
    """
    G = copy.deepcopy(G0)
    if not nx.is_connected(G):
       raise nx.NetworkXError("Graph not connected")
    if len(G) < 4:
        raise nx.NetworkXError("Graph has less than four nodes.")
    n=0
    swapcount=0
    while swapcount < nswap:
        swapped = []
        (u,x)=random.sample(G.nodes(),2)    #随机找两个不相连的点
        v=random.choice(list(G[u]))
        y=random.choice(list(G[x]))
        if G.degree(v)!=G.degree(y) or v==y:
            continue                        #若节点v,y度不相同，重新选择
        if (y not in G.neighbors(u)) and (v not in G.neighbors(x)) and ((u,v) in G.edges()) and ((x,y) in G.edges()):
            G.add_edge(u,y)
            G.add_edge(x,v)
            G.remove_edge(u,v)
            G.remove_edge(x,y)
            swapped.append((u,v,x,y))
            swapcount+=1
        if not nx.is_connected(G):
            while swapped:
                (u, v, x, y) = swapped.pop()
                G.add_edge(u,v)
                G.add_edge(x,y)
                G.remove_edge(u,y)
                G.remove_edge(x,v)
                swapcount -= 1
        if n <= max_tries:
            e=('Maximum number of swap attempts (%s) exceeded '%n +
            'before desired swaps achieved (%s).'%nswap)
            print e
            break
        n+=1
    return G
```

### 2.5.3 基于随机断边重连的 2.5 阶零模型

```python
def random_25k(G0, nswap=1, max_tries=100):
    """
    在2阶基础上增加度度相关的聚类系数的判断，若置乱前后值不同，则撤销此次置乱
    """
    if nswap<max_tries:
        raise nx.NetworkXError("Number of swaps < number of tries allowed.")
    if len(G0) < 4:
        raise nx.NetworkXError("Graph has less than four nodes.")
    G = copy.deepcopy(G0)
    l = map(lambda t:(t[1],t[0]), G0.degree().items())  #(度,节点)组成的列表
    D = dict_degree_nodeslist(l)
    n=0
    swapcount=0
    while swapcount < nswap:
        (u,x)=random.sample(G.nodes(),2)    #随机找两个不相连的点
        v=random.choice(list(G[u]))
        y=random.choice(list(G[x]))

        if G.degree(v)!=G.degree(y) or v==y:
            continue    # 若节点v,y度不相同，重新选择
        if (y not in G.neighbors(u)) and (v not in G.neighbors(x)) and ((u,v) in G.edges()) and ((x,y) in G.edges()):
            G.add_edge(u,y)
            G.add_edge(x,v)
            G.remove_edge(u,v)
            G.remove_edge(x,y)
            swapcount+=1
        for i in range(len(D)):
            avcG0 = nx.average_clustering(G0, nodes=D.values()[i], weight=None, count_zeros=True)
            avcG = nx.average_clustering(G, nodes=D.values()[i], weight=None, count_zeros=True)
            i += 1
            if avcG0 != avcG:   #若置乱前后度相关的聚类系数不同，则撤销此次置乱操作
                G.add_edge(u,v)
                G.add_edge(x,y)
                G.remove_edge(u,y)
                G.remove_edge(x,v)
                swapcount -= 1
                break
        if n <= max_tries:
            e=('Maximum number of swap attempts (%s) exceeded '%n +
            'before desired swaps achieved (%s).'%nswap)
            print e
            break
        n+=1
    return G

def random_25kc(G0, nswap=1, max_tries=100):
    """
    只判断四个节点及邻居节点度相关的聚类系数
    """
    if nswap<max_tries:
        raise nx.NetworkXError("Number of swaps < number of tries allowed.")
    if len(G0) < 4:
        raise nx.NetworkXError("Graph has less than four nodes.")
    G = copy.deepcopy(G0)
    n=0
    swapcount=0
    while swapcount < nswap:
        (u,x)=random.sample(G.nodes(),2)    
        v=random.choice(list(G[u]))
        y=random.choice(list(G[x]))
        if G.degree(v)!=G.degree(y) or v==y or len([u,v,x,y])<4:
            continue                    # 若节点v,y度不相同，重新选择
        n+=1
        if (y not in G.neighbors(u)) and (v not in G.neighbors(x)) and ((u,v)in G.edges()) and ((x,y) in G.edges()):
            G.add_edge(u,y)
            G.add_edge(x,v)
            G.remove_edge(u,v)
            G.remove_edge(x,y)
            swapcount+=1
            if not nx.is_connected(G):
                G.add_edge(u,v)
                G.add_edge(x,y)
                G.remove_edge(u,y)
                G.remove_edge(x,v)
                swapcount -= 1
                continue
            l = map(lambda t:(t[1],t[0]), G0.degree([u,v,x,y]+list(G[u])+list(G[v])+list(G[x])+list(G[y])).items())  #(度,节点)组成的列表
            D = dict_degree_nodeslist(l)
            for i in range(len(D)):
                avcG0 = nx.average_clustering(G0, nodes=D.values()[i], weight=None, count_zeros=True)
                avcG = nx.average_clustering(G, nodes=D.values()[i], weight=None, count_zeros=True)
                i += 1
                if avcG0 != avcG:   #若置乱前后度相关的聚类系数不同，则撤销此次置乱操作
                    G.add_edge(u,v)
                    G.add_edge(x,y)
                    G.remove_edge(u,y)
                    G.remove_edge(x,v)
                    swapcount -= 1
                    break    
        if n <= max_tries:
            e=('Maximum number of swap attempts (%s) exceeded '%n +
            'before desired swaps achieved (%s).'%nswap)
            print e
            break
    return G
```

### 下载附件（初稿和代码）
<p>下面是可以下载的内容，可以下载的内容，可以下载的内容《第二章 无权网络零模型的构造及应用》，系本书第二章初稿和各种零模型对应的python代码。初稿和代码是我的两个学生四个多月辛勤努力的成果，限于我这个老师的水平有限，里面还有很多问题，欢迎大家过来拍砖。</p>

<p><a href="http://computational-communication.com/uploads/2015/12/第二章-无权网络零模型的构造及应用_初稿.pdf">附件1. 第二章 无权网络零模型的构造及应用_初稿</a></p>
<p><a href="http://computational-communication.com/uploads/2015/12/null_model_program.zip">附件2. 本章内容对应的程序代码：null_model_program</a></p>

## 参考文献
<p>Orsini C, Dankulov M M, Colomer-de-Simon P, et al. Quantifying randomness in real networks[J]. Nature Communications, 2015,6.</p>
<p>Molloy M, Reed B. The Size of the Giant Component of a Random Graph with a Given Degree Sequence[J]. Combinatorics, Probability and Computing, 1998,7(03):295-305.</p>
<p>Molloy M, Reed B. A Critical Point for Random Graphs with a Given Degree Sequence[J].Random Structures and Algorithms, 1995,6(2-3):161-180.</p>
<p>Newman M E J. Random Graphs with Clustering[J]. Physical Review Letters,2009,103(5):58701.</p>
