---
title: "易红发"
excerpt: "复旦大学新闻学院硕士"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-18.jpg
  teaser: /assets/images/head3.png
sidebar:
  - title: "易红发"
    image: "/assets/images/header3.jpg"
    image_alt: "logo"
author: "易红发"
---

<ul>
{% for post in site.posts %}
  {% if post.author == page.author %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>
