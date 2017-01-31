---
title: "吴令飞"
excerpt: "芝加哥大学社会学院博士后"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-18.jpg
  teaser: /assets/images/author/lingfei.jpg
sidebar:
  - title: "吴令飞"
    image: "/assets/images/author/lingfei.jpg"
    image_alt: "logo"
author: "吴令飞"
---

吴令飞于2013在香港城市大学获得传播学博士学位。从2014年到2015 年他在亚利桑那州立大学的行为、制度与环境中心从事`博士后`研究工作。2016年至今，他在芝加哥大学的知识实验室从事`博士后`研究工作。他的主要研究兴趣是`团队合作与知识的生产`。在研究中，他使用数学建模和机器学习的方法来研究Web of Science，美国专利数据库，Stack Exchange，GitHub 等知识生产系统的大规模数据。他的研究成果发表在Scientific Reports，Physical Review E，PloS ONE等期刊上，并被New Scientist和Science Daily等科学杂志介绍。

<ul>
{% for post in site.posts %}
  {% if post.author == page.author %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>
