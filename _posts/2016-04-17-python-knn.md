---
layout: single
title: "利用python实现knn算法"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-1.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "NBA历史上与这些超级球星处于同一位置的球员都有谁？这些球员是否能依据某种原则进行分类？能否通过一些算法来预测他们的赛场表现？ 根据NBA官网上的部分统计数据，我进行了如下实践。"
modified: 2016-04-17T11:55:22-04:00
comments: true
author_profile: true
author: "罗晨"
---

{% include toc title="Table" icon="file-text" %}

<p>北京时间4月14日，著名球星科比·布莱恩特（Kobe Bryant）在职业生涯告别战中获得60分。 赛后，科比在球场中央向全场致辞，宣布正式告别NBA。 科比的辉煌赛绩无疑证明了他的巨大价值与卓著成就，因此我在思考：NBA历史上与这些超级球星处于同一位置的球员都有谁？这些球员是否能依据某种原则进行分类？能否通过一些算法来预测他们的赛场表现？ 根据NBA官网上的部分统计数据，我进行了如下实践。虽然我至今看过的篮球比赛屈指可数，但是不得不承认，分析篮球赛统计数据还是十分有趣的。</p>

## 一、KNN简介
<p>KNN全称为：K-nearest neighbours，又称为最近邻居法、K近邻算法，是一种用于回归和分类的非参统计法。 在KNN分类（classifier）中，输出结果是分类族群，一个对象归属于哪一类是由其邻居的“多数表决”决定的，如果k=1，则该对象的类别直接由最近一个节点赋予。 在KNN回归（regressor）中，输出结果是对象的属性值，这个值是其k个最近邻居的值的平均数。 K-NN是一种基于实例的学习，或者是局部近似和将所有计算推迟到分类之后的惰性学习。 k-近邻算法是最简单的机器学习算法之一。 无监督的近邻算法是许多机器学习方法的基础，有监督的近邻算法分为两种： 1. 数据分类：离散型标签 2. 数据回归：连续型标签 近邻算法的准则是：寻找接近新数据点的训练样本的数目，根据训练样本的信息来预测新数据点的某些信息。 训练样本的数目可以是自行指定的常数，如KNN；也可以基于数据点密度而来。 [以上总结自scikit-learn官网]</p>


举例说明
假设有3种食品，我们现在品牌名称、口感得分、是否含有蛋白质、是否含有碳水化合物四项信息（此数据纯属虚构）

    food, taste, protein, carbohydrate
    A, 8, False, False
    B, 5, True, True
    C, 2, True, True


<p>现在有一款新生产的食品，我们不知道它是否包含碳水化合物，因此需要结合已知信息来予以判断。</p>

    food, taste, protein, **carbonhydrate**
    D, 4, True, **Unknown**



<p>要辨别D的碳水化合物，一个直观的方法就是找出完备数据中与它已知特征最相似的食品。本例中考虑口感得分、是否含有蛋白质两个因素。 结论显而易见，B与D最为接近。已知数据告诉我们B含有碳水化合物，那么合理的推测是：D也有。这是当k=1时的近邻算法。 如果我们采用当k=2时的近邻算法，那么相似的食品有B和C两款，它们对应的碳水化合物（carbonhydrate）均值也为True。 如果我们采用当k=3时的近邻算法，那么相似的食品在碳水化合物上就有两个True和一个False，其均值也是接近True的。 所以k个近邻中的k可以是任何小于案例数量的数值。当k越小时，算法的运行结果就会愈加精确，因为它会极力寻找与自己特征最相似的数据点。</p>

## 二、研究目的
<ol>
<li>借助欧几里得距离（Euclidean Distance）来寻找与迈克尔·乔丹（Michael Jordan）最相似的运动员——此处主要运用KNN的分类功能；</li>
<li>将利用KNN算法来预测NBA运动员的得分——此处主要运用KNN的回归功能。</li>
</ol>

