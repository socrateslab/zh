---
layout: single
title: "理解人类个体移动的模式"
header:
  teaser: "/assets/images/unsplash-gallery-image-4-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-23.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "与列维飞行和随机游走模型预测相反，人类的实际移动轨迹显示出高度的时空规律性，个体特征可以用一个与时间无关的特征移动距离和一个优先返回概率来刻画。在校正行进距离的差异和每个轨迹固有的各向异性之后，个体行进模式转变成单个空间概率分布，这说明尽管他们的旅行历史具有多样性，人类的移动轨迹遵循简单的可再现模式。"
modified: 2016-12-16 19:49:48
comments: true
author: "陈志聪"
tags:
  - Human Mobility
  - Barabasi
categories:
  - 传播网络
---

{% include toc title="Table" icon="file-text" %}


Understanding individual human mobility patterns.Marta C. Gonzalez, Cesar A. Hidalgo & Albert-Laszlo Barabasi. 2009 Nature.<sup>1</sup> [链接](http://www.nature.com/nature/journal/v453/n7196/abs/nature06958.html)

# 摘要

我们发现，与之前普遍采用的列维飞行和随机游走模型预测出来的随机轨迹相反，人类的实际移动轨迹显示出高度的时间和空间上的规律性，每个个体的特征可以用一个与时间无关的特征移动距离和一个显著的回到几个经常光顾的地方的概率。在校正行进距离的差异和每个轨迹固有的各向异性之后，个体行进模式转变成单个空间概率分布，表明尽管他们的旅行历史具有多样性，人类的移动轨迹遵循简单的可再现模式。


# 引言
之前的研究发现，动物（如信天翁、猴子等）的移动轨迹可以用列维飞行来进行近似。列维飞行是一种随机游走，它的每一段飞行（step size），记为 $\Delta r$ ，符合幂律分布。
$$ P(\Delta r) \sim \Delta r^{(1+\beta)} $$

之前对于纸币的追踪研究发现，人类的移动轨迹可以被建模为连续时间随机游走与长尾的位移和等待时间分布。

但是对于纸币的追踪其实反映了两个或更多个人在两次报告位置的时间点之间携带该纸币的复合运动。因此，不能清楚地说明，观察到的分布究竟反映了某个个体用户的运动，亦或是基于整个人群的异质性与个体人类轨迹之间的一些以前未知的卷积。与此相反，手机在一个人的日常生活中一直由同一个人携带，因而提供了捕捉个人人类轨迹的最佳代理。

# 数据

## 数据1

欧洲的手机移动数据，包括日期、时间、（每一次通话或者短信行为记录下来的）基站坐标，600万用户，6个月时长。因为只能记录基站的位置，所以在数据中，1000km以上的跳跃不能被捕捉到。没有考虑用户跨大陆之间的跳跃。

## 数据2
有些手机应用要求定期记录下用户的位置，而和用户是否打电话、发短信无关。这样的数据，我们拿到了1000个用户，10613条记录，均满足在一周之内每两小时记录一次自己的坐标。

因为这些用户都是基于（sign up to the service）行为而选择出来的，所以可能存在一定的倾向性（bias），不过目前来看，我们没有detect到这样的bias。


# 研究发现

## 跳跃距离$\Delta r$的分布

我们测量了用户依次经过的地点之间的距离，记为$\Delta r$。

$$ P(\Delta r) = (\Delta r + \Delta r_0)^{-\beta}exp(-\Delta r/\kappa)   (1)$$



以上公式表明人类移动遵循一个截尾的列维飞行（truncated Levy flight）模式。但是观察到的$P(\Delta r)$的形状可以被三种不同的假设解释：

1. 每个用户遵循一个跳跃距离的分布为公式1的列维飞行（假设A）
2. 观察到的分布所反映的是群体层面的异质性，这种异质性是由个体之间所固有的差异造成的（假设B)
3. 基于群体的异质性与个体层面的列维轨迹共存（假设C),这样公式1代表了假设A和B的卷积。

## 回转半径$r_g$的分布

