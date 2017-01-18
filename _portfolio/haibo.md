---
title: "胡海波"
excerpt: "华南理工大学商学院副教授"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-18.jpg
  teaser: /assets/images/author/haibo.jpg
sidebar:
  - title: "胡海波"
    image: "/assets/images/author/haibo.jpg"
    image_alt: "logo"
author: "胡海波"
---
研究方向：网络科学，社交网络，社会化媒体，计算社会学，系统工程

### 教育背景

- 2006/09－2010/03，上海交通大学，工学博士
- 2003/09－2006/04，西安理工大学，工学硕士
- 1999/09－2003/07，西安理工大学，工学学士

### 工作经历

- 2010/07－至今，华东理工大学管理科学与工程系
- 2010/03－2010/05，中国科学院自动化研究所
- 海外经历 2013/02－2013/08，香港城市大学媒体与传播系，博士后研究员


<ul>
{% for post in site.posts %}
  {% if post.author == page.author %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>
