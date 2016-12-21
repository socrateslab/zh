---
layout: single
title: "无标度的意义"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-4.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "网络科学使得幂律(power law)和无标度（scale-free）变得非常普及。那么究竟无标度的意义是什么呢？其实，无标度来源于统计物理的一个分支：相变理论（the theory of phase transition）。"
modified: 2015-12-22T11:55:22-04:00
comments: true
author_profile: true
---

![](http://oaf2qt3yk.bkt.clouddn.com/99328938ccd1f635c719b95ddeac4c70.png)


网络科学使得幂律(power law)和无标度（scale-free）变得非常普及。那么究竟无标度的意义是什么呢？其实，无标度来源于统计物理的一个分支：相变理论（the theory of phase transition）。要理解无标度概念，我们需要了解<code>度分布</code>的moments(中文翻译为<em>矩</em>)。

度分布的n阶矩被定义为：
$ <k^n> = \sum_{k_{min}}^{k_{max}}k^np_k = \int_{k_{min}}^{k_{max}}k^np_kdk $ （1）

低阶矩具有明确的统计意义：

- n = 1的时候，一阶矩是$<k^{}>$，即平均度。
- n = 2的时候，二阶矩是$<k^2>$，可以帮助计算方差 $ \delta^2 = <k^2> - <k^{}>^{2} $，测量了度的离散程度（the spread in the degrees）。
- n = 3的时候，三阶矩是$<k^3>$, 决定了度分布的偏度（skewness），测量了$p_k$围绕着 <k>的对称性。


对于无标度网络而言，满足幂律分布：
$p(k) = Ck^{-\gamma}$ （2）

由公式（1）和（2）可以得到：
$ <k^n> = \int_{k_{min}}^{k_{max}}k^np_kdk = C \frac{k_{max}^{n- \gamma +1} - k_{min}^{n - \gamma +1}}{n - \gamma + 1} $ （3）

可以使用wolframalpha的积分计算器积分来进行简单验证，例如x^(n-r)dx从10到100积分 网页链接：<a href="http://www.wolframalpha.com/input/?i=integrate%20x%5E%28n-r%29%20dx%20from%2010%20to%20100">http://www.wolframalpha.com/input/?i=integrate+x%5E%28n-r%29+dx+from+10+to+100</a>

显然：


- 当$n - \gamma +1 <= 0$时，随着$k_{max}增加，$$k_{max}^{n- \gamma +1} \rightarrow 0$。所有满足$n <= \gamma -1$的n阶矩都是有限的。
- 当$n - \gamma +1 >0 $时，随着$k_{max}增加，$$k_{max}^{n- \gamma +1} \rightarrow \infty$。所有满足$n > \gamma -1$的n阶矩都是无极限的。

对于无标度网络而言，一般幂参数$2 < \gamma < 3$，所以：

- 对于n = 1的情况，即一阶矩平均度$<k^{}>$是有限的。
- 但对于n >= 2的情况，即$k^2$或$k^3$是无极限的。二阶和高阶矩无穷大是“无标度”的来源


下图最为直接的描绘出了这种特点，即与正态分布等相比，<code>无标度网络下降的慢</code>。

- 对于任何指数类型的分布，如泊松分布或高斯分布，随机选取一个节点的度在平均度附近，因此平均度就是这些网络的<code>尺度</code>。
- 对于一个幂律分布而言，因为二阶矩发散，在网络中随机抽取一个节点的度可以显著的不同于平均度$<k^{}>$， 因此平均度不再是网络的尺度，称之为无标度。




![scaling-figure](http://oaf2qt3yk.bkt.clouddn.com/ea83d63f0b263cda033be431ea85bf79.png)

<blockquote>
一言以蔽之，在无标度的意义是，在网络中随机抽取一个节点的度可以显著的不同于平均度$<k^{}>$
</blockquote>