为了区分三个假设，作者计算了每一个用户移动行为的回转半径（**the radius of gyration**, $r_g$）。结果发现：

$$P(r_g)=(r_g+r_g^0)^{-\beta_r}exp(-r_g/\kappa)$$

问题: 如何计算$R_g$？回转半径如何理解？

[MIT Human dynamics](https://www.media.mit.edu/research/groups/human-dynamics)实验室开发了一个名为bandicoot的工具可以比较方便的使用。[http://bandicoot.mit.edu/demo/](http://bandicoot.mit.edu/demo/)，详细代码见[github](https://github.com/yvesalexandre/bandicoot)。

>  pip install bandicoot

```python
from collections import Counter
import math

def radius_of_gyration(positions):
    """
    position : tuple
        A tuple (lat, lon) with the latitude and longitude of the antenna,
        encoded as floating point numbers.

    Returns the radius of gyration, the *equivalent distance* of the mass from
    the center of gravity, for all visited places. [GON2008]_

    References
    ----------
    .. [GON2008] Gonzalez, M. C., Hidalgo, C. A., & Barabasi, A. L. (2008).
        Understanding individual human mobility patterns. Nature, 453(7196),
        779-782.
    """
    d = Counter(positions)
    sum_weights = sum(d.values())
    positions = list(d.keys())  # Unique positions

    if len(positions) == 0:
        return None

    barycenter = [0, 0]
    for pos, t in d.items():
        barycenter[0] += pos[0] * t
        barycenter[1] += pos[1] * t

    barycenter[0] /= sum_weights
    barycenter[1] /= sum_weights

    r = 0.
    for pos, t in d.items():
        r += float(t) / sum_weights * \
            great_circle_distance(barycenter, pos) ** 2
    return math.sqrt(r)

def great_circle_distance(pt1, pt2):
    """
    Return the great-circle distance in kilometers between two points,
    defined by a tuple (lat, lon).
    Examples
    --------
    >>> brussels = (50.8503, 4.3517)
    >>> paris = (48.8566, 2.3522)
    >>> great_circle_distance(brussels, paris)
    263.9754164080347
    """
    r = 6371.

    delta_latitude = math.radians(pt1[0] - pt2[0])
    delta_longitude = math.radians(pt1[1] - pt2[1])
    latitude1 = math.radians(pt1[0])
    latitude2 = math.radians(pt2[0])

    a = math.sin(delta_latitude / 2) ** 2 + math.cos(latitude1) * math.cos(latitude2) * math.sin(delta_longitude / 2) ** 2
    return r * 2. * math.asin(math.sqrt(a))
```

给定positions数据如下：

    postions = [(42.366944, -71.083611),
     (42.386722, -71.138778),
     (42.3604, -71.087374),
     (42.353917, -71.105),
     (42.36, -71.12),
     (42.375, -71.1),
     (42.345, -71.09),
     (42.39, -71.105),
     (42.38, -71.09),
     (42.304917, -71.147374),
     (42.373917, -70.067374),
     (42.313917, -71.037374),
     (42.40944, -71.1),
     (42.41, -71.073),
     (42.44, -71.15),
     (42.48, -71.23),
     (42.35, -71.05),
     (42.33, -71.11),
     (42.36, -71.25),
     (42.413, -71.143),
     (42.373917, -71.215),
     (43.37, -71.085),
     (43.39, -71.11),
     (42.29, -71.13),
     (42.31, -71.16),
     (42.313, -71.135),
     (42.297, -71.155)]

```python
radius_of_gyration(positions)
```

得到的结果是34.4

![mobility_rg](http://oaf2qt3yk.bkt.clouddn.com/4a2e5de1c9bc276c15f710f5ae3fcc47.png)

这是本文发现的人类个体移动的最重要的行为模式。


## 回转半径${r_g}$ 和时间 t的关系

观测的时间越长，一个人越有可能去他没去过的地方

We measured the time dependence of the radius of gyration for users whose gyration radius would be considered

- small ($r_g(T)$ <= 3 km),
- medium (20 < $r_g(T)$ <= 30 km) or
- large ($r_g(T)$ > 100 km)

at the end of our observation period (T = 6 months).
The results indicate that
the time dependence of the average radius of gyration of mobile phone users is better approximated by **a logarithmic increase**,
***not only*** a manifestly slower dependence than the one predicted by a power law
***but also*** one that may appear similar to a saturation process
(Fig. 2a and Supplementary Fig. 4).

## $P(\Delta r \mid r_g)$ 和 $\Delta r$的关系

图2b显示，$r_g$较小的用户，通常在小范围内活动，而那些具有大的$r_g$的人，则更倾向于选择许多小和几个更大的跳跃大小(jump size)的组合。

使用$r_g$ 进行重新标准化（rescale）以后，多条曲线合并成了一条直线，这表面，可能有一个单一的跳跃距离（jump size）分布，能够拟合所有人的行为数据。


$$P(\Delta r \mid r_g) \sim r_g^{-\alpha} F(\Delta r \mid r_g)$$

$\alpha \approx 1.2 \pm 0.1$ 而 F(x)是一个 不依赖于$r_g$的函数。这个F(x)函数在x<1时是幂律的$F(x) \sim x^{-a}$，x >1时急剧下降

因此，个体用户的旅行模式可以通过基于$r_g$的特征距离的Levy飞行来近似。然而，最重要的是，个体轨迹的范围受到$r_g$范围的限制;因此，作为列维飞行的明显而反常性质的来源的那种大尺度飞行（地理空间上的跨越）在统计上好像消失了。

这表明，我们所观察到的$P(\Delta r)$ 的分布实际上是对个体轨迹的统计$P(\Delta r \mid r_g)$ 和群体的异质性$P(r_g)$之间的卷积，也就是说，假设C成立。

计算t小时后第一次观测到某人出现在某地的概率$F_{pt}(t)$

> first passage time probability, defined as the probability that a user returns to the position where he/she was first observed after t hours.

人们的返回概率（return probability）往往会在24h、48h、72h后出现峰值

将地点（location）按照被访问次数排序（rank），通过记录个体（individual）所在的附近地区（vicinity），发现符合Zipf分布。

一个人去的地方的排名L的概率P(L)可以近似使用1/L来表达，而与用户去的地方的数量无关（对于去5个、10个、30个、50个地方的用户，他们的幂指数都是一样的），即$P(L) \sim 1/L$,

## 优先返回（Preferential Return）

人们大部分时间只会在很少的几个地方。因此，之前观察到的$r_g(t)$的对数饱和度是根据个人的日常旅行模式的高度规律性，由高回报概率捕获到几个高度常见的地点

每个用户可以被分配到由家庭和工作场所定义的明确定义的区域，在那里她或他大部分时间都能被找到。


这些结果表明：

- 在银行纸币测量中观察到的Levy统计数据捕获了等式(2)中所示的- 群体异质性与个体用户的运动的卷积。
- 个人显示出显着的规律性，因为他们回到几个经常访问的地方，如家庭或工作。
- 这种规律性不适用于钞票：票据总是遵循其当前所有者的轨迹; 也就是说，美元钞票弥漫（是散播开的），但人类没有。


总而言之，个体轨迹可以由相同的、与$r_g$独立的二维概率分布表征，这表明个体轨迹的关键统计特征在重新缩放之后在很大程度上是不可区分的。因此，我们的结果确立了多主体建模的基本假设，要求用户数量要与给定区域的人口密度成比例，并向每个用户分配取自观察到的$P(r_g）$分布的$r_g$。使用预测的各向异性重新缩放，结合密度函数，其形状提供为附件表1，我们可以获得在任何位置找到用户的可能性。鉴于空间接近度和社会联系之间的已知相关性，我们的结果可以帮助量化空间在网络发展和进化中的作用，并增进我们对扩散过程的理解。

# 参考文献
1. Marta C. Gonzalez, Cesar A. Hidalgo & Albert-Laszlo Barabasi. 2009 Understanding individual human mobility patterns. Nature
