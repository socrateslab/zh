---
layout: single
title: "利用python实现naive bayes算法"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-1.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "贝叶斯开创了统计学的贝叶斯学派，用先验知识和逻辑推理来处理不确定命题，与古老的频率学派分庭抗礼，频率学派只从数据中获得信息，完全不考虑先验知识，即人的经验。本文尝试利用python实现朴素贝叶斯分类。"
modified: 2016-04-17T11:55:22-04:00
comments: true
author_profile: true
author: "王成军"
---

{% include toc title="Table" icon="file-text" %}

![bayes](http://oaf2qt3yk.bkt.clouddn.com/a480dab63165c18682d80e1f621f111a.png)


# 问题的提出 [^note]
[^note]: 以下内容来自 【数说工作室】金融数据挖掘之朴素贝叶斯 http://www.ppvke.com/Blog/archives/6431

![class](http://oaf2qt3yk.bkt.clouddn.com/42a7d8a07672e28d10d24897487340d3.png)

如果想判断未知样本的类别，即，已知它的三个属性X1、X2、X3，判断它是属于第一类（C=1）还是第二类（C=2）。

 - $P(C=1\|X1,X2,X3)>P(C=2\|X1,X2,X3)$，给定数据的X1、X2、X3后，数据属于类别1的概率要大于属于类别2，即说明现有样本支持未知样本属于类别1，判定为类别1。
 - $P(C=1\|X1,X2,X3)<P(C=2\|X1,X2,X3)$，则说明现有样本支持未知样本属于类别2，判定为类别2。

如何得到$P(C=1\|X1,X2,X3)$和$P(C=2\|X1,X2,X3)$这两个概率呢？答案是`得不到`。但是没关系，因为，只要知道这两个谁大谁小就可以进行判断：

- $P(C=1\|X1,X2,X3)>P(C=2\|X1,X2,X3)$，则判定类别为1；
- $P(C=1\|X1,X2,X3)<P(C=2\|X1,X2,X3)$，则判定类别为2；

贝叶斯定理就提供了方法进行这种比较。

# 贝叶斯定理

$$P(C|X) = \frac{ P(X|C)P(C)}{ P(X) }$$

- P(C|X)是给定属性X下，C的**后验概率**
- P(C)是C的**先验概率**

该公式被称为`“贝叶斯定理”`。

根据贝叶斯定理，我们想找出最大的P(C|X)，由于P(X)对所有类为常数，只要找出最大的P(X|C)P(C)即可，这便是朴素贝叶斯分类的基础。

# 朴素贝叶斯分类

利用贝叶斯定理，找出最大的P(X|C)P(C)即可对未知样本进行分类，如max{P(X|C)P(C)}=P(X|C=n)P(C=n)，则说明未知样本属于第n类，其中，

（1）P(C=i)=Si/S，Si是类Ci中的训练样本数，S是训练样本总数；

（2）P(X|C=i)的计算开销可能非常大，因为会涉及到很多属性变量，这里可以做“属性值互相条件独立”的假定，即属性间不存在依赖关系：



---
# Naive Bayes
---

PlayTennis (i.e., decide whether our friend will play tennis or not in a given day) [^Mitchell]

[^Mitchell]: Mitchell Machine Learning http://www.cs.cmu.edu/~tom/10701_sp11/lectures.shtml



```python
#data
data = [
    {"outlook":"sunny", "temp":"hot", "humidity":"high", "wind":"weak", "class":"no" },
    {"outlook":"sunny", "temp":"hot", "humidity":"high", "wind":"strong", "class":"no" },
    {"outlook":"overcast", "temp":"hot", "humidity":"high", "wind":"weak", "class":"yes" },
    {"outlook":"rain", "temp":"mild", "humidity":"high", "wind":"weak", "class":"yes" },
    {"outlook":"rain", "temp":"cool", "humidity":"normal", "wind":"weak", "class":"yes" },
    {"outlook":"rain", "temp":"cool", "humidity":"normal", "wind":"strong", "class":"no" },
    {"outlook":"overcast", "temp":"cool", "humidity":"normal", "wind":"strong", "class":"yes" },
    {"outlook":"sunny", "temp":"mild", "humidity":"high", "wind":"weak", "class":"no" },
    {"outlook":"sunny", "temp":"cool", "humidity":"normal", "wind":"weak", "class":"yes" },
    {"outlook":"rain", "temp":"mild", "humidity":"normal", "wind":"weak", "class":"yes" },  
    {"outlook":"sunny", "temp":"mild", "humidity":"normal", "wind":"strong", "class":"yes" },
    {"outlook":"overcast", "temp":"mild", "humidity":"high", "wind":"strong", "class":"yes" },
    {"outlook":"overcast", "temp":"hot", "humidity":"normal", "wind":"weak", "class":"yes" },
    {"outlook":"rain", "temp":"mild", "humidity":"high", "wind":"strong", "class":"no" }]
```


```python
import pandas as pd
pd.DataFrame(data)
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>class</th>
      <th>humidity</th>
      <th>outlook</th>
      <th>temp</th>
      <th>wind</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>no</td>
      <td>high</td>
      <td>sunny</td>
      <td>hot</td>
      <td>weak</td>
    </tr>
    <tr>
      <th>1</th>
      <td>no</td>
      <td>high</td>
      <td>sunny</td>
      <td>hot</td>
      <td>strong</td>
    </tr>
    <tr>
      <th>2</th>
      <td>yes</td>
      <td>high</td>
      <td>overcast</td>
      <td>hot</td>
      <td>weak</td>
    </tr>
    <tr>
      <th>3</th>
      <td>yes</td>
      <td>high</td>
      <td>rain</td>
      <td>mild</td>
      <td>weak</td>
    </tr>
    <tr>
      <th>4</th>
      <td>yes</td>
      <td>normal</td>
      <td>rain</td>
      <td>cool</td>
      <td>weak</td>
    </tr>
    <tr>
      <th>5</th>
      <td>no</td>
      <td>normal</td>
      <td>rain</td>
      <td>cool</td>
      <td>strong</td>
    </tr>
    <tr>
      <th>6</th>
      <td>yes</td>
      <td>normal</td>
      <td>overcast</td>
      <td>cool</td>
      <td>strong</td>
    </tr>
    <tr>
      <th>7</th>
      <td>no</td>
      <td>high</td>
      <td>sunny</td>
      <td>mild</td>
      <td>weak</td>
    </tr>
    <tr>
      <th>8</th>
      <td>yes</td>
      <td>normal</td>
      <td>sunny</td>
      <td>cool</td>
      <td>weak</td>
    </tr>
    <tr>
      <th>9</th>
      <td>yes</td>
      <td>normal</td>
      <td>rain</td>
      <td>mild</td>
      <td>weak</td>
    </tr>
    <tr>
      <th>10</th>
      <td>yes</td>
      <td>normal</td>
      <td>sunny</td>
      <td>mild</td>
      <td>strong</td>
    </tr>
    <tr>
      <th>11</th>
      <td>yes</td>
      <td>high</td>
      <td>overcast</td>
      <td>mild</td>
      <td>strong</td>
    </tr>
    <tr>
      <th>12</th>
      <td>yes</td>
      <td>normal</td>
      <td>overcast</td>
      <td>hot</td>
      <td>weak</td>
    </tr>
    <tr>
      <th>13</th>
      <td>no</td>
      <td>high</td>
      <td>rain</td>
      <td>mild</td>
      <td>strong</td>
    </tr>
  </tbody>
</table>
</div>




```python
test={"outlook":"sunny","temp":"cool","humidity":"high","wind":"strong"}
```


```python
#Calculate the Prob. of class:cls

def P(data,cls_val,cls_name="class"):
    count = 0.0     
    for e in data:
        if e[cls_name] == cls_val:
            count += 1
    return count/len(data)
```


```python
# The probability of play or not
PY, PN = P(data,"yes"), P(data, "no")
PY, PN
```




    (0.6428571428571429, 0.35714285714285715)




```python
#Calculate the Prob(attr|cls)
def PT(data,cls_val,attr_name,attr_val,cls_name="class"):
    count1 = 0.0
    count2 = 0.0
    for e in data:
        if e[cls_name] == cls_val:
            count1 += 1
            if e[attr_name] == attr_val:
                count2 += 1
    return count2/count1
```


```python
# The conditional probability of play or not
PT(data,"yes", "outlook", "sunny"), PT(data,"no", "outlook", "sunny")
```




    (0.2222222222222222, 0.6)




```python
#Calculate the NB
def NB(data,test,cls_y,cls_n):
    PY = P(data,cls_y)
    PN = P(data,cls_n)
    print 'The probability of play or not:', PY,'vs.', PN
    for key,val in test.items():
        PY *= PT(data,cls_y,key,val)
        PN *= PT(data,cls_n,key,val)
        print key, val, '-->play or not:-->', PY, PN
    return {cls_y:PY,cls_n:PN}
```


```python
#calculate     
NB(data,test,"yes","no")
```

    The probability of play or not: 0.642857142857 vs. 0.357142857143
    outlook sunny -->play or not:--> 0.142857142857 0.214285714286
    wind strong -->play or not:--> 0.047619047619 0.128571428571
    temp cool -->play or not:--> 0.015873015873 0.0257142857143
    humidity high -->play or not:--> 0.00529100529101 0.0205714285714





    {'no': 0.020571428571428574, 'yes': 0.005291005291005291}




```python
#calculate  
NB(data,{"outlook":"sunny","temp":"hot","humidity":"normal","wind":"weak"},"yes","no")
```

    The probability of play or not: 0.642857142857 vs. 0.357142857143
    outlook sunny -->play or not:--> 0.142857142857 0.214285714286
    wind weak -->play or not:--> 0.0952380952381 0.0857142857143
    temp hot -->play or not:--> 0.021164021164 0.0342857142857
    humidity normal -->play or not:--> 0.0141093474427 0.00685714285714





    {'no': 0.006857142857142858, 'yes': 0.014109347442680775}



# Note
