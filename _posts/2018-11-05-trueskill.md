---
layout: single
title: "使用Python来实现TrueSkill算法"
header:
  teaser: "/assets/images/unsplash-gallery-image-2-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-23.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "TrueSkill算法是Elo排名方法与贝叶斯规则的结合，可用于计算竞赛选手的能力排名。Dangauthier2007提出了这个方法 ，Liu2013创造性地建议使用这方法来计算问答类社区问题的难度。"
modified: 2018-11-04 19:49:48
comments: true
author: "计算士"
tags:
  - 计算传播学
---


# 使用Python来实现TrueSkill算法


- 作者：计算士
- 链接：https://www.jianshu.com/p/c1fbba3af787


TrueSkill算法是Elo排名方法与贝叶斯规则的结合，可用于计算竞赛选手的能力排名。Herbrich 等人(2007)提出了这个方法；同一年，Dangauthier和Herbrich 等人应用其方法到国际象棋的比赛中去，计算国际象棋选手的能力随时间如何变化；Liu (2013)创造性地建议使用这方法来计算问答类社区问题的难度。

算法给每一个用户分配一个正态分布，均值代表真实能力，方差代表系统对该用户真实能力猜测的不确定程度。一开始假设每个人分布的均值和方差一致，此后利用数据中的每一对输赢关系不断更新每个用户的分布。更新规则如下：

$$ \mu_{winner} = \mu_{winner} + \frac{\sigma_{winner}^2}{c} v(\frac{t}{c})$$

$$ \mu_{loser} = \mu_{loser} - \frac{\sigma_{loser}^2}{c} v(\frac{t}{c})$$

$$ \sigma_{winner} = \sigma_{winner} [1 - \frac{\sigma_{winner}^2}{c^2}w(\frac{t}{c})]$$

$$ \sigma_{loser} = \sigma_{loser} [1 - \frac{\sigma_{loser}^2}{c^2}w(\frac{t}{c})]$$


其中，

$$t = \mu_{winner} - \mu_{loser}$$

$$c^2 = 2\beta^2 + \sigma_{winner}^2 + \sigma_{loser}^2$$

$$v(t) = \frac{N(t)}{\phi(t)}$$

$$w(t) = v(t)(v(t) + t)$$

方程（7）中的分子N函数和分母$\phi$函数，分别是标准正态分布的PDF与CDF。

算法的精髓是充分吸收数据信息（消灭意外）。例如，假设系统中储存的分布是A的均值大于B的，
- 如果数据中却出现了B赢了A的情况，那么就把B的均值大幅提升，把A的均值大幅减小；
- 如果不出意外地，A赢了B，那么把A的均值小幅提升，把B的均值小幅减小。


```python
import matplotlib.pyplot as plt
import numpy as np
import scipy.stats
import math
```


```python
# updataing function with a beta parameter,
# bigger beta updates more dramatically
v = lambda x: scipy.stats.norm(0,1).pdf(x)/scipy.stats.norm(0,1).cdf(x)
w = lambda y: v(y)*(v(y) + y)

def update(mw,sw,ml,sl,beta):
    # mw: miu of winner;
    # sw: sigma of winner;
    # ml: miu of loser;
    # sl: sigma of loser;
    t = mw - ml
    c = np.sqrt(2*beta**2+sw**2+sl**2)
    mw += v(t/c)*sw**2/c
    ml -= v(t/c)*sl**2/c
    sw *= np.sqrt(1 - w(t/c)*sw**2/c**2)
    sl *= np.sqrt(1 - w(t/c)*sl**2/c**2)
    return mw,sw,ml,sl
```


```python
# normal distribution ploting function
def plotNormalPDFs(xmin,xmax,m1,s1,m2,s2,col1,col2,line,ax,lab1,lab2):
    x = np.linspace(xmin,xmax,200)
    y1 = list(map(lambda x:scipy.stats.norm(m1, s1).pdf(x), x))
    y2 = list(map(lambda x:scipy.stats.norm(m2, s2).pdf(x), x))
    ax.plot(x,y1,linestyle=line,color=col1,label=lab1,linewidth=1.5)
    ax.plot(x,y2,linestyle=line,color=col2,label=lab2,linewidth=1.5)

# generate data
xs=np.linspace(-6,6,100)
vs=list(map(lambda x:v(x),xs))
ws=list(map(lambda x:w(x),xs))
xmin,xmax,m1,s1,m2,s2 = 1,100,60,5,40,20
beta = (s1+s2)/4
m1w,s1w,m2l,s2l = update(m1,s1,m2,s2,beta)
m2w,s2w,m1l,s1l = update(m2,s2,m1,s1,beta)
```


