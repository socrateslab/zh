---
layout: single
title: "使用Boostrap方法为长尾数据计算置信区间"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-2.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "A robust way to calculate confidence intervals for machine learning algorithms is to use the bootstrap. This is a general technique for estimating statistics that can be used to calculate empirical confidence intervals, regardless of the distribution of skill scores (e.g. non-Gaussian)."
modified: 2018-02-02T11:55:22-04:00
comments: true
author_profile: true
author: "Jason Brownlee"
---

# How to Calculate Bootstrap Confidence Intervals For Machine Learning Results in Python

by [Jason Brownlee](https://machinelearningmastery.com/author/jasonb/) on June 5, 2017 in [Machine Learning Process](https://machinelearningmastery.com/category/machine-learning-process/)



It is important to both present the expected skill of a machine learning model as well as confidence intervals for that model skill.

Confidence intervals provide a range of model skills and a likelihood that the model skill will fall between the ranges when making predictions on new data. For example, a 95% likelihood of classification accuracy between 70% and 75%.

A robust way to calculate confidence intervals for machine learning algorithms is to use the bootstrap. This is a general technique for estimating statistics that can be used to calculate empirical confidence intervals, regardless of the distribution of skill scores (e.g. non-Gaussian)

In this post, you will discover how to use the bootstrap to calculate confidence intervals for the performance of your machine learning algorithms.

After reading this post, you will know:

- How to estimate confidence intervals of a statistic using the bootstrap.
- How to apply this method to evaluate machine learning algorithms.
- How to implement the bootstrap method for estimating confidence intervals in Python.

Let’s get started.

- **Update June/2017**: Fixed a bug where the wrong values were provided to numpy.percentile(). Thanks Elie Kawerk.


## Bootstrap Confidence Intervals

Calculating confidence intervals with the bootstrap involves two steps:

1. Calculate a Population of Statistics
2. Calculate Confidence Intervals

### 1. Calculate a Population of Statistics

The first step is to use the bootstrap procedure to resample the original data a number of times and calculate the statistic of interest.

The dataset is sampled with replacement. This means that each time an item is selected from the original dataset, it is not removed, allowing that item to possibly be selected again for the sample.

The statistic is calculated on the sample and is stored so that we build up a population of the statistic of interest.

The number of bootstrap repeats defines the variance of the estimate, and more is better, often hundreds or thousands.

We can demonstrate this step with the following pseudocode.

```python
statistics = []
for i in bootstraps:
    sample = select_sample_with_replacement(data
    stat = calculate_statistic(sample)
    statistics.append(stat)
```

### 2. Calculate Confidence Interval

Now that we have a population of the statistics of interest, we can calculate the confidence intervals.

This is done by first ordering the statistics, then selecting values at the chosen percentile for the confidence interval. The chosen percentile in this case is called alpha.

For example, if we were interested in a confidence interval of 95%, then alpha would be 0.95 and we would select the value at the 2.5% percentile as the lower bound and the 97.5% percentile as the upper bound on the statistic of interest.

For example, if we calculated 1,000 statistics from 1,000 bootstrap samples, then the lower bound would be the 25th value and the upper bound would be the 975th value, assuming the list of statistics was ordered.

In this, we are calculating a non-parametric confidence interval that does not make any assumption about the functional form of the distribution of the statistic. This confidence interval is often called the empirical confidence interval.

We can demonstrate this with pseudocode below.

```python
ordered = sort(statistics)
lower = percentile(ordered, (1-alpha)/2)
upper = percentile(ordered, alpha+((1-alpha)/2))
```

## Bootstrap Model Performance

The bootstrap can be used to evaluate the performance of machine learning algorithms.

The size of the sample taken each iteration may be limited to 60% or 80% of the available data. This will mean that there will be some samples that are not included in the sample. These are called out of bag (OOB) samples.

A model can then be trained on the data sample each bootstrap iteration and evaluated on the out of bag samples to give a performance statistic, which can be collected and from which confidence intervals may be calculated.

We can demonstrate this process with the following pseudocode.

```python
statistics = []
for i in bootstraps:
    train, test = select_sample_with_replacement(data, size)
    model = train_model(train)
    stat = evaluate_model(test)	statistics.append(stat)
```

## Calculate Classification Accuracy Confidence Interval

This section demonstrates how to use the bootstrap to calculate an empirical confidence interval for a machine learning algorithm on a real-world dataset using the Python machine learning library scikit-learn.

This section assumes you have Pandas, NumPy, and Matplotlib installed. If you need help setting up your environment, see the tutorial:

- [How to Setup a Python Environment for Machine Learning and Deep Learning with Anaconda](http://machinelearningmastery.com/setup-python-environment-machine-learning-deep-learning-anaconda/)

First, download the [Pima Indians dataset](https://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data) and place it in your current working directory with the filename “pima*–*indians*-diabetes.data.csv*“.

We will load the dataset using Pandas.

```python
# load dataset
data = read_csv('pima-indians-diabetes.data.csv', header=None)
values = data.values
```

Next, we will configure the bootstrap. We will use 1,000 bootstrap iterations and select a sample that is 50% the size of the dataset.

```python
# configure bootstrap
n_iterations = 1000
n_size = int(len(data) * 0.50)
```

Next, we will iterate over the bootstrap.

The sample will be selected with replacement using the [resample() function](http://scikit-learn.org/stable/modules/generated/sklearn.utils.resample.html) from sklearn. Any rows that were not included in the sample are retrieved and used as the test dataset. Next, a decision tree classifier is fit on the sample and evaluated on the test set, a classification score calculated, and added to a list of scores collected across all the bootstraps.

```python
# run bootstrap
stats = list()
for i in range(n_iterations):	# prepare train and test sets
    train = resample(values, n_samples=n_size)
    test = numpy.array([x for x in values if x.tolist() not in train.tolist()])
    # fit model
    model = DecisionTreeClassifier()
    model.fit(train[:,:-1], train[:,-1])
    # evaluate model
    predictions = model.predict(test[:,:-1])
    score = accuracy_score(test[:,-1], predictions)
```

Once the scores are collected, a histogram is created to give an idea of the distribution of scores. We would generally expect this distribution to be Gaussian, perhaps with a skew with a symmetrical variance around the mean.

Finally, we can calculate the empirical confidence intervals using the [percentile() NumPy function](https://docs.scipy.org/doc/numpy-dev/reference/generated/numpy.percentile.html). A 95% confidence interval is used, so the values at the 2.5 and 97.5 percentiles are selected.

Putting this all together, the complete example is listed below.

```python
import numpy
from pandas import read_csv
from sklearn.utils import resample
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
from matplotlib import pyplot
# load dataset
data = read_csv('pima-indians-diabetes.data.csv', header=None)
values = data.values
# configure bootstrap
n_iterations = 1000
n_size = int(len(data) * 0.50)
# run bootstrap
stats = list()
for i in range(n_iterations):
  	# prepare train and test sets
    train = resample(values, n_samples=n_size)
    test = numpy.array([x for x in values if x.tolist() not in train.tolist()])
    # fit model
    model = DecisionTreeClassifier()
    model.fit(train[:,:-1], train[:,-1])
    # evaluate model
    predictions = model.predict(test[:,:-1])
    score = accuracy_score(test[:,-1], predictions)
    print(score)
    stats.append(score)
# plot scores
pyplot.hist(stats)
pyplot.show()
# confidence intervals
alpha = 0.95
p = ((1.0-alpha)/2.0) * 100
lower = max(0.0, numpy.percentile(stats, p))
p = (alpha+((1.0-alpha)/2.0)) * 100
upper = min(1.0, numpy.percentile(stats, p))
print('%.1f confidence interval %.1f%% and %.1f%%' % (alpha*100, lower*100, upper*100))
```

Running the example prints the classification accuracy each bootstrap iteration.

A histogram of the 1,000 accuracy scores is created showing a Gaussian-like distribution.

Distribution of Classification Accuracy Using the Bootstrap

Finally, the confidence intervals are reported, showing that there is a 95% likelihood that the confidence interval 64.4% and 73.0% covers the true skill of the model.


```python
 ...
 0.646288209607
 0.682203389831
 0.668085106383
 0.673728813559
 0.686021505376
 95.0 confidence interval 64.4% and 73.0%
```

This same method can be used to calculate confidence intervals of any other errors scores, such as root mean squared error for regression algorithms.

```python
import seaborn as sns;
sns.set(color_codes=True)
tips = sns.load_dataset("tips")
ax = sns.barplot(x="day", y="total_bill", data=tips)
```
![png]({{ site.url }}{{ site.baseurl }}/assets/img2018/confidence_intervals.png)


## Further Reading

This section provides additional resources on the bootstrap and bootstrap confidence intervals.

- [An Introduction to the Bootstrap](http://www.amazon.com/dp/0412042312?tag=inspiredalgor-20), 1996
- [Bootstrap Confidence Intervals](https://projecteuclid.org/download/pdf_1/euclid.ss/1032280214), Statistical Science, 1996
- Section 5.2.3, Bootstrap Confidence Intervals, [Empirical Methods for Artificial Intelligence](http://www.amazon.com/dp/0262032252?tag=inspiredalgor-20)
- [Bootstrapping](https://en.wikipedia.org/wiki/Bootstrapping_(statistics)) on Wikipedia
- Section 4.4 Resampling Techniques, [Applied Predictive Modeling](http://www.amazon.com/dp/1461468485?tag=inspiredalgor-20)

## Summary

In this post, you discovered how to use the bootstrap to calculate confidence intervals for machine learning algorithms.

Specifically, you learned:

- How to calculate the bootstrap estimate of confidence intervals of a statistic from a dataset.
- How to apply the bootstrap to evaluate machine learning algorithms.
- How to calculate bootstrap confidence intervals for machine learning algorithms in Python.
