---
title: "闫小勇"
excerpt: "北京交通大学交通运输学院副教授"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-18.jpg
  teaser: /assets/images/author/xiaoyong.jpg
sidebar:
  - title: "闫小勇"
    image: "/assets/images/author/xiaoyong.jpg"
    image_alt: "logo"
author: "闫小勇"
---

## 教育背景

- 2011/09 – 2014/06，北京师范大学，系统科学学院，系统理论专业，博士研究生（获理学博士学位）
- 2006/09 – 2009/03，石家庄铁道大学，土木工程学院，道路与铁道工程专业，硕士研究生（获工学硕士学位）
- 1998/09 – 2002/06，北京交通大学，交通运输学院，交通运输专业，本科（获工学学士学位）

# 工作经历

- 2015/04 – 至今，北京交通大学，交通运输学院，系统科学研究所，副教授
- 2011/02 – 2011/07，电子科技大学，互联网科学中心，访问学者
- 2010/09 – 2010/12，中国科学技术大学，近代物理系，访问学者
- 2002/07 – 2015/04， 石家庄铁道大学，交通运输学院，历任助教、讲师、副教授

<ul>
{% for post in site.posts %}
  {% if post.author == page.author %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>
