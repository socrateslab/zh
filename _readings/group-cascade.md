---
layout: single
title: "Lifecycle and Cascade of WeChat Social Messaging Groups"
modified: 2017-01-26T09:53:00
comments: true
categories:
  - group dynamics
tags:
  - wechat
excerpt: ""
author: "王成军"
---

{% include toc title="Table" icon="file-text" %}

Jiezhong Qiu于2016年在WWW会议上发表了题为 The Lifecycle and Cascade of WeChat Social Messaging Groups的论文。[^qiu]

[^qiu]: Qiu, J., Li, Y., Tang, J., Lu, Z., Ye, H., & Chen, B., et al. (2016). The Lifecycle and Cascade of WeChat Social Messaging Groups. International Conference on World Wide Web (pp.311-320). International World Wide Web Conferences Steering Committee.

wechat是一种social messaging groups，基于手机的app应用，虽然市场占有率还没有whatsapp多，但是增长趋势非常惊人。

微信的数据一直以来比较难获得，清华大学和香港科技大学杨强团队、康奈尔大学与微信数据部门合作。

long-term and short-term groups are inherently distinct.

![long-short-group](http://oaf2qt3yk.bkt.clouddn.com/d2259f67bda9f10a1061a0196a0e4218.png)

“Beside studying the friendship structure, we also discuss the group formation processes, namely by investigating the group membership invitation cascading tree structure. We start with defining the group cascade tree below.”

**Wiener index**, is useful for disambiguating between shallow, broadcast-like diffusion and the deep branching structures.

Wiener index is defined by the average distance between any two nodes in the cascade tree. For example, the cascade trees in Fig- ure 4(a) and Figure 4(b) have Wiener indexes of 3.99 and 1.83, respectively.

![graphical-example-wechat](http://oaf2qt3yk.bkt.clouddn.com/6a1232e626c94bba46428bbcb700d5b6.png)

For instance, the **big dotted circle** in Figure 6 encompasses all the current members within a group.

There are two essential steps behind each invitation:
- 1) a member in a group become active (denoted by blue in Figure 6), and
- 2) the active member selects his/her friends (denoted by red in Figure 6) into the group chat.

**Invitation Interval** is defined as the time inter- val between any two consecutive invitations from a group member.

Additionally, First Invitation Latency is defined as the interval be- tween the timestamp at which a user joins a group (invited by some existing member) and the timestamp when he/she, for the first time, invites another friend to the same group.

we develop a membership cascade model and demonstrate the effectiveness by achieving AUC of 95.31% in predicting inviter, and an AUC of 98.66% in predicting invitee.

# 参考文献