## 三、数据梳理
<p>数据直接从NBA官网上获得：http://stats.nba.com/leaders/alltime/?ls=iref:nba:gnav ，本例中的数据只使用首张网页的内容。 将空值数据全部替换为0，存储为.xlsx格式</p>


    字段说明:
    1. Player——运动员姓名
    2. GP——运动员参加的比赛场数
    3. MIN——运动员的参赛时间（单位：分钟）
    4. PTS——运动员的得分
    5. FGM——投篮命中


<p>其中，PTS是我们接下来需要用KNN来预测的值。 关于每个字段的具体含义，参看网页即可，鼠标悬停在每个字段上，会浮现出对应的解释。</p>

## 四、读取数据
<p>这里使用的是数据分析利器：Pandas 读取数据时需要注意：如果存为.csv格式，虽然代码简单，但是因为&#8221;GP&#8221;字段包含四位数，在Python中自动添加千位点，容易被辨识为字符形式(str)，可能妨碍之后的运算，因此建议读取Excel，并且在Excel中事先对数据进行数字格式指定。</p>

```python
import pandas as pd
data = pd.read_excel('regular season.xlsx', 'Sheet1')
# 输出列字段
print data.columns.values
```

    #输出结果：[u'Player' u'GP' u'MIN' u'PTS' u'FGM' u'FGA' u'FG%' u'3PM' u'3PA' u'3P%'
     u'FTM' u'FTA' u'FT%' u'OREB' u'DREB' u'REB' u'AST' u'STL' u'BLK' u'TOV'
     u'eFG%' u'TS%']


## 五、欧几里得距离
<p>全称为：Euclidean Distance，又称为欧氏距离。 KNN的聚类依据是找出哪些数据行与我们所需要预测的行是比较接近（similar）的。（这里可以把数据维度想象为n维空间，由于本例中数值型数据占据21列，因此是一个21维的空间） 欧氏距离的计算公式是： $$\sqrt{(p_1-q_1)^2 + (p_2-q_2)^2 + \cdots + (p_n-q_n)^2}$$ 如果对应之前的食品数据，那么False和True就可以当作典型的0-1变量，True为1，False为0。 数据转化后的形式是：</p>

    food, taste, protein, carbonhydrate
    A, 8, False, False
    D, 4, True, True



<p>由于计算欧氏距离时只能使用数值型数据，那么这两款食品的欧式距离就是： $\sqrt{(8-4)^2 + (0-1)^2}$ 结果是：4.123. 并且这一结果主要受到数值相对较大的taste的影响。</p>


## 六、距离计算
<p>我们以NBA数据中Michael Jordan为基准，计算Jordan与其他球员之间的欧氏距离，发现与他相似的球员。</p>

```python
from math import sqrt

# 选择Jordan为基准点
Jordan = data[data['Player'] == 'Michael Jordan'].iloc[0]

# 选择其他的数值列作为判别相似性的依据，因为Player列并不是数值型数据，因此不予选择，这里的依据共有21项
factors = ['GP', 'MIN', 'PTS', 'FGM', 'FGA', 'FG%', '3PM', '3PA', '3P%', 'FTM', 'FTA', 'FT%', 'OREB', 'DREB', 'REB', 'AST', 'STL', 'BLK', 'TOV', 'eFG%', 'TS%']

# 根据第5部分的公式写出欧氏距离计算函数
def euclidean(row):
    initial = 0
    for f in factors:
        initial += (row[f] - Jordan[f]) ** 2
    return sqrt(initial)

# 计算其他每位运动员与Jordan之间的欧氏距离
distance = data.apply(euclidean, axis = 1)
print distance
```


    #输出结果：
    0       0.000000
    1      57.182515
    2     431.133135
    3     229.006419
    4      85.736048
    5     143.990555
    6     158.583448
    7     282.525769
    ……
    46    258.621287
    47     20.320925
    48    354.446583
    49    175.035254
    dtype: float64


## 七、必要的标准化
<p>在食品案例中，计算欧氏距离时可以发现一个明显的结论：口感得分（taste）对欧氏距离的的影响远远大于另一个二分变量（protein）的影响，这是因为口感得分的数值相较1而言非常大，减弱了protein的影响程度。 绝对值之间的差异悬殊会影响到KNN的聚类效果。一个可行的处理方法是把列数据正态化，即转化为均值为0（$\mu=0$），标准差为1（$\sigma=1$）的正态分布型数据。经过这一步之后，没有一个占据统治地位的影响因素。 转化公式是： $x=\frac{x-\mu}{\sigma}$</p>

