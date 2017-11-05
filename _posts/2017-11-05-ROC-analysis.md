---
layout: single
title: "ROC分析与统计检验"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-4.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "pROC是一个进行deLong显著性检验的R包。本文介绍计算AUC、绘制ROC曲线、并进行显著性检验。"
modified: 2017-11-05T11:55:22-04:00
comments: true
author_profile: true
author: "王成军"
---

{% include toc title="Table" icon="file-text" %}


> pROC is a R package for visualizing, smoothing and comparing receiver operating characteristic (ROC) curves.[^tom] [^robin]

The (Partial) area under the curve (AUC) can be compared with statistical tests based on U-statistics or bootstrap. [^delong] Confidence intervals can be computed for (p)AUC or ROC curves. Sample size / power computation for one or two ROC curves are available.

[^tom]: Tom Fawcett (2006) “An introduction to ROC analysis”. Pattern Recognition Letters 27, 861–874. DOI: 10.1016/j.patrec.2005.10.010.

[^robin]: Xavier Robin, Natacha Turck, Alexandre Hainard, et al. (2011) “pROC: an open-source package for R and S+ to analyze and compare ROC curves”. BMC Bioinformatics, 7, 77. DOI: 10.1186/1471-2105-12-77.

[^delong]: Elisabeth R. DeLong, David M. DeLong and Daniel L. Clarke-Pearson (1988) “Comparing the areas under two or more correlated receiver operating characteristic curves: a nonparametric approach”. Biometrics 44, 837–845.

# mtcars数据

```R
head(mtcars)
```

|                   | mpg<dbl> | cyl<dbl> | disp<dbl> | hp<dbl> | drat<dbl> | wt<dbl> | qsec<dbl> | vs<dbl> | am<dbl> |      |
| ----------------- | -------- | -------- | --------- | ------- | --------- | ------- | --------- | ------- | ------- | ---- |
| Mazda RX4         | 21.0     | 6        | 160       | 110     | 3.90      | 2.620   | 16.46     | 0       | 1       |      |
| Mazda RX4 Wag     | 21.0     | 6        | 160       | 110     | 3.90      | 2.875   | 17.02     | 0       | 1       |      |
| Datsun 710        | 22.8     | 4        | 108       | 93      | 3.85      | 2.320   | 18.61     | 1       | 1       |      |
| Hornet 4 Drive    | 21.4     | 6        | 258       | 110     | 3.08      | 3.215   | 19.44     | 1       | 0       |      |
| Hornet Sportabout | 18.7     | 8        | 360       | 175     | 3.15      | 3.440   | 17.02     | 0       | 0       |      |
| Valiant           | 18.1     | 6        | 225       | 105     | 2.76      | 3.460   | 20.22     | 1       | 0       |      |

# ROC曲线

```R
library(pROC)

par(mfrow=c(1,2))
plot(vs~wt, mtcars)
plot(vs~am, mtcars)

```

![png]({{ site.url }}{{ site.baseurl }}/assets//img2017/Rplot1.jpeg)


```R
par(mfrow=c(1,1))
plot.roc(vs~wt,mtcars,col="1")
lines.roc(vs~am,mtcars,col='2')
```

![png]({{ site.url }}{{ site.baseurl }}/assets//img2017/Rplot2.jpeg)


# 显著性检验


```R
r1 = roc(vs~wt,mtcars)
r2 = roc(vs~am,mtcars)
roc.test(r1,r2, boot.n = 2000)
```

    |===========================================| 100%

    	Bootstrap test for two correlated ROC curves

    data:  r1 and r2
    D = 4.5831, boot.n = 2000, boot.stratified =
    1, p-value = 4.581e-06
    alternative hypothesis: true difference in AUC is not equal to 0
    sample estimates:
    AUC of roc1 AUC of roc2
      0.8412698   0.5833333

```R
roc.test(roc1, roc2, method="venkatraman")
```

    |===========================================| 100%

    Venkatraman's test for two paired ROC curves

    data:  roc1 and roc2
    E = 578, boot.n = 2000, p-value = 0.024
    alternative hypothesis: true difference in AUC is not equal to 0

# Reference
