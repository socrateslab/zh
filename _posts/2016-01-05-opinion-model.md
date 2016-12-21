---
layout: single
title: "社交网络vs大众媒体：公共意见的动力学模型"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-8.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "当个体更新观点时，他以概率P选择媒体观点作为他的新观点，而以概率1−P随机选择他的一个好友并将其新观点设置为与该好友一致。最终这个动力学过程将达到稳态。"
modified: 2016-01-02T11:55:22-04:00
comments: true
author_profile: true
author: "胡海波"
---

{% include toc title="Table" icon="file-text" %}

## 背景

在现实生活中，我们的观点或态度往往受朋友圈的影响，或者受大众媒体的影响。这些媒体包括电视、广播、互联网和纸质媒体，这些观点可能是关于某种消费品，也可能是关于生活方式或明星名人。

朋友圈或社交网络对个人的影响称为社会影响（Social influence），一种为信息性社会影响（Informational social influence），另一种则为规范性社会影响（Normative social influence）。前者表达了想知道“正确”情况的需要，即他人的影响导致我们从众，是因为我们将他人视为指导我们行为的信息来源；我们从众是因为我们相信他人对某种模糊情境的解释比我们自己的解释更正确，从而可以帮助我们选择一个适当的行为方式。而后者则表达了希望被接受的需要，即我们为了获得他人的喜爱和接纳而从众；这类从众会导致个人公开顺从团体的信念和行为，但并不一定导致个人的私下接纳，也就是说个人虽然主观上不同意团队的观点，但迫于压力只好表面上表现出顺从。我们将针对第一种社会影响进行研究。

个人的观点或思想会受到社交网络或大众媒体的影响从而发生变化，这被称之为舆论动力学或观点动力学（Opinion dynamics），舆论动力学研究因为跟公共舆论相关，因此受到了政治学、传播学和社会学的广泛关注，又由于它跟动力学密切相关，因此也受到了物理学和应用数学的关注。在舆论动力学研究中，初始时社交网络中每个个体都有一个观点或状态，通过个体之间的相互作用不同的观点在网络中扩散、聚集或消失。

一个众所周知的也是经常研究的舆论动力学模型是投票者模型（Voter model），该模型由Clifford和Sudbury在上世纪70年代提出，最初是用来研究物种竞争；几年以后他们引入的这个动力系统被Holley和Liggett命名为投票者模型。在这个模型中，每个个体被赋予一个二元状态或观点，比如赞成或反对，在一个基本的时间步里，随机的选择一个个体和他的一个邻居，然后第一个个体将新的观点设置为跟邻居一致。之后几十年，投票者模型得到了广泛的研究，最初的二元状态被扩展到了多元状态，网络框架由规则栅格也变成了复杂网络。该模型一个关键的假设是，邻居个体持有某观点的越多，那么该个体也将越可能持有该观点，因此在该模型中，个体本质上是根据某种版本的多数者规则或模仿规则来改变自己的观点的。经济学的研究表明，在某些情况下，模仿规则确实是最佳策略，这个模型看起来很简单，但实证研究表明它确实可以解释某些情况下人们观点的变化。

在一本伊朗的旅游指南《Lonely Planet Iran》中有一段话：If you make your travel decisions based on what your friends and family say, you’ll probably never make it to Iran，这说明，在社交网络中存在某些忠实个体或顽固个体，他们的观点不会受好友圈的影响。实际上，这类个体在不同的背景下广泛存在，如商业中的忠实用户，社会学中对某些有争议的话题的态度，政治中的党派和国家之间的纷争以及宗教中的教派纷争，实证研究也表明这类个体在社会中的确存在。我们也将这类个体引入到模型中。在社会中顽固个体或忠实个体可以代表有影响力的人物或意见领袖，他们可以影响他们的好友，但是好友圈或媒体均不能对他们产生影响。

## 模型

我们假定初始时社交网络中个体或节点的数量为$N$，不同的观点的数量为$I \ge 2$，个体的观点、思想或态度可以取离散值$i$ = 1, 2, &#8230;, $I$，这些不同的观点是等价的、互斥的，每个人的初始观点都是基于一定的私人信息或生活体验形成的。首先我们假定网络中一部分个体为忠诚个体，其他的则为一般个体。在每一个时间步，我们随机选择一个个体，如果他是忠诚个体，不进行观点更新；如果他是一般个体，他将更新他的观点。当一般个体更新观点时，他以概率$P$选择媒体观点作为他的新观点，而以概率$1-P$随机选择他的一个好友并将其新观点设置为与该好友一致。在这个模型中，媒体和社交网络均会影响一个人的观点，一个可调的参数$P$可以控制大众媒体和社交网络的相对权重。最终这个动力学过程将达到稳态，其中一个或几个观点将会主导整个社交网络。

## 结果

我们假定社交网络的度分布为$p_k$，在所有度值为$k$的个体中观点为$i$的个体的比例为$q_{i,k}$，在所有度值为$k$的个体中观点为$i$的忠诚个体的比例为$s_{i,k}$，媒体观点为$m$（$1 \le m \le I$）。