```python
xs
```




    array([-6.        , -5.87878788, -5.75757576, -5.63636364, -5.51515152,
           -5.39393939, -5.27272727, -5.15151515, -5.03030303, -4.90909091,
           -4.78787879, -4.66666667, -4.54545455, -4.42424242, -4.3030303 ,
           -4.18181818, -4.06060606, -3.93939394, -3.81818182, -3.6969697 ,
           -3.57575758, -3.45454545, -3.33333333, -3.21212121, -3.09090909,
           -2.96969697, -2.84848485, -2.72727273, -2.60606061, -2.48484848,
           -2.36363636, -2.24242424, -2.12121212, -2.        , -1.87878788,
           -1.75757576, -1.63636364, -1.51515152, -1.39393939, -1.27272727,
           -1.15151515, -1.03030303, -0.90909091, -0.78787879, -0.66666667,
           -0.54545455, -0.42424242, -0.3030303 , -0.18181818, -0.06060606,
            0.06060606,  0.18181818,  0.3030303 ,  0.42424242,  0.54545455,
            0.66666667,  0.78787879,  0.90909091,  1.03030303,  1.15151515,
            1.27272727,  1.39393939,  1.51515152,  1.63636364,  1.75757576,
            1.87878788,  2.        ,  2.12121212,  2.24242424,  2.36363636,
            2.48484848,  2.60606061,  2.72727273,  2.84848485,  2.96969697,
            3.09090909,  3.21212121,  3.33333333,  3.45454545,  3.57575758,
            3.6969697 ,  3.81818182,  3.93939394,  4.06060606,  4.18181818,
            4.3030303 ,  4.42424242,  4.54545455,  4.66666667,  4.78787879,
            4.90909091,  5.03030303,  5.15151515,  5.27272727,  5.39393939,
            5.51515152,  5.63636364,  5.75757576,  5.87878788,  6.        ])




```python
# plot    
fig = plt.figure(figsize=(10, 8),facecolor='white')
ax1 = fig.add_subplot(2,2,1)
ax1.plot(xs,vs, color='YellowGreen',linewidth=1.5)
ax1.set_xlabel(r'$t = \mu_{winner} - \mu_{loser}$',size=14)
ax1.set_ylabel(r'$v(t)$',size=14)
#
ax2 = fig.add_subplot(2,2,2)
ax2.plot(xs,ws, color='Tomato',linewidth=1.5)
ax2.set_xlabel(r'$t = \mu_{winner} - \mu_{loser}$',size=14)
ax2.set_ylabel(r'$w(t)$',size=14)
#
ax3 = fig.add_subplot(2,2,3)
col1 = 'SteelBlue'; col2='Chocolate'; lineo='-'; linen='-.'
plotNormalPDFs(xmin,xmax,m1,s1,m2,s2,col1,col2,lineo,ax3,'original i ','original j')
plotNormalPDFs(xmin,xmax,m1w,s1w,m2l,s2l,col1,col2,linen,ax3,'updated i','updated j')
ax3.set_xlabel(r'skills',size=14)
ax3.set_ylabel(r'propability',size=14)
ax3.legend(fontsize=10,loc=2)
#
ax4 = fig.add_subplot(2,2,4)
plotNormalPDFs(xmin,xmax,m1,s1,m2,s2,col1,col2,lineo,ax4,'original i ','original j')
plotNormalPDFs(xmin,xmax,m2w,s2w,m1l,s1l,col2,col1,linen,ax4,'updated j','updated i')
ax4.set_xlabel(r'skills',size=14)
ax4.set_ylabel(r'propability',size=14)
ax4.legend(fontsize=10,loc=2)
#
plt.tight_layout()
plt.show()
```


