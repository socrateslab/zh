---
layout: single
title: "Principles of scientific research team formation and evolution"
modified: 2017-02-06T09:53:00
comments: true
categories:
  team science
tags:
  team formation
excerpt: ""
author: "王成军"
---

{% include toc title="Table" icon="file-text" %}

Milojevic于2014年在PNAS上发表了题为 Principles of scientific research team formation and evolution的论文。[^Milojevic]

![milojevic](http://oaf2qt3yk.bkt.clouddn.com/9e05fb9022d0cfe9902698911898ba50.png)

Staša Milojević is an Associate Professor in the School of Informatics and Computing, a core faculty of Cognitive Science program, and a fellow of Rob Kling Center for Social Informatics at Indiana University, Bloomington. Learn more from her [Personal Website](http://homes.soic.indiana.edu/smilojev/)

[^Milojevic]: Milojevic S. 2014. Principles of scientific research team formation and evolution. PNAS 111:3984–89


Research teams are the fundamental social unit of science, and yet there is currently no model that describes their basic property: size.

In most fields, teams have grown significantly in recent decades. We show that this is partly due to the change in the character of `team size distribution`. We explain these changes with a comprehensive yet straightforward model of how teams of different sizes emerge and grow.

This model accurately reproduces the evolution of empirical team size distribution over the period of 50 y.

The modeling reveals that there are `two modes of knowledge production`.

- The first and more fundamental mode employs relatively small, `“core” teams`. Core teams form by a Poisson process and produce a Poisson distribution of team sizes in which larger teams are exceedingly rare.
- The second mode employs `“extended” teams`, which started as core teams, but subsequently accumulated new members proportional to the past productivity of their members. Given time, this mode gives rise to a power-law tail of large teams (10–1,000 members), which features in many fields today.

Based on this model, we construct an analytical functional form that allows the contribution of different modes of authorship to be determined directly from the data and is applicable to any field. The model also offers a solid foundation for studying other social aspects of science, such as productivity and collaboration.

# Introduction

A research team is a group of researchers collaborating to produce scientific results, which are primarily communicated in the form of research articles.
{: .notice--primary}

Many studies focused only on the mean or the median sizes of teams, implicitly assuming that the character of the distribution of team sizes does not change.
{: .notice--warning}

The *goal* of the current study is to present a more accurate characterization and go beyond empirical observations to provide a model of scientific research team formation and evolution that leads to the `observed team size distributions`.

# Pattern

Data: 150,000 articles published in the field of astronomy since the 1960s. [^MILOJEVIC2012]

[^MILOJEVIC2012]: Milojevic S (2012) How are academic age, productivity and collaboration related to citing behavior of researchers? PLoS One 7(11):e49176.

![MILOJEVIC2012](http://oaf2qt3yk.bkt.clouddn.com/8c331b6cfcdaf31a8e2b2682eb62794e.png)

> Team assembly can be viewed as a low-rate event, because its realization involves few authors out of a very large possible pool of researchers.

# Model of Team Formation and Evolution

- The model consists of authors who write papers over time.
- Each paper has a “lead” author who is responsible for putting together a team and producing a paper.
- Each lead author is associated with two types of teams: “core” and “extended.”
- Core teams consist of the lead author and coauthors. Their size is drawn from a Poisson distribution with some rate λ.
  - If the drawing yields the number 1, the core team consists of the lead author alone.
  - We allow λ, the characteristic size of core teams, to grow with time.
- Existing authors, when they publish again, retain their original core teams.
- The probability of publishing by an author who has published previously is 0.8.
- Initially, the extended team has the same members as the core team.
- However, the extended team is allowed to add new members in proportion to the aggregate productivity of its current members.
- New extended team members are randomly chosen from core teams of existing members, or from a general pool if no such candidates are available.
- It is important that extended teams do not replace core teams; they coexist, and the lead author can choose to publish with one or the other at any time.
- In simulation, we assume a fixed probability $p_{ext} = 0.3$ for an article to require an extended team (a constant which does not change over time).

**Additional requirements**

> there is an excess of two-author papers over single-author papers, especially from authors who have just started publishing.

- some fraction of lead authors will form their core teams by adding an additional member to the number drawn from a Poisson distribution. We call such teams “core +1 teams,” as opposed to “standard core teams.”
- Furthermore, we assume that repeat publications are more likely from authors who started publishing more recently.
- Finally, we assume that certain authors retire and their teams are dissolved. However, the process of retirement is not essential to reproduce the empirical team size distribution.

![model generated data](http://oaf2qt3yk.bkt.clouddn.com/cf2da56c3eec63159af9357affdfcd97.png)

> We have tested several flavors of cumulative advantage and found that the empirical distributions are best reproduced when the growth follows the aggregate productivity of all members as lead authors, rather than their productivity that includes coauthorships.
{: .notice--info}

![decomposition-possion-power](http://oaf2qt3yk.bkt.clouddn.com/894d7d5f0e110ed592c3cc490d413cac.png)

![s1-model-comparisions](http://oaf2qt3yk.bkt.clouddn.com/b278c6e12dbdd09a11bf540015a43847.png)

Fig. S1. Comparison of empirical data and model predictions for astronomy (2006–2010).

- `Productivity` (number of articles per author) is determined based on all articles regardless of author role (lead author or coauthor).
- `Collaborators` are defined as all coauthors of a given author from all articles published during this period.
- `The number of teams` with which a given author is involved is determined as the number of different lead authors in all of the papers in which the given author is a coauthor.
- `The largest connected component` is the fraction of all authors that are linked by coauthorship in this time period. Values above 50% signal the emergence of a giant component.

The model by Guimerà et al. requires explicit input on team size for each article, which we take from our model. Then, for the Guimerà et al. predictions, we choose team members by assuming probability p that the team member is an author already present in the network (incumbent), and probability q that the incumbent is already a collaborator of some other team member. We use p = 0.78 and q = 0.82, as appropriate for astronomy (ref. 1, figure 4J). Also, to recreate the Guimerà et al. process fully, we implement removal of authors who have been inactive for longer than 5,000 time steps (ref. 1, supplemental information).

the collaborator distribution, $F_C$, is related to team size distribution as follows: $F_{C}(n) = (n + 1)F(n + 1)$, where F is the team size distribution.

> Both the current and Guimerà et al. methods for team buildup provide good general description of author-centric distributions and of the evolution of coauthorship network topology.

# Analytical Decomposition of Team Size Distributions

- standard core and “core +1” teams are well described by `Poisson functions`, $F_{P1}(k)$ and $F_{P2}(k)$
- extended teams is well described by a `power-law function with a low-end exponential cutoff`, $F_{PL}$.

Therefore, the following analytical function can be fit to the empirical team size distribution to obtain its decomposition:

$$F(k) = F_{P1}(k) + F_{P2}(k) + F_{PL}(k) $$

and

$$F(k)= \left\{\begin{matrix}
n_1 \frac{\lambda_1^k e^{-\lambda_1}}{k!}&,  k = 1\\
n_1 \frac{\lambda_1^k e^{-\lambda_1}}{k!} + n_2 \frac{\lambda_2^k e^{-\lambda_2}}{(k-1)!} + n_3 e^{-\beta / (k-1)} k^{-\alpha} &, k > 1
\end{matrix}\right.   [1]$$

# Application of Analytical Decomposition for Describing Trends in Team Evolution

![team_evolution_trends](http://oaf2qt3yk.bkt.clouddn.com/9e9528c9291ac925019eb190c6ec17a3.png)

### To read：

Peterson GJ, Pressé S, Dill KA (2010) Nonuniversal power law scaling in the probability distribution of scientific citations. Proc Natl Acad Sci USA 107(37):16023–16027.

Guimerà R, Uzzi B, Spiro J, et al. Team Assembly Mechanisms Determine Collaboration Network Structure and Team Performance. Science, 2005, 308(5722):697-702.
{: .notice--info}


# 参考文献