```python
#  选择数据类型为数值的列
numeric = data[factors]

# 将这些列中的数据标准化
data_normalized = (numeric - numeric.mean()) / numeric.std()
print data_normalized
```


    # 输出结果：
              GP       MIN       PTS       FGM       FGA       FG%       3PM  \
    0   0.570848  0.782310  2.650451  2.497023  2.106350  0.439565  0.049928   
    1   0.475235  3.430022  2.650451  3.134949  1.931258  1.534656 -0.643513   
    2  -0.955427  0.605796  1.606053  0.492114  0.442981  0.083023  1.852873   
    3  -0.229472  1.382458  1.606053  1.494569  2.500305 -1.241273 -0.643513   
    4   0.269843  1.029430  1.528690  1.038908  0.705618  0.465032  1.298121   
    5   0.075074  1.100036  1.451327  0.947775  1.012028 -0.146182 -0.643513   
    6   0.011332  1.770789  1.335283  0.583246  1.624848 -1.394077  1.020745   
    7  -0.420699  0.958825  1.219239  0.583246  1.405984 -1.113937 -0.643513   
    8  -0.424241 -0.912225  1.141876  1.403436  0.793164  0.796106 -0.504825
    ……


## 八、寻找近邻
<p>了解基本的算法原理后，可以直接使用scipy.spatial中的函数distance.euclidean函数，这样计算欧氏距离的速度会加快，并且避免了重写代码的繁琐工作。</p>

```python
from scipy.spatial import distance

# 因为涉及到空间概念，此处利用标准化向量（normalized vector）
Jordan_normalized = data_normalized[data['Player'] == 'Michael Jordan']

# 计算乔丹与其他球员（每位球员的指标都转化为空间中的向量）的距离
distance_1 = data_normalized.apply(lambda row: distance.euclidean(row, Jordan_normalized), axis = 1)

# 创建一个关于欧氏距离的数据框（Dataframe），方便之后的数据选择
frame = pd.DataFrame(data = {'Index': distance_1.index, 'Distance': distance_1})
frame.sort_values(by = 'Distance', inplace = True)
print frame
```

    # 输出结果：
     Distance  Index
    0   0.000000      0
    4   3.659087      4
    8   4.253842      8
    6   4.500447      6
    5   4.568723      5
    ……



<p>近邻寻找：</p>

```python
# 寻找与Jordan最相似的运动员，最短的距离是Jordan和他本人（距离为0），第二短的距离数据点就是与Jordan最相似的球员
similar = frame.iloc[1]['Index']
similar_player = data.iloc[int(similar)]['Player']
print similar_player
```

    # 输出结果：
    James LeBron（詹姆斯·勒布朗）


## 九、利用现有数据生成训练集和测试集</h1>
<p>以上是关于如何寻找近邻的详细说明，接下来可以将原数据拆分为训练集（train set）和测试集（test set）并对测试集进行预测。 进行聚类的依据是所有数值型数据列，k的取值会进行人为制定。 需要采用随机抽样的方式来生成训练集与测试集，否则预测集和训练集的数据差别不大，有可能出现模型过度拟合的结果。</p>


