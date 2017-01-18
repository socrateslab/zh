---
title: "许小可"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-18.jpg
  teaser: /assets/images/author/xiaoke.jpg
  excerpt: ""
author: "许小可"
---
许小可，男，1979年5月生，教授。 2008年6月博士毕业于大连海事大学通信与信息系统专业，曾为香港理工大学博士后，香港城市大学访问学者。目前为大连民族大学信息与通信工程学院学术带头人、民族信息资源挖掘与利用研究所所长。主持国家自然科学基金2项，参与国家自然科学基金项目1项，主持省自然科学基金等省部级项目2项，参与省部级项目1项。共发表学术论文33篇，其中SCI检索论文20篇。2013年入选辽宁省优秀人才支持计划，获得CCF-腾讯犀牛鸟科研基金资助，在阿里巴巴数据创新大赛暨阿里巴巴青年学者支持计划一等奖；2014年获得大连市“青年科技之星”称号。

<ul>
{% for post in site.posts %}
  {% if post.author == page.author %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>
