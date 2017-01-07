---
layout: single
title: "Quantifying the evolutionary dynamics of language"
modified: 2017-01-07T09:53:00
comments: true
categories:
  - group dynamics
tags:
  - language evolution
excerpt: ""
author: "王成军"
---

{% include toc title="Table" icon="file-text" %}

Lieberman, E., Michel, J. B., Jackson, J., Tang, T., & Nowak, M. A. 于2007年在《自然》杂志上发表了题为 Quantifying the evolutionary dynamics of language. Nature的论文。[^lieberman]

[^lieberman]: Lieberman, E., Michel, J. B., Jackson, J., Tang, T., & Nowak, M. A. (2007). Quantifying the evolutionary dynamics of language. Nature, 449(7163), 713-6.

Human language is based on grammatical rules<sup>1–4</sup>. **Cultural evolution** allows these rules to change over time<sup>5</sup>.

> Rules compete with each other: as new rules rise to prominence, old ones die away.

To quantify the dynamics of language evolution, we studied the **regularization of English verbs** over the past 1,200 years.

Although an elaborate system of productive conjugations existed in English’s proto-Germanic ancestor, Modern English uses the dental suffix, ‘-ed’, to signify past tense<sup>6</sup>.

Here we describe the emergence of this linguistic rule amidst the evolutionary decay of its exceptions, known to us as irregular verbs.

We have generated a data set of verbs whose conjugations have been evolving for more than a millennium, tracking inflectional changes to 177 Old-English irregular verbs. Of these irregular verbs, 145 remained irregular in Middle English and 98 are still irregular today.

We study how the rate of regularization depends on the frequency of word usage. **The half-life of an irregular verb scales as the square root of its usage frequency**: a verb that is 100 times less frequent regularizes 10 times as fast.

![irregular_verbs](http://oaf2qt3yk.bkt.clouddn.com/78461a58dc9b63c10ac16c97dfda8cb8.png)

从F1a可知不规则动词随着历史演进使用越来越少，尤其是低频使用的动词。随着动词使用频率的增加，不规则动词数量先增加后降低。也就是说那些使用频率很少或很多的动词当中不规则的情况较少，而那些使用频率不多不少的动词的不规则情况较多。

> Irregular verbs regularize at a rate that is inversely proportional to the square root of their usage frequency.

F1b则告诉我们动词时态被规则化使用的比例**反比于**这个词语的使用频率的平方根（-0.48，-0.51）。

The relative regularization rates obtained by comparing Old versus Modern English (green) and Middle versus Modern English (red) scale linearly on a log–log plot with a downward slope of nearly one-half. The regularization rate and the half-life scale with the square root of the frequency.

![irregular_verbs_time](http://oaf2qt3yk.bkt.clouddn.com/45a6eda1d8d1c859f2461d9a46669c03.png)

we can estimate actual **half-lives** of the irregular verbs in different frequency bins. Irregular verbs that occur with a frequency between $10^6$ and $10^5$ have a half-life of about 300 years, whereas those with a frequency between 1024 and $10^3$ have a half-life of 2,000 years.

If we fit half-life versus frequency with a straight line in a log–log plot, we obtain a slope of 0.50, which again suggests that the half-life of irregular verbs is proportional to approximately the
square root of their frequency (Fig. 2b).

Our study provides a quantitative analysis of the regularization process by which ancestral forms gradually yield to an emerging linguistic rule.

# 参考文献
