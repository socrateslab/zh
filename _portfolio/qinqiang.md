---
title: "秦强"
excerpt: "南京大学新闻传播学院硕士"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-18.jpg
  teaser: /assets/images/author/qinqiang.jpg
sidebar:
  - title: "秦强"
    image: "/assets/images/author/qinqiang.jpg"
    image_alt: "logo"
author: "秦强"
---

<ul>
{% for post in site.posts %}
  {% if post.author == page.author %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>
