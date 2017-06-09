---
layout: single
title: "使用webgl-globe可视化社会企业家的全球分布"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-15.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "WebGL Globe是一个地理数据可视化的Javascript。我将尝试使用WebGL Globe来可视化社会企业家的全球分布。"
modified: 2015-12-07T11:55:22-04:00
comments: true
categories:
  - 可视化
tags:
  - webGL
author_profile: true
author: "王成军"
---


{% include toc title="Table" icon="file-text" %}


<img src="http://chengjun.qiniudn.com/ashoka-globe.PNG" alt="" /> 效果见<a href="http://chengjun.github.io/globe/ashoka.html">这里</a>

## WebGL Globe

在这个文章中，我将尝试使用<a href="http://www.chromeexperiments.com/globe">WebGL Globe</a>来可视化社会企业家的全球分布。

    Ashoka is the largest network of social entrepreneurs worldwide. Ashoka Fellows are leading social entrepreneurs who we recognize to have innovative solutions to social problems and the potential to change patterns across society. They demonstrate unrivaled commitment to bold new ideas and prove that compassion, creativity, and collaboration are tremendous forces for change. Ashoka Fellows work in over 70 countries around the globe in every area of human need.

WebGL Globe是一个地理数据可视化的Javascript。chromeexperiments.com这个网页列举了其它应用这个WebGL Globe的Javascript的可视化项目，其中一个是Github全球用户的可视化，源码见这里。我们可以直接复制了<a href="https://github.com/aaasen/github_globe/tree/gh-pages">gh-pages分支上的代码</a>，然后上传到了自己的网站（github的gh-pages或者dropbox的public folder）。

根据可视化的目的，我们需要修改index.html, globe.js和json数据三个文件。前两个文件主要制定引用的路径。json数据需要导入我们自己的数据。 这里的数据格式非常简单，只要标定维度，经度，和数值就可以啦。比如：

```python
[["data", [47.68, 9.17, 0.015728264767662276]]]
```

## 数据清洗

我们从Ashoka的网站抓取社会企业家的信息，经过清洗保存在名为ashoka_data_cleaningSep.csv的文件中。首先，我们需要得到国家出现的频数。因为数据很小，使用R代码来实现：

```python
dat2 = read.csv("./ashoka_data_cleaningSep.csv", header = F, sep = "|", quote = "", stringsAsFactors=F); dim(dat2)

names(dat2) = c('name', 'category', 'subsectors', 'targets', 'organization', 'location1', 'location2', 'profileIntro', 'year_fellowship', 'introduction', 'idea', 'problem', 'strategy', 'person', 'rnames', 'rorgs')

# country
country = NULL

for (i in 1:length(dat2$name)){    
    country[[i]] = gsub( ", ", "", dat2$location1[i], fixed = T)
    }

ids = which(nchar(country) &gt; 30) for (i in ids){ cat(dat2$name[i], country[i], '\n') }

country[ids] = c('United States', 'Belgium', 'Czech Republic', 'Paraguay')

data = data.frame(table(country))
write.table(data, './ashoka_country.csv',
  sep = '\t', row.names = FALSE,
  col.names = FALSE, quote = FALSE)
```

然后，我们可以使用谷歌的地理API接口获取这些国家的地理信息（经纬度）。在这篇文章中，我使用pygeocoder这个python包来实现。

```python
from pygeocoder import Geocoder
import time import os

# change work directory
os.chdir('D:/Dropbox/Crystal_RA_Job/Ashoka Project/data/ashoka/')

# read country data
location = {}
with open('./ashoka_country.csv') as f:
for line in f:
    country, freq = line.strip().split('\t')
    location[country] = int(freq)
maxFreq = max(location.values())

# get geo coordinates
results = []  
for i in location.keys():
    time.sleep(1)
    latitude, longtitude = Geocoder.geocode(i)[0].coordinates
    results.extend([latitude, longtitude, location[i]/maxFreq])

# make json
data = [["data",results]]
# save json
import json

with open('./ashoka_locations.json', 'w') as outfile:
    json.dump(data, outfile)
```

## 可视化

在这个可视化当中，每个光柱代表一个国家。截至2013年，有来自76个国家的2334个社会企业家成为ashoka会员。 排名前三的国家依次是印度(N = 303),巴西(N = 286)和美国(N = 160).

使用Python,我们可以将国家频数进行排序：

```python
  sorted(location.items(), key=lambda x: x[1])
```

这里是全部的结果（也是用到的数据）：

```python
 #[('Italy', 1), ('Netherlands', 1), ('Iceland', 1), ('Togo', 1), ('Saudi Arabia', 1),
 # ('Latvia', 1), ('Guinea-Bissau', 1), ('Mozambique', 1), ('Niger', 1), ('Botswana', 1),
 #('Hong Kong S.A.R.China', 1), ('Norway', 2), ('Singapore', 2), ('Denmark', 2),
 #('Morocco', 2), ('Japan', 2), ('Timor-Leste', 2), ('Austria', 2), ('Zambia', 2),
 # ('Afghanistan', 3), ('Sweden', 3), ('Nicaragua', 3), ('Cameroon', 4),
 #('Ivory Coast', 4), ('Lebanon', 5), ('Ghana', 5), ('Israel', 5), ('Guatemala', 5),
 # ('Belgium', 5), ('Switzerland', 5), ('El Salvador', 6), ('Gambia', 6),
 #('Tanzania', 6), ('Lithuania', 7), ('Palestinian Territory', 7), ('Jordan', 8),
 # ('Costa Rica', 10), ('Ireland', 10), ('Mali', 13), ('United Kingdom', 13),
 #('Zimbabwe', 13), ('Venezuela', 15), ('Paraguay', 16), ('Slovakia', 18),
 #('Sri Lanka', 18), ('Senegal', 20), ('Uganda', 20), ('Uruguay', 20),
 # ('Bolivia', 23), ('Kenya', 24), ('Turkey', 24), ('Spain', 25), ('Czech Republic', 26),
 # ('Hungary', 27), ('Burkina Faso', 28), ('Ecuador', 31), ('France', 33), ('Peru', 36),
 # ('Canada', 40), ('Germany', 40), ('Egypt', 40), ('Chile', 41), ('Nepal', 41),
 #('Pakistan', 45), ('Colombia', 50), ('Argentina', 53), ('Bangladesh', 61),
 #('Poland', 69), ('Nigeria', 70), ('Thailand', 88), ('South Africa', 94),
 #('Indonesia', 123), ('Mexico', 153), ('United States', 160), ('Brazil', 286), ('India', 303)]
```

效果见<a href="http://chengjun.github.io/globe/ashoka.html">这里</a>
