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

# 百度百科：敏感度、特异度

考虑一个二分问题，即将实例分成正类（positive）或负类（negative）。对一个二分问题来说，会出现四种情况。如果一个实例是正类并且也被 预测成正类，即为真正类（True positive）,如果实例是负类被预测成正类，称之为假正类（False positive）。相应地，如果实例是负类被预测成负类，称之为真负类（True negative）,正类被预测成负类则为假负类（false negative）。

[列联表](https://baike.baidu.com/item/%E5%88%97%E8%81%94%E8%A1%A8)如下表所示，1代表正类，0代表负类。

|      |      | 预测                        |                           |                        |
| ---- | ---- | ------------------------- | ------------------------- | ---------------------- |
|      |      | 1                         | 0                         | 合计                     |
| 实际   | 1    | True Positive（TP）         | False Negative（FN）        | Actual Positive(TP+FN) |
|      | 0    | False Positive（FP)        | True Negative(TN)         | Actual Negative(FP+TN) |
| 合计   |      | Predicted Positive(TP+FP) | Predicted Negative(FN+TN) | TP+FP+FN+TN            |

从列联表引入两个新名词。其一是真正类率(true positive rate ,TPR), 计算公式为*TPR=TP*/ (*TP*+ *FN*)，刻画的是[分类器](https://baike.baidu.com/item/%E5%88%86%E7%B1%BB%E5%99%A8)所识别出的 正实例占所有正实例的比例。另外一个是假正类率(false positive rate, FPR),计算公式为*FPR= FP / (FP + TN)，*计算的是分类器错认为正类的负实例占所有负实例的比例。还有一个真负类率（True Negative Rate，TNR），也称为specificity,计算公式为TNR=*TN*/ (*FP*+ *TN*) = 1 - *FPR*。

在一个二分类模型中，对于所得到的连续结果，假设已确定一个阈值，比如说 0.6，大于这个值的实例划归为正类，小于这个值则划到负类中。如果减小阈值，减到0.5，固然能识别出更多的正类，也就是提高了识别出的正例占所有正例的比例，即TPR，但同时也将更多的负实例当作了正实例，即提高了FPR。为了形象化这一变化，在此引入ROC。

Receiver Operating Characteristic,翻译为"接受者操作特性曲线"，够拗口的。曲线由两个变量1-specificity 和 Sensitivity绘制. 1-specificity=FPR，即假正类率。Sensitivity即是真正类率，TPR(True positive rate),反映了正类覆盖程度。这个组合以1-specificity对sensitivity,即是以代价(costs)对收益(benefits)。

下表是一个逻辑回归得到的结果。将得到的实数值按大到小划分成10个个数 相同的部分。

| Percentile | 实例数   | 正例数  | 1-特异度(%) | 敏感度(%) |
| ---------- | ----- | ---- | -------- | ------ |
| 10         | 61797 | 4879 | 2.73     | 34.64  |
| 20         | 61797 | 2804 | 9.80     | 54.55  |
| 30         | 61797 | 2165 | 18.22    | 69.92  |
| 40         | 61797 | 1506 | 28.01    | 80.62  |
| 50         | 61797 | 987  | 38.90    | 87.62  |
| 60         | 61797 | 529  | 50.74    | 91.38  |
| 70         | 61797 | 365  | 62.93    | 93.97  |
| 80         | 61797 | 294  | 75.26    | 96.06  |
| 90         | 61797 | 297  | 87.59    | 98.17  |
| 100        | 61797 | 258  | 100.00   | 100.00 |

其正例数为此部分里实际的正类数。也就是说，将逻辑回归得到的结 果按从大到小排列，倘若以前10%的数值作为阈值，即将前10%的实例都划归为正类，6180个。其中，正确的个数为4879个，占所有正类的 4879/14084*100%=34.64%，即敏感度；另外，有6180-4879=1301个负实例被错划为正类，占所有负类的1301 /47713*100%=2.73%,即1-特异度。以这两组值分别作为y值（敏感度）和x值（1-特异度），在excel中作散点图，就可以得到ROC曲线。

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
