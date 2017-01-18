---
title: "王成军"
excerpt: "Cheng-Jun Wang, Ph.D of City University of Hong Kong. He is currently an assistant research fellow in the School of Journalism and Communication, Nanjing University. He is also the director of Ogilvy Data Science Lab, Computational Communication Collaboratory. His research on computational communication appears in both SSCI and SCI indexed journals, such as Scientific Reports, PloS ONE, Physica A, Cyberpsychology, and Journal of Social and Personal Relationships."
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-18.jpg
  teaser: /assets/images/author/chengjun.jpg
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
sidebar:
  - title: "role"
    image: "/assets/images/author/chengjun.jpg"
    image_alt: "logo"
    text: "网站管理员"
  - title: "Responsibilities"
    text: "网站维护"
gallery:
  - url: /assets/images/unsplash-gallery-image-1.jpg
    image_path: assets/images/unsplash-gallery-image-1-th.jpg
    alt: "placeholder image 1"
  - url: /assets/images/unsplash-gallery-image-2.jpg
    image_path: assets/images/unsplash-gallery-image-2-th.jpg
    alt: "placeholder image 2"
  - url: /assets/images/unsplash-gallery-image-3.jpg
    image_path: assets/images/unsplash-gallery-image-3-th.jpg
    alt: "placeholder image 3"
author: "王成军"
---

<ul>
{% for p in site.posts %}
  {% if p.author == page.author %}
    <li><a href="{{ p.url }}">{{ p.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>

{% include gallery caption="" %}
