---
layout: single
title: "Common ecology quantifies human insurgency"
modified: 2016-12-27T11:55:22-04:00
comments: true
categories:
  - group dynamics
tags:
  - human insurgency
excerpt: ""
author: "王成军"
---

{% include toc title="Table" icon="file-text" %}

Juan Camilo Bohorquez, Sean Gourley, Alexander R. Dixon, Michael Spagat & **Neil F. Johnson** (2009) ``Common ecology quantifies human insurgency``. Nature


- [x] this is a complete item
- [ ] this is an incomplete item


Johnson等人声称发现了量化人类叛乱的共同生态。人类叛乱在事件规模和单位时间事件数量方面都具有明显的长尾特征。Neil F. Johnson也是一个金融物理学家，他的书包括Financial market complexity。

# Abstract
Many collective human activities, including violence, have been shown to exhibit universal patterns<sup>1–19</sup>. The size distributions of casualties both in whole wars from 1816 to 1980 and terrorist attacks have separately been shown to follow approximate power-law distributions <sup>6,7,9,10</sup>. However, the possibility of universal patterns ranging across wars in the size distribution or timing of within conflict events has barely been explored. Here we show that the **sizes and timing** of violent events within different insurgent conflicts exhibit remarkable similarities. We propose a unified model of human insurgency that reproduces these commonalities, and explains conflict-specific variations quantitatively in terms of underlying rules of engagement. **_Our model treats each insurgent population as an ecology of dynamically evolving, self-organized groups following common decision-making processes._** Our model is consistent with several recent hypotheses about modern insurgency <sup>18–20</sup>, is robust to many generalizations <sup>21</sup>, and establishes a quantitative connection between human insurgency, global terrorism <sup>10</sup> and ecology <sup>13–17,22,23</sup>. Its similarity to financial market models <sup>24–26</sup> provides a surprising link between violent and non-violent forms of human behaviour.

## 事件规模

![event_size](http://oaf2qt3yk.bkt.clouddn.com/2ac3ad1f05afe7d5d2e5e4c81f84612a.png)

事件的规模采用死亡人员数量来衡量，主要因为死亡人数更容易核实。从累计概率分布来看具有明显长尾特征。根据图1，其中事件规模的幂指数$\alpha \sim 2.5$。


值得注意的是在叛乱事件当中，有更多非常小的事件；而在战争当中（如西班牙内战和美国内战），有相对少的非常小的事件。这导致了叛乱更趋向于幂律分布，而内战更趋向于对数正态分布。如果用幂律来拟合两者的话，内战因为更趋近于正态，幂指数$\alpha$更小（约为1.7）。

## 事件的时间特征

![event_timing](http://oaf2qt3yk.bkt.clouddn.com/4cdcec77309bb63a0b788f604d76f22d.png)

横轴是每天发生暴乱事件的数量$n$, 纵轴是每天叛乱事件数量n的概率分布$p(n)$。其实，它衡量的是单位事件数量的分布，即有多少天发生了n件叛乱事件。

显然有些事件的timing是幂律分布（如Iraq days 0-180），有些是对数正态分布（如Colombia days 0-500、Iraq 540+）。

与随机情况相比，作者所提出的模型更好的拟合了真实数据。

## 媒介驱动的群体动力学模型

![insurgency_model](http://oaf2qt3yk.bkt.clouddn.com/5ed94c5298fa1ccc0098a02a38aed152.png)

在这个模型里有两种运行机制：

1. Mechanism (1): ongoing group dynamics **within** the insurgent population (for example, as a result of internal interactions and/or the presence of an opposing entity such as a state army);
2. Mechanism (2): group decision-making about **when to attack** based on competition for ``media attention``.

根据上图，作者刻画叛乱的模型框架是从媒介报道展开的：

1. 在时间点t媒体会广播叛乱事件。【机制2】
2. 在时间点t媒体报道会改变群体的策略和自信水平【机制2】
3. 在时间点t群体内部互动（联合或分裂）【机制1】
4. 机制1构成群体重组，机制2决定自群体在时间点t的攻击决策
5. 上述过程构成时间点t的叛乱事件数$n_x(t)$
    - 数据分析：
      - 时间点t的事件数量在规模维度上汇总 $\sum_x n_x(t) $, 【size-aggregated】
      - 规模为x的事件数量在时间维度上汇总 $\sum_t n_x (t)$, 【time-aggregated】
6. 在时间点t更新叛乱事件的新闻

作者认为

- 机制1导致了时间维度汇总的事件数量的分布（Figure2）size-aggregated】；
- 机制2导致了规模维度汇总的时间数量的分布（Figure3）【time-aggregated】。

首先，就机制1而言，叛乱群体内部的互动包括了分裂(fragmentation, $v_{frag}$)与合并（coalesce, $v_{coal}$）两类。
  - 一个群体分裂的概率一般比较小，约为1%。
  - 当两个力量为$s_1$和$s_2$的两个群体合并的时候，他们的力量变为$s_1 + s_2$。

然后，从平均的角度来看机制2：
  - 假设所有组参与叛乱的概率相等；
  - 群体力量$s$按时间进行平均的分布即叛乱事件的规模$x$分布。
  - 以上过程导致一个稳定的幂律分布，幂指数围绕2.5左右摇摆。[^finance] [^book]

[^finance]: APAR. D'HULST, & G. J. RODGERS. (2011). Exact solution of a model for crowding and information transmission in financial

[^book]: markets. International Journal of Theoretical & Applied Finance, 03(4), 303-320.

26. Financial market complexity / Neil F. Johnson, Paul Jefferies, Pak Ming Hui. Oxford University Press, 2003.
  
![](http://oaf2qt3yk.bkt.clouddn.com/schema_regime.PNG)  



# 参考文献


