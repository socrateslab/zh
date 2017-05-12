---
layout: single
title: "解决python读取文本数据中的encoding问题"
header:
  teaser: "/assets/images/unsplash-gallery-image-2-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-18.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "在使用python读取一些数据的实际应用当中，我们总会遇到各各种各样的encoding的问题，一般会使用utf8，中文常用的是gb18030和gbk。有时候这种问题非常令人头痛，有没有一种终极的解决方案？采用二进制的方法就可以读取，然后需要将二进制的字符串进行相应的decode，并忽略出错的地方。"
modified: 2017-03-22 19:49:48
comments: true
author: "王成军"
tags:
  - encoding
categories:
  - python
---

在使用python读取一些数据的实际应用当中，我们总会遇到各各种各样的encoding的问题，一般会使用utf8，中文常用的是gb18030和gbk。有时候这种问题非常令人头痛，有没有一种终极的解决方案？采用二进制的方法就可以读取，然后需要将二进制的字符串进行相应的decode，并忽略出错的地方。

这种解决方案的一个案例见[这里](http://stackoverflow.com/questions/38728366/pandas-cannot-load-data-csv-encoding-mystery)[^weiboscope]。Kristof评论说：

[^weiboscope]: 值得注意的是这里也是中文的文本，来自于香港大学抓取的新浪微博的数据。

> It seems that there's something very wrong with the input file. There are encoding errors throughout. One thing you could do, is to read the CSV file as a binary, decode the binary string and replace the erroneous characters.

在复旦上课的过程中，葆华老师发现一个抓取的微博公众号数据没有办法很好地使用pandas读取，我们尝试了各种encoding的策略都不可以。这个文本文件在mac环境中可以采用mac自带的文本编辑软件可以打开，但使用sublime却无法打开，采用visual studio code编辑器指定gbk或者gb18030都可以正确打开，这使得我意识到这个数据本身就是一个gb18030编码的数据，只是因为存在各种不规则的的东西使得解码变得很苦难。

借助于以上解决方法，采用以下python代码就可以有效地解决问题。

```python

in_filename = '/Users/chengjun/github/cjc/data/try.txt'
out_filename = '/Users/chengjun/github/cjc/data/try4.txt'

from functools import partial
# chunksize = 100*1024*1024 # read 100MB at a time

# Decode with UTF-8 and replace errors with "?"
with open(in_filename, 'rb') as in_file:
    with open(out_filename, 'w') as out_file:
        # for byte_fragment in iter(partial(in_file.read, chunksize), b''):
        for byte_fragment in iter(partial(in_file.read), b''):
            byte_file = byte_fragment.decode(encoding='gb18030', errors='replace')
            out_file.write(byte_file.encode('utf8'))

# Now read the repaired file into a dataframe
import pandas as pd
df = pd.read_csv(out_filename, sep = ';')
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>公众号昵称</th>
      <th>微信号</th>
      <th>公众号类别</th>
      <th>作者</th>
      <th>发布位置</th>
      <th>是否原创</th>
      <th>标题</th>
      <th>文章链接</th>
      <th>摘要</th>
      <th>正文</th>
      <th>...</th>
      <th>更新时间</th>
      <th>Unnamed: 19</th>
      <th>Unnamed: 20</th>
      <th>Unnamed: 21</th>
      <th>Unnamed: 22</th>
      <th>Unnamed: 23</th>
      <th>Unnamed: 24</th>
      <th>Unnamed: 25</th>
      <th>Unnamed: 26</th>
      <th>Unnamed: 27</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>中国政府网</td>
      <td>zhengfu</td>
      <td>政务</td>
      <td>NaN</td>
      <td>0</td>
      <td>0</td>
      <td>李克强“盯”住农民工欠薪：决不能让他们背井离乡流汗再流泪</td>
      <td>http://mp.weixin.qq.com/s?__biz=MzA4MDA0MzcwMA...</td>
      <td>“农民工在外打工非常不易，决不能让他们背井离乡流汗再流泪！”李克强斩钉截铁地说。</td>
      <td>丨来源：新京报新媒体鲁甸地震受灾群众甘永荣的一句话，让李克强总理的表情立刻凝重起来。“你打工...</td>
      <td>...</td>
      <td>2017-01-27 11:32:16</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>中国政府网</td>
      <td>zhengfu</td>
      <td>政务</td>
      <td>NaN</td>
      <td>0</td>
      <td>0</td>
      <td>总理对话农民工，问过哪些问题？</td>
      <td>http://mp.weixin.qq.com/s?__biz=MzA4MDA0MzcwMA...</td>
      <td>总理考察活动时和农民工聊过什么话题？说过哪些话？中国政府网为你一一梳理。</td>
      <td>总理考察活动时和农民工聊过什么话题？说过哪些话？中国政府网为你一一梳理。 总理和农民工聊过这...</td>
      <td>...</td>
      <td>2017-02-02 11:32:48</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>中国政府网</td>
      <td>zhengfu</td>
      <td>政务</td>
      <td>NaN</td>
      <td>0</td>
      <td>0</td>
      <td>云南考察 | 李克强：农民工欠薪问题必须反复抓、抓到底</td>
      <td>http://mp.weixin.qq.com/s?__biz=MzA4MDA0MzcwMA...</td>
      <td>李克强23日考察灾后重建的云南鲁甸，再三问询围拢人群，有没有没领到工资的农民工？现场陆续有人...</td>
      <td>李克强春节前重回鲁甸李克强23日重回云南鲁甸考察灾后重建。看到这里焕然一新的面貌，总理说，你...</td>
      <td>...</td>
      <td>2017-01-26 13:16:40</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>中国政府网</td>
      <td>zhengfu</td>
      <td>政务</td>
      <td>NaN</td>
      <td>0</td>
      <td>0</td>
      <td>李克强：决不能让农民工的辛勤付出得不到回报</td>
      <td>http://mp.weixin.qq.com/s?__biz=MzA4MDA0MzcwMA...</td>
      <td>李克强：决不能让农民工的辛勤付出得不到回报</td>
      <td>2月3日，春节后的首个工作日，国务院召开常务会议，其中议题之一便是部署建立解决农民工工资拖欠...</td>
      <td>...</td>
      <td>2017-02-07 11:38:30</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>中国政府网</td>
      <td>zhengfu</td>
      <td>政务</td>
      <td>NaN</td>
      <td>0</td>
      <td>0</td>
      <td>48小时!总理帮震区农民工“讨”回欠薪</td>
      <td>http://mp.weixin.qq.com/s?__biz=MzA4MDA0MzcwMA...</td>
      <td>48小时！总理帮震区农民工“讨”回欠薪</td>
      <td>丨来源：新京报新媒体1月25日早上8点半，甘永荣的银行卡里打进来5.8万元。这是李克强总理帮...</td>
      <td>...</td>
      <td>2017-01-29 11:57:45</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 28 columns</p>
</div>
