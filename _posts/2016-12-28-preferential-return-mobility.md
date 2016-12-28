---
layout: single
title: "Understanding individual human mobility patterns"
header:
  teaser: "/assets/images/unsplash-gallery-image-4-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-20.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "新闻的传播过程是科学界与工业界都关注的重要问题。传统研究多关注新闻在社交网络上的传递。但是以人为节点，以人们彼此间的交互为连边的社交网络，是很容易变化的。在这个不断变化的背景上研究新闻的复制和扩散，显然不是一个非常聪明的策略。"
modified: 2016-12-16 19:49:48
comments: true
author: "陈志聪"
tags:
  - Human Mobility
  - Barabasi
categories: 
  - 传播网络
---
Understanding individual human mobility patterns

Marta C. Gonzalez, Cesar A. Hidalgo & Albert-Laszlo Barabasi

原文链接：[http://www.nature.com/nature/journal/v453/n7196/abs/nature06958.html](http://www.nature.com/nature/journal/v453/n7196/abs/nature06958.html)

# Abstract

我们发现，与之前普遍采用的列维飞行和随机游走模型预测出来的随机轨迹相反，人类的实际移动轨迹显示出高度的时间和空间上的规律性，每个个体的特征可以用一个与时间无关的特征移动距离和一个显著的回到几个经常光顾的地方的概率。在校正行进距离的差异和每个轨迹固有的各向异性之后，个体行进模式转变成单个空间概率分布，表明尽管他们的旅行历史具有多样性，人类的移动轨迹遵循简单的可再现模式。
> We find that, in contrast with the random trajectories predicted by the prevailing Levy flight and random walk models, human trajectories show a high degree of temporal and spatial regularity, each individual being characterized by a time-independent characteristic travel distance and a significant probability to return to a few highly frequented locations. After correcting for differences in travel distances and the inherent anisotropy of each trajectory, the individual travel patterns col- lapse into a single spatial probability distribution, indicating that, despite the diversity of their travel history, humans follow simple reproducible patterns.

# Background
之前的研究发现，动物（如信天翁、猴子等）的移动轨迹可以用列维飞行来进行近似。列维飞行是一种随机游走，它的每一段飞行（step size），记为 $\Delta r$ ，符合幂律分布。
$$ P(\Delta r) \sim \Delta r^{(1+\beta)} $$

之前对于纸币的追踪研究发现，人类的移动轨迹可以被建模为连续时间随机游走与长尾的位移和等待时间分布。

但是对于纸币的追踪其实反映了两个或更多个人在两次报告位置的时间点之间携带该纸币的复合运动。因此，不能清楚地说明，观察到的分布究竟反映了某个个体用户的运动，亦或是基于整个人群的异质性与个体人类轨迹之间的一些以前未知的卷积。与此相反，手机在一个人的日常生活中一直由同一个人携带，因而提供了捕捉个人人类轨迹的最佳代理。

# Data
## D1 Dataset
欧洲的手机移动数据，包括日期、时间、（每一次通话或者短信行为记录下来的）基站坐标，600万用户，6个月时长
> This dataset was collected by a European mobile phone carrier for billing and operational purposes. It contains the date, time and coordinates of the phone tower routing the communication for each phone call and text message sent or received by 6 million costumers. The dataset summarizes 6 months of activity.

因为只能记录基站的位置，所以在数据中，1000km以上的jump不能被捕捉到
> Each tower serves an area of approximately 3 km2. Due to tower coverage limitations driven by geographical constraints and national frontiers no jumps exceeding 1, 000 km can be observed in the dataset.

我们没有考虑用户跨大陆之间的jump
> We removed all jumps that took users outside the continental territory.

## D2 Dataset
有些手机应用要求定期记录下用户的位置，而和用户是否打电话、发短信无关
> Some services provided by the mobile phone carrier, like pollen and traffic forecasts, rely on the approximate knowledge of customer’s location at all times of the day. For customers that signed up for location dependent services, the date, time and the closest tower coordinates are recorded on a regular basis, independent of their phone usage.

这样的数据，我们拿到了206个用户，10613条记录，均满足在一周之内每两小时记录一次自己的坐标
> We were provided such records for 1, 000 users, among which we selected the group of users whose coordinates were recorded at every two hours during an entire week, resulting in 206 users for which we have 10, 613 recorded positions.

因为这些用户都是基于（sign up to the service）行为而选择出来的，所以可能存在一定的倾向性（bias），不过目前来看，我们没有detect到这样的bias。
> as these users were selected based on their actions (signed up to the service), in principle the sample cannot be considered unbiased, but we have not detected any particular bias for this data set.


# Observation

## The distribution of $\Delta r$
We measured the distance between user’s positions at consecutive calls, noted as $\Delta r$

$$ P(\Delta r) = (\Delta r + \Delta r_0)^{-\beta}exp(-\Delta r/\kappa) (1)$$

Equation (1) suggests that human motion follows a truncated Levy flight

However, the observed shape of $P(\Delta r)$ could be explained by three distinct hypotheses:
- first, each individual follows a Levy trajectory with jump size distribution given by equation (1) (hypothesis A);
- second, the observed distribution captures a population-based heterogeneity, corresponding to the inherent differences between individuals (hypothesis B);
- third, a population-based heterogeneity coexists with individual Levy trajectories (hypothesis C); hence, equation (1) represents a convolution of hypotheses A and B.

## The distribution of $r_g$
To distinguish between hypotheses A, B and C, we calculated **the radius of gyration** for each user (see Supplementary Information IV)

$$P(r_g)=(r_g+r_g^0)^{-\beta_r}exp(-r_g/\kappa)$$

Question: 如何计算$R_g$？回转半径如何理解？

## Relationship Between ${r_g}$ and t
The longer we observe a user, the higher the chance that she/he will travel to areas not visited before.
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

## Relationship Between $P(\Delta r | r_g)$ and $\Delta r$

图2b显示，$r_g$较小的用户，通常在小范围内活动，而那些具有大的$r_g$的人，则更倾向于选择许多小和几个更大的跳跃大小(jump size)的组合。
>As the inset of Fig. 2b shows, users with small $r_g$ travel
mostly over small distances, whereas those with large $r_g$ tend to
display a combination of many small and a few larger jump sizes.

对坐标轴进行rescale以后，多条曲线合并成了一条直线，这表面，可能有一个单一的jump size分布，能够拟合所有人。
> Once we rescaled the distributions with $r_g$ (Fig. 2b), we found that the
data collapsed into a single curve, suggesting that a single jump size distribution characterizes all users.

$$P(\Delta r | r_g) \sim r_g^{-\alpha} F(\Delta r | r_g)$$

where $\alpha \approx 1.2 \pm 0.1$ and F(x) is an $r_g$-independent function with asymptotic behaviour, that is,
$F(x) \sim x^{-a}$ for x < 1 and F(x) rapidly decreases for x >> 1
（这个F函数在x<1时是幂律的，x>1时急剧下降）

因此，个体用户的旅行模式可以通过基于$r_g$的特征距离的Levy飞行来近似。然而，最重要的是，个体轨迹的范围受到$r_g$范围的限制;因此，作为列维飞行的明显而反常性质的来源的那种大尺度飞行（地理空间上的跨越）在统计上好像消失了。
> Therefore, the travel patterns of individual users may be approximated by a Levy flight up to a distance characterized by rg.
Most important, however, is the fact that the individual trajectories are bounded beyond rg;
thus, large displacements, which are the source of the distinct and anomalous nature of Levy flights, are statistically absent.

这表明，我们所观察到的$P(\Delta r)$ 的分布实际上是对个体轨迹的统计$P(\Delta r | r_g)$ 和群体的异质性$P(r_g)$之间的卷积，也就是说，假设C成立。
> This indicates that the observed jump size distribution $P(\Delta r)$ is in fact
the convolution between the statistics of individual trajectories $P(\Delta r | r_g)$ and
the population heterogeneity P(rg), consistent with hypothesis C.

计算t小时后第一次观测到某人出现在某地的概率
> To uncover the mechanism stabilizing $r_g$, we measured the return probability for each individual $F_{pt}(t)$
(first passage time probability)
defined as the probability that a user returns to the position where he/she was first observed after t hours (Fig. 2c).

人们的返回概率（return probability）往往会在24h、48h、72h后出现峰值
> In contrast, we found that the return probability is characterized by several peaks at 24 h, 48 h and 72 h,
capturing a strong tendency of humans to return to locations they visited before,
describing the recurrence and temporal periodicity inherent to human mobility

将地点（location）按照被访问次数排序（rank），通过记录个体（individual）所在的附近地区（vicinity），发现符合Zipf分布。
> To explore if individuals return to the same location over and over,
we ranked each location on the basis of the number of times an individual was recorded in its vicinity

一个人去的地方的排名（rank），记为L的概率P可以用1/L来预测，而与用户去的地方的数量无关（对于去5个、10个、30个、50个地方的用户，他们的幂指数都是一样的）
> We find that the probability of finding a user at a location with a given rank L is well approximated by $P(L) \sim 1/L$, independent of the number of locations visited by the user (Fig. 2d).

## Preferential Return
人们大部分时间只会在很少的几个地方
> Therefore, people devote most of their time to a few locations,
although spending their remaining time in 5 to 50 places, visited with diminished regularity.

Therefore, the observed logarithmic saturation of $r_g(t)$ is rooted in the high degree of regularity in the daily travel patterns of individuals,
captured by the high return probabilities (Fig. 2b) to a few highly frequented locations (Fig. 2d).
因此，之前观察到的$r_g$的对数饱和度是根据个人的日常旅行模式的高度规律性，由高回报概率捕获到几个高度常见的地点

每个用户可以被分配到由家庭和工作场所定义的明确定义的区域，在那里她或他大部分时间都能被找到。
> each user can be assigned to a well defined area, defined by home and workplace,
where she or he can be found most of the time.

我们的结果表明：
- 在银行纸币测量中观察到的Levy统计数据捕获了等式(2)中所示的- 群体异质性与个体用户的运动的卷积。
- 个人显示出显着的规律性，因为他们回到几个经常访问的地方，如家庭或工作。
- 这种规律性不适用于钞票：票据总是遵循其当前所有者的轨迹; 也就是说，美元钞票弥漫（是散播开的），但人类没有。

> Taken together, our results suggest that
the Levy statistics observed in bank note measurements capture a convolution of the population heterogeneity shown in equation (2) and the motion of individual users.
Individuals display significant regularity, because they return to a few highly frequented locations, such as home or work.
This regularity does not apply to the bank notes: a bill always follows the trajectory of its current owner; that is, dollar bills diffuse, but humans do not.

总而言之，个体轨迹可以由相同的、与$r_g$独立的二维概率分布表征，这表明个体轨迹的关键统计特征在重新缩放之后在很大程度上是不可区分的。因此，我们的结果确立了agent-based modelling的基本假设，要求我们将对用户的数量要与给定区域的人口密度成比例，并向每个用户分配取自观察到的$P(r_g）$分布的$r_g$。使用预测的各向异性重新缩放，结合密度函数，其形状提供为Supplementary Table 1，
我们可以获得在任何位置找到用户的可能性。鉴于空间接近度和社会联系之间的已知相关性，我们的结果可以帮助量化空间在网络发展和进化中的作用，并增进我们对扩散过程的理解。

> The fact that individual trajectories are characterized by the same rg-independent two-dimensional probability distribution
suggests that key statistical characteristics of individual trajectories are largely indistinguishable after rescaling.
Therefore, our results establish the basic ingredients of realistic agent-based models,
requiring us to place users in number proportional with the population density of a given region
and assign each user an rg taken from the observed P(rg) distribution.
Using the predicted anisotropic rescaling, combined with the density function, the shape of which is provided as Supplementary Table 1,
we can obtain the likelihood of finding a user in any location.
Given the known correlations between spatial proximity and social links, our results could help quantify the role of space in network development and evolution and improve our understanding of diffusion processes.
