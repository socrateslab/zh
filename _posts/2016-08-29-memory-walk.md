---
layout: single
title: "Memory-preferential random walk model"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-8.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "We consier a finite space of M locations, in which N individuals perfom random wolk with the probability of visiting a position proportional to its weight."
modified: 2016-08-29T11:55:22-04:00
comments: true
author_profile: true
author: "王成军"
---

{% include toc title="Table" icon="file-text" %}

![memory-preferential random walk model](http://oaf2qt3yk.bkt.clouddn.com/424396951922ff02ac9d2e88a9bc72cc.png)

## 模型设定
<ul>
<li>有有限个地点，数量为$M$（真实的或者虚拟的），有有限个个体，数量记为$N$。</li>
<li>现在的所在的一个地点记为$\alpha$，下一个地点记为$\beta$这个地点在时间t范围内被访问的次数记为$k_{\beta}$。</li>
<li>&#8221;&#8217;随机游走模型&#8221;&#8217;：去每一个地方（不管去过的地方，还是没有去过的地方）的概率相等，记为1</li>
<li>&#8221;&#8217;记忆偏好假设&#8221;&#8217;：去过的地方再去的概率较大，与去过的次数成正比，系数是$\lambda$，即访问去过地点的概率是：$\lambda k_{\beta}$。</li>
<li>对于没有去过的地方也要一个概率，解决方法是令其概率为1，去过的地方的概率也加上1，变为：$1 + \lambda k_{\beta}$。 **因为没有去过的地方的$k_{\beta} = 0$，所以也可以表达为$1 + \lambda k_{\beta}$。</li>
</ul>
<p>去一个地方的概率还需要进一步归一化： $P_{\rightarrow \beta} = \frac{1 + \lambda k_{\beta}}{\sum_{\gamma = 1}^{m} ( 1 + \lambda k_{\beta})}$ 公式（1）</p>

## 分析问题

![memory-based-random-walk](http://oaf2qt3yk.bkt.clouddn.com/746d601efc14dfa84830442152746cff.png)

<p>如上图所示，在时间t范围内去了S个地点，每个时间步去一个地方，每个地点去过的次数记为：$k_{s_1}, k_{s_2}, &#8230;, k_{s_s}$</p>
<p>那么显然 $\sum k_{s_j} = t$</p>
<p>一个人去一个的地方的概率空间有两部分组成： * 没有去过的地方M-S: 去每一个没去过的地方的概率是1，加到一起是M-S * 去过的地方 S: 去每一个去过的地方的概率是 $ 1 + \lambda k_{s_j}$, 加到一起是：</p>
<p>$\sum_{j = 1}^{S} ( 1 + \lambda k_{s_j} ) = S + \sum_{j = 1}^{S} k_{s_j} = S + \lambda t $</p>
<p>因为没有去过的地方$\lambda = 0$，所以&#8221;&#8217;去所有地方的概率之和&#8221;&#8217;可以不失一般性地表达为：</p>
<p>$\sum_{j = 1}^{M} ( 1 + \lambda k_{\gamma} ) = M + \lambda t $ 公式（2）</p>
<p>去所有地方的总概率为：$ M -S + S + \lambda t = M+ \lambda t$</p>

## The number of distinct locations, S(t)

<p>那么去一个新地方的概率可以表达为：</p>
<p>$P_{new} = \frac{M-S}{M + \lambda t}$</p>
<p>需要注意的是每一个单位时间t范围内S的增加就是$P_{new}$，即：</p>
<p>$\frac{\partial S}{\partial t} = P_{new} = \frac{M-S}{M + \lambda t}$</p>
<h2>2&#46; The visit probability of positions discovered at different time, P(z)</h2>
<p>我们想要分析的是一个地点被多次访问的概率。</p>
<ul>
<li>一个地点Z被访问k次记为$k_z$ *第一次访问Z地点的时间记为$t_z$</li>
</ul>
<p>已经知道去一个地点的可能性可以表达为：$1 + \lambda k_z $</p>
<p>根据公式（2），去所有地方的可能性是：$M + \lambda t$</p>
<p>想要分析的问题是$k_z$在一单位时间的增量：</p>
<p>$\frac{d k_z}{d t} = \frac{1 + \lambda k_z}{M + \lambda t}$</p>

## 3 The visit probability of each position P(k)

![inverse-k](http://oaf2qt3yk.bkt.clouddn.com/0393995c8eb51c6fbedfff562f41b84e.png)

<p>每一个地点有一个第一次被访问时间$t_{\beta}$被访问的次序$Z$。如右图。</p>
<ul>
<li>这样我们知道$k(z)$关系， ** 假设它是单调递减的，可以得到它的逆函数$z(k)$，也是单调递减的， *** 它的斜率即其导数$z'(k)$，如右图。</li>
</ul>
<p>$k = x$等价于$| \Delta z | = | z'(k = x) \Delta k| $</p>
<p>那么$k = x$的概率可以表达为：</p>
<p>$P(k = x) = \frac{\Delta z}{S} = \frac{z'(k = x) \Delta k}{S}$</p>
<p>因为k是整数，且$\Delta k = 1$，那么有：</p>
<p>$P(k) = \frac{z'(k) \Delta k}{S(t)}$</p>

## 微分方程

![integrate-inverse-x](http://oaf2qt3yk.bkt.clouddn.com/9617688bdea6333a61d689577afb43a6.png)

<p>见<a href="http://www.wolframalpha.com/input/?i=integrate+1%2F(a%2Bbx)">Wolframalpha</a></p>
<p>$\int \frac{1}{a + bx} = \frac{1}{b} log(a + bx) + constant $ 公式 (1)</p>
<p>$\frac{dS}{dt} = \frac{M- S}{ M + \lambda t}$ 公式 (2)</p>
<p>$ \frac{dS}{M-S} = \frac{dt}{M + \lambda t} $ 公式 (3)</p>
<p>$\int \frac{1}{M-S} dS = \int \frac{1}{M + \lambda t} dt $ 公式 (4)</p>
<p>由公式（1），可以知道公式（4）两边积分的结果：</p>
<p>$ &#8211; log(M-S) = C_1 + \frac{1}{\lambda} log( M + \lambda t)$</p>
<p>$ log(M-S) = C_2 &#8211; \frac{1}{\lambda} log( M + \lambda t)$</p>
<p>$ log(M-S) = log 10^{C_2} &#8211; \frac{1}{\lambda} log( M + \lambda t)$</p>
<p>$ log(M-S) = log \frac{10^{C_2}}{( M + \lambda t)^{\frac{1}{\lambda}}}$</p>
<p>$ log(M-S) = log \frac{C}{( M + \lambda t)^{\frac{1}{\lambda}}}$</p>
<p>$ M-S = \frac{C}{( M + \lambda t)^{\frac{1}{\lambda}}}$</p>
<p>$ S = M &#8211; C (\frac{1}{M + \lambda t})^{\frac{1}{\lambda}}$ 公式 （5）</p>

<p>由公式（5）如果还知道S和t的初始状态，比如t = 1时， S = 1， 那么就可以求出来C。</p>

## 实证结果

![preferential-return-data](http://oaf2qt3yk.bkt.clouddn.com/eb250d4323b9af22fa6cb6f4e84a884c.png)

### foursquare-dataset

<p>https://sites.google.com/site/yangdingqi/home/foursquare-dataset</p>

## 参考文献
<ul>
<li>Lai and Huang 2014 Scaling and correlation of human movements in cyberspace and physical space. PhysRevE.90.050802 </li>
<li>Yi-Ming Zhao, An Zeng⋆, Xiao-Yong Yan†, Wen-Xu Wang, Ying-Cheng Lai. Universal underpinning of human mobility in the real world and cyberspace. arXiv 2015.12.04</li>
</ul>