```python
from math import floor
from numpy.random import permutation

# 将数据进行随意变换（类似于洗牌）
shuffle = permutation(data.index)

# 设定断点，确定断点前的数据都进入测试集，此处将1/3的数据选入测试集
test_point = floor(len(data) / 3)

# 生成测试集
test_set = data.loc[shuffle[1 : test_point + 1]]
print test_set

# 生成训练集（测试集之外的数据皆进入训练集）
train_set = data.loc[shuffle[test_point +1 : ]]
print train_set
```


      # 输出结果（test_set）：
                      Player    GP   MIN   PTS   FGM   FGA   FG%  3PM  3PA   3P%  \
      41        John Havlicek  1270  36.6  20.8   8.3  18.8  43.9  0.0  0.0   0.0   
      6         Allen Iverson   914  41.1  26.7   9.3  21.8  42.5  1.2  3.7  31.3   
      37       Mitch Richmond   976  35.2  21.0   7.5  16.4  45.5  1.4  3.5  38.8   
      14  Kareem Abdul0Jabbar  1560  36.8  24.6  10.2  18.1  55.9  0.0  0.0   5.6   
      46         Moses Malone  1329  33.9  20.6   7.1  14.5  49.1  0.0  0.1  10.0   
      30         Geoff Petrie   446  37.6  21.8   8.9  19.5  45.5  0.0  0.0   0.0   
      38        Patrick Ewing  1183  34.3  21.0   8.2  16.3  50.4  0.0  0.1  15.2   
      ……[16 rows x 22 columns]


    # 输出结果（train_set）：
                    Player    GP   MIN   PTS   FGM   FGA   FG%  3PM  3PA   3P%  \
    12   Carmelo Anthony   902  36.4  24.9   8.9  19.6  45.3  1.1  3.3  34.4   
    40  Billy Cunningham   654  34.3  20.8   7.8  17.5  44.6  0.0  0.0   0.0   
    49         Dave Bing   901  36.4  20.3   7.7  17.5  44.1  0.0  0.0   0.0   
    24     Stephen Curry   495  34.9  22.4   7.9  16.6  47.7  3.2  7.3  44.4   
    36    David Robinson   987  34.7  21.1   7.5  14.4  51.8  0.0  0.1  25.0   
    21      George Mikan   439  34.4  23.1   8.1  20.0  40.4  0.0  0.0   0.0   
    10       Karl Malone  1476  37.2  25.0   9.2  17.8  51.6  0.1  0.2  27.4   
    35      James Harden   534  33.2  21.1   6.2  14.1  44.3  2.1  5.7  36.8
    ……[33 rows x 22 columns]


<p>在前文的“研究目的”中已有说明：希望对球员的PTS（得分）进行预测，因此采用scikit-learn模块包，里面有回归器（regressor）。 scikit-learn的运算流程十分智能，将自动执行数据标准化、欧氏距离计算，并且可以人为指定邻居数量（k）。</p>

```python
# 进行预测所依赖的自变量
indepedent = ['GP', 'MIN', 'FGM', 'FGA', 'FG%', '3PM', '3PA', '3P%', 'FTM', 'FTA', 'FT%', 'OREB', 'DREB', 'REB', 'AST', 'STL', 'BLK', 'TOV', 'eFG%', 'TS%']

# 需要预测的因变量
depedent = ['PTS']

# 人为将邻居数量指定为5
from sklearn.neighbors import KNeighborsRegressor as KNR
KNN = KNR(n_neighbors = 5)

# 用训练集来拟合模型
KNN.fit(train_set[indepedent], train_set[depedent])

# 运用模型对测试集数据进行预测，输出模型预测值
prediction = KNN.predict(test_set[indepedent])
print prediction
```


    # 输出结果：
    [[ 22.6 ]
     [ 23.36]
     [ 25.18]
     [ 23.3 ]
     [ 22.6 ]
     [ 22.04]
     [ 21.9 ]
     [ 23.36]
     [ 23.3 ]
     [ 24.1 ]
     [ 22.38]
     [ 25.68]
     [ 22.74]
     [ 21.78]
     [ 21.78]
     [ 22.38]]


<p>对测试集的数据进行预测后，需要评估预测的准确程度，可以将实际值与预测值的误差计算出来。这里采用均方差（Mean Squared Error, MSE）作为误差估测指标，MSE的计算公式是： $\frac{1}{n}\sum_{i=1}^{n}(y_{i} &#8211; \hat{y_{i}})^{2}$ 其中，$\hat{y_{i}}$是预测值。</p>

```python
actual_value = test_set[depedent]
MSE = ((actual_value - prediction) ** 2).sum() / len(test_set)
print MSE
```
    # 输出结果：
    PTS    6.90355
    dtype: float64


## 参考文献
 1. [scikit-learn官网](http://scikit-learn.org/stable/modules/neighbors.html)