![png]({{ site.url }}{{ site.baseurl }}/assets//img2018/trueskill.png)

上图中蓝色和棕色分布分别对应A和B两个用户，实线是原来的分布，虚线是根据一个新的输赢关系更新后的分布。左下角图展示了A赢了B的情况，右下图展示B赢了A的情况。上面两个图展示了，输赢关系带来均值（左图）和方差（右图）的改变的剧烈程度。t<0的时候是令人惊奇的，因为此时系统中储存的赢家的均值比输家还要低。越惊奇，改变越大。


最后，如果进行大规模计算，可以使用如下版本的update函数。其对正态分布函数预先进行了数值计算，不用每次都生成新的正态分布函数，因此大大提升速度


```python
# fast version of updating function
def fastupdate(mw,sw,ml,sl,beta): # miu and sigma of winner and loser
    sw2=math.pow(sw,2)
    sl2=math.pow(sl,2)
    t = mw - ml
    c = math.sqrt(34.72222+sw2+sl2)
    c2=math.pow(c,2)
    tc = t/c
    vtc = 0.79788*0.60653**math.pow(tc,2)/math.erfc(-0.70711*tc)
    wtc = vtc*(vtc + tc)
    mw += vtc*sw2/c
    ml -= vtc*sl2/c
    sw *= math.sqrt(1 - wtc*sw2/c2)
    sl *= math.sqrt(1 - wtc*sl2/c2)
    return mw,sw,ml,sl

```

另外，还专门有一个名为trueskill的python包。首先，在jupyter notebook中安装trueskill这个包：

```python
! pip install trueskill
```

    Collecting trueskill
      Downloading https://files.pythonhosted.org/packages/d0/b1/572f309178eacdccd9f9f5f3e3e14fb3543a89c6259d62b36660350af2b9/trueskill-0.4.5.tar.gz
    Requirement already satisfied: six in /Users/datalab/Applications/anaconda/lib/python3.5/site-packages (from trueskill) (1.11.0)
    Building wheels for collected packages: trueskill
      Running setup.py bdist_wheel for trueskill ... [?25ldone
    [?25h  Stored in directory: /Users/datalab/Library/Caches/pip/wheels/63/f3/6c/08a1b5dbd92bbc5ef69e7f991955889469cd84a5bc94be4e2c
    Successfully built trueskill
    [31mnbconvert 5.3.1 has requirement mistune>=0.7.4, but you'll have mistune 0.7.2 which is incompatible.[0m
    Installing collected packages: trueskill
    Successfully installed trueskill-0.4.5
    [33mYou are using pip version 10.0.1, however version 18.1 is available.
    You should consider upgrading via the 'pip install --upgrade pip' command.[0m

然后，调用这个tureskill中的一些函数来进行展示。


```python
from trueskill import Rating, quality_1vs1, rate_1vs1

```


```python
help(Rating)
```

    Help on class Rating in module trueskill:

    class Rating(trueskill.mathematics.Gaussian)
     |  Represents a player's skill as Gaussian distrubution.
     |  
     |  The default mu and sigma value follows the global environment's settings.
     |  If you don't want to use the global, use :meth:`TrueSkill.create_rating` to
     |  create the rating object.
     |  
     |  :param mu: the mean.
     |  :param sigma: the standard deviation.
     |  
     |  Method resolution order:
     |      Rating
     |      trueskill.mathematics.Gaussian
     |      builtins.object
     |  
     |  Methods defined here:
     |  
     |  __float__(self)
     |  
     |  __init__(self, mu=None, sigma=None)
     |      Initialize self.  See help(type(self)) for accurate signature.
     |  
     |  __int__(self)
     |  
     |  __iter__(self)
     |  
     |  __long__(self)
     |  
     |  __repr__(self)
     |      Return repr(self).
     |  
     |  ----------------------------------------------------------------------
     |  Data descriptors defined here:
     |  
     |  exposure
     |      Deprecated.  Used to get a value that will go up on the whole.
     |      
     |      .. deprecated:: 0.4
     |         Use :meth:`TrueSkill.expose` instead.
     |  
     |  ----------------------------------------------------------------------
     |  Methods inherited from trueskill.mathematics.Gaussian:
     |  
     |  __div__ = __truediv__(self, other)
     |  
     |  __eq__(self, other)
     |      Return self==value.
     |  
     |  __ge__(self, other)
     |      Return self>=value.
     |  
     |  __gt__(self, other)
     |      Return self>value.
     |  
     |  __le__(self, other)
     |      Return self<=value.
     |  
     |  __lt__(self, other)
     |      Return self<value.
     |  
     |  __mul__(self, other)
     |  
     |  __truediv__(self, other)
     |  
     |  ----------------------------------------------------------------------
     |  Data descriptors inherited from trueskill.mathematics.Gaussian:
     |  
     |  __dict__
     |      dictionary for instance variables (if defined)
     |  
     |  __weakref__
     |      list of weak references to the object (if defined)
     |  
     |  mu
     |      A property which returns the mean.
     |  
     |  sigma
     |      A property which returns the the square root of the variance.
     |  
     |  ----------------------------------------------------------------------
     |  Data and other attributes inherited from trueskill.mathematics.Gaussian:
     |  
     |  __hash__ = None
     |  
     |  pi = 0
     |  
     |  tau = 0




```python
Rating(25)
```



$\mathcal{ N }( 25.000, 8.333^2 )$




```python
alice, bob = Rating(25), Rating(30)  # assign Alice and Bob's ratings
if quality_1vs1(alice, bob) < 0.50:
    print('This match seems to be not so fair')
alice, bob = rate_1vs1(alice, bob)  # update the ratings after the match
```

    This match seems to be not so fair

# References

    Herbrich, Ralf; Minka, Tom; Graepel, Thore (2007), Schölkopf, B.; Platt, J. C.; Hoffman, T., eds., TrueSkill™ : A Bayesian Skill Rating System, Advances in Neural Information Processing Systems 19, MIT Press, pp. 569–576, retrieved 2018-10-11


    @inproceedings{Dangauthier2007TrueSkill,
      title={TrueSkill through time: revisiting the history of chess},
      author={Dangauthier, Pierre and Herbrich, Ralf and Minka, Tom and Graepel, Thore},
      booktitle={International Conference on Neural Information Processing Systems},
      pages={337-344},
      year={2007},
    }

    @book{Liu2013Question,
      title={Question Difficulty Estimation in Community Question Answering Services},
      author={Liu, Jing and Wang, Quan and Lin, Chin Yew and Hon, Hsiao Wuen},
      publisher={American Section of the International Solar Energy Society,},
      pages={495-501},
      year={2013},
    }