对于原始的投票者模型，初始时不同的观点数为$I=2$，我们可以用1和2来表示这两种观点。我们假定媒体观点为$m=2$，并考虑某个时间步一次特定的更新。假设随机选择的个体$A$为要更新观点的个体，$A$度值为$k$的概率为$p_k$，接下来我们来讨论一次更新将$A$由观点2变为1和由1变为2的概率。

对于观点由2变为1，已知$A$的度值$k$，在更新之前$A$的观点为2且为一般个体的概率为$q_{2,k} -{s_{2,k} } $。要将$A$的观点从2变为1，$A$需要受他的一个观点为1的好友$B$的影响。$A$被他的好友影响的概率为$1-P$，要得到一个随机选择的好友$B$其观点为1的概率，我们需要知道$A$的好友的度分布。令$P(k&#8217;|k)$为度值为$k$的个体其好友度值为$k&#8217;$的条件概率，为了能得到闭合的解析表达式，我们假定社交网络是度不相关网络，即一条边连接的两个节点他们的度值没有相关性。在这种情况下，$P(k&#8217;|k) = k&#8217;p_{k&#8217;} / \sum\nolimits_{k&#8217;} {k&#8217;p_{k&#8217;}} $，因此$A$的好友的度分布，即$B$的度值为$j$的概率为$jp_j /\sum\nolimits_j {jp_j } $。随机选择的一位好友$B$其观点为1的概率为$\sum\nolimits_j {jp_j q_{1,j} } /\sum\nolimits_j {jp_j } $。因此，在一个时间步内，状态更新将度为$k$的一个个体从观点2变为1的概率为 $$\begin{equation} p_{2 \to 1} (k) = p_k (q_{2,k} &#8211; {s_{2,k} } )(1 -P)\frac{{\sum\nolimits_j {jp_j q_{1,j} } }}{{\sum\nolimits_j {jp_j }}} \end{equation} $$ 类似的，对于观点由1变为2，已知$A$的度值$k$，状态更新之前$A$的观点为1且为一般个体的概率为$q_{1,k} &#8211; {s_{1,k}} $。要将$A$的观点从1变为2，$A$需要受他的一个观点为2的好友$B$的影响或受媒体的影响。受到媒体的影响从而将$A$的观点由1变为2的概率为$p_k (q_{1,k} &#8211; s_{1,k} )P$，因此在一个时间步内，状态更新将度为$k$的一个个体从观点1变为2的概率为 $$\begin{equation} p_{1 \to 2} (k) = p_k (q_{1,k} &#8211; s_{1,k} )\left[ {(1 &#8211; P) {\frac{{\sum\nolimits_j {jp_j q_{2,j} } }}{{\sum\nolimits_j {jp_j }}}} + P} \right] \end{equation} $$

当$I \ge 2$时，我们可以得到更一般的结论。

当$i \ne m$时，状态更新将度为$k$的一个个体从观点非$i$变为$i$的概率为 $$\begin{equation} p_{\bar i \to i} (k) = p_k (1 &#8211; q_{i,k} &#8211; \sum\nolimits_{j \ne i} {s_{j,k} } )(1 &#8211; P)\frac{{\sum\nolimits_j {jp_j q_{i,j} } }}{{\sum\nolimits_j {jp_j } }} \end{equation} $$ 将度为$k$的一个个体从观点$i$变为非$i$的概率为 $$\begin{equation} p_{i \to \bar i} (k) = p_k (q_{i,k} &#8211; s_{i,k} )\left[ {(1 &#8211; P)\left( {1 &#8211; \frac{{\sum\nolimits_j {jp_j q_{i,j} } }}{{\sum\nolimits_j {jp_j } }}} \right) + P} \right] \end{equation} $$

令$\left\langle k \right\rangle$为网络的平均度，$n_k = Np_k$为度值为$k$的个体的数量，我们可以定义 $$\begin{equation} q_i^{\rm{w}} = \frac{{\sum\nolimits_j {jp_j q_{i,j} } }}{{\sum\nolimits_j {jp_j } }} = \frac{{\sum\nolimits_j {jn_j q_{i,j} } }}{{N\left\langle k \right\rangle }} \end{equation} $$ 作为观点$i$的加权比例。该比例表示观点为$i$的个体他们总的度值占所有节点总度值的比例，因此 $$\begin{equation} p_{\bar i \to i} (k) = p_k (1 &#8211; q_{i,k} &#8211; \sum\nolimits_{j \ne i} {s_{j,k} } )(1 &#8211; P)q_i^{\rm{w}} = p_k (q_{\bar i,k} &#8211; s_{\bar i,k} )(1 &#8211; P)q_i^{\rm{w}} , \end{equation} $$ $$\begin{equation} p_{i \to \bar i} (k) = p_k (q_{i,k} &#8211; s_{i,k} )\left[ {(1 &#8211; P)(1 &#8211; q_i^{\rm{w}} ) + P} \right] = p_k (q_{i,k} &#8211; s_{i,k} )\left[ {(1 &#8211; P)q_{\bar i}^{\rm{w}} + P} \right] \end{equation} $$

$q_{i,k}$的演化方程为 $$\begin{equation} {\rm{d}}q_{i,k} =\left[ (p_{\bar i \to i} (k)-p_{i \to \bar i} (k))/p_k \right] {\rm{d}}t =\left[ {(1 &#8211; \sum\nolimits_j {s_{j,k} } )(1 &#8211; P)q_i^{\rm{w}} &#8211; q_{i,k} + s_{i,k} } \right] {\rm{d}}t \end{equation} $$

在稳态时， $$\begin{equation} \mathop {\lim }\limits_{t \to \infty } q_i^{\rm{w}} (t) = \hat q_i^{\rm{w}} = \frac{{s_i^{\rm{w}} }}{{P + (1 &#8211; P)\sum\nolimits_j {s_j^{\rm{w}} } }} \end{equation} $$ $$\begin{equation} \hat q_i = s_i + \underbrace {(1 &#8211; s)(1 &#8211; P)\frac{{s_i^{\rm{w}} }}{{P + (1 &#8211; P)\sum\nolimits_j {s_j^{\rm{w}} } }}}&#95;{{\rm{Internal \; interactions}}} \end{equation} $$ 其中$s$为忠诚个体的比例，$s&#95;i$为观点为$i$的忠诚个体的比例。

当$i = m$时，利用前面的方法可以得到 $$\begin{equation} p_{m \to \bar m} (k) = p_k (q_{m,k} &#8211; s_{m,k} )(1 &#8211; P)(1 &#8211; q_m^{\rm{w}} ) = p_k (q_{m,k} &#8211; s_{m,k} )(1 &#8211; P)q_{\bar m}^{\rm{w}} , \end{equation} $$ $$\begin{equation} p_{\bar m \to m} (k) = p_k (1 &#8211; q_{m,k} &#8211; \sum\nolimits_{j \ne m} {s_{j,k} } )\left[ {(1 &#8211; P)q_m^{\rm{w}} + P} \right] = p_k (q_{\bar m,k} &#8211; s_{\bar m,k} )\left[ {(1 &#8211; P)q_m^{\rm{w}} + P} \right]. \end{equation} $$

$q_{m,k}$的演化方程为 $$\begin{equation} {\rm{d}}q_{m,k} = \left[ {\left( {{\rm{1 &#8211; }}\sum\nolimits_j {s_{j,k} } } \right)\left( {(1 &#8211; P)q_m^{\rm{w}} + P} \right) &#8211; q_{m,k} + s_{m,k} } \right]{\rm{d}}t \end{equation} $$

在稳态时， $$\begin{equation} \hat q_m^{\rm{w}} = \frac{{s_m^{\rm{w}} + (1 &#8211; \sum\nolimits_j {s_j^{\rm{w}} } )P}}{{P + (1 &#8211; P)\sum\nolimits_j {s_j^{\rm{w}} } }} \end{equation} $$

$$\begin{equation}\hat q_m = s_m + \frac{{(1 &#8211; s)(1 &#8211; P)s_m^{\rm{w}} }}{{P + (1 &#8211; P)\sum\nolimits_j {s_j^{\rm{w}} } }} + (1 &#8211; s)P + \frac{{(1 &#8211; s)(1 &#8211; P)(1 &#8211; \sum\nolimits_j {s_j^{\rm{w}} } )P}}{{P + (1 &#8211; P)\sum\nolimits_j {s_j^{\rm{w}} } }} \end{equation} $$

## 结论
我们发现，稳态时每种观点的比例与顽固个体的度值和比例以及媒体的影响权重相关。对于非媒体观点，其最终比例（方程10）一部分来自于顽固个体，另一部分则来自于顽固个体所导致的网络中内部的相互作用所产生的增量；对于媒体观点，其比例（方程15）除了上述两部分，另有第三部分来自于外部媒体对个体观点的影响。该第三部分又可分为两部分，一部分来自于个体间无相互作用时媒体对大众舆论的影响，另一部分则来自于媒体通过社交网络结构对个体观点所施加的影响，这表明媒体会通过社交网络放大其对个体的影响力，在此社交网络担当了社会放大器的角色。也就是说，媒体不仅可以直接通过广播的形式来改变人们的观点，也可以间接的通过社交网络中的同伴影响来达到同样的目的。
尽管我们的模型只是研究了个体的观点受社交网络和媒体的影响发生变化从而导致了公共舆论的演化，但它可以成为很多包含内部和外部影响的经济或社会现象的一种隐喻，比如可以应用到产品采纳、创新扩散、品牌选择等不同场景。

更多细节内容，请参阅下面的论文： <a href="http://link.springer.com/article/10.1007/s11403-015-0170-8">Social networks, mass media and public opinions</a>
