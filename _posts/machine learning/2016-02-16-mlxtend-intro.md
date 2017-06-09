---
layout: single
title: "Mlxtend简介"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-8.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "Mlxtend是一个基于Python的开源项目，主要为日常处理数据科学相关的任务提供了一些工具和扩展。"
modified: 2016-02-16T11:55:22-04:00
comments: true
author_profile: true
author: "陈志聪"
---

{% include toc title="Table" icon="file-text" %}

<p>Mlxtend是一个基于Python的开源项目，主要为日常处理数据科学相关的任务提供了一些工具和扩展，项目的Github地址：https://github.com/rasbt/mlxtend</p>
<p>在项目文档的User Guide一栏可以看到，mlxtend主要提供如下几个大类的工具模块</p>

## classifier

<ul>
<li>Adaline</li>
<li>EnsembleVoteClassifier</li>
<li>LogisticRegression</li>
<li>NeuralNetMLP</li>
<li>Perceptron</li>
</ul>
<h3>regressor</h3>
<ul>
<li>LinearRegression</li>
</ul>
<h3>regression_utils</h3>
<ul>
<li>plot linear regression</li>
</ul>
<h3>feature_selection</h3>
<ul>
<li>SequentialFeatureSelector</li>
</ul>
<h3>evaluate</h3>
<ul>
<li>Confusion Matrix</li>
<li>Plot decision regions</li>
<li>Plot learning curves</li>
<li>Scoring</li>
</ul>
<h3>preprocesssing</h3>
<ul>
<li>DenseTransformer</li>
<li>MeanCenterer</li>
<li>Minmax scaling</li>
<li>Shuffle arrays unison</li>
<li>Standardize</li>
</ul>
<h3>data</h3>
<ul>
<li>AutoMPG data</li>
<li>Boston housing data</li>
<li>Iris data</li>
<li>Mnist data</li>
<li>Load mnist</li>
<li>Wine data</li>
</ul>
<h3>file_io</h3>
<ul>
<li>Find filegroups</li>
<li>Find files</li>
</ul>
<h3>general plotting</h3>
<ul>
<li>Category scatter</li>
<li>Enrichment plot</li>
<li>Stacked barplot</li>
</ul>
<h3>math</h3>
<ul>
<li>Num combinations</li>
<li>Num permutations</li>
</ul>
<h3>text</h3>
<ul>
<li>Generalize names</li>
<li>Generalize names duplcheck</li>
<li>Tokenizer</li>
</ul>
<h3>utils</h3>
<ul>
<li>Counter</li>
</ul>
<h3>general concepts</h3>
<ul>
<li>Activation functions</li>
<li>Gradient optimization</li>
<li>Linear gradient derivative</li>
<li>Regularization linear</li>
</ul>

<p>以上每个工具模块都附有相应的example、API和source code，可方便查阅。</p>

附上项目首页的example:


```python
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import itertools
from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from mlxtend.classifier import EnsembleVoteClassifier
from mlxtend.data import iris_data
from mlxtend.evaluate import plot_decision_regions

# Initializing Classifiers
clf1 = LogisticRegression(random_state=0)
clf2 = RandomForestClassifier(random_state=0)
clf3 = SVC(random_state=0, probability=True)
eclf = EnsembleVoteClassifier(clfs=[clf1, clf2, clf3], weights=[2, 1, 1], voting='soft')

# Loading some example data
X, y = iris_data()
X = X[:,[0, 2]]

# Plotting Decision Regions
gs = gridspec.GridSpec(2, 2)
fig = plt.figure(figsize=(10, 8))
for clf, lab, grd in zip([clf1, clf2, clf3, eclf],
                         ['Logistic Regression', 'Random Forest', 'Naive Bayes', 'Ensemble'],
                         itertools.product([0, 1], repeat=2)):
    clf.fit(X, y)
    ax = plt.subplot(gs[grd[0], grd[1]])
    fig = plot_decision_regions(X=X, y=y, clf=clf, legend=2)
    plt.title(lab)
plt.show()
```


![mlxtend](http://oaf2qt3yk.bkt.clouddn.com/360c0ed483cba387f8351821ff5c99c5.png)
