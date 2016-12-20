---
layout: single
title: "写给piggy的python入门指南：初试networkx"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-8.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "本文介绍了如何使用Python读取网络数据、计算网络效率，并将结果写入文件。"
modified: 2016-04-23T11:55:22-04:00
comments: true
author_profile: true
author: "王成军"
---

{% include toc title="Table" icon="file-text" %}

<p>Piggy是大连海事大学的一名大四小女生，因缘际会，我们正在合作一个工作。工作中涉及到一个网络指标计算的问题。问题本身并不复杂：已知网络中每两个点之间的流量，计算整个网络里流的效率。这里的网络效率我们定义为所有点对之间流量与最短路径长度之比的和（如果点对间的流量是均匀的，那效率就是网络中所有节点<a href="https://en.wikipedia.org/wiki/Centrality#Closeness_centrality">closeness centrality</a>之和）。这样，我们就可以把删除一条边后网络效率的减少量，作为评价流网络中连边重要性的一个指标，简称“删之rank”：）</p>
<p>Piggy会点R，但也是刚学。我说既然这样，你不如也学点Python吧，以后做东西遇到程序问题我还能帮你支支招，不然你用R我就只能精神上支持你了：）Piggy说好，我去借几本Python的书学学？我说别了，Python简单到看书都浪费（语法简单，网上下几页<a href="http://www.cnblogs.com/vamei/archive/2012/09/13/2682778.html">速成教程</a>就够了），复杂到看书也学不会（真正实用的包，书上也没有啊），咱边做边学吧：）</p>

## 1 开发环境的准备
<p>Piggy平常用Windows，她装了Python，但捣鼓很久也装不上networkx。这个问题我相信很多Windows用户初次接触networkx时都会遇到：networkx提供的安装包是egg文件，很难安装。如果Piggy是男生，我就推荐他删了Windows装Ubuntu：）Ubuntu下面装Python的各种包简直太方便了，大部分直接从软件仓库apt-get就行了，个别库里没有的pip一下也就搞定了。而且用Ubuntu将来和计算服务器交互也非常方便——Windows用户还得装个终端什么的连服务器，还得用FTP上传下载文件，还得装个cygwin写C\C++程序…… 对于Ubuntu用户这些就全免了——直接把远程服务器目录挂载为本地磁盘就行了。另外，装Ubuntu还有强迫自己不打游戏等额外好处：）但Ubuntu对一般不爱瞎折腾电脑的小女生来说的确有点难了，我就推荐她用<a href="https://sourceforge.net/projects/python-xy/">Python(x,y)</a>。Python(x,y)安装简单，集成了绝大部分常用的科学计算Python包（当然也包括networkx），而且自带的IDE <a href="https://pythonhosted.org/spyder/">Spyder</a>有代码提示、debug和源代码定位等方便功能，是Windows用户不错的选择。</p>

## 2 用Python读取文本文件
<p>我们的网络结构和流量数据都是存在文本文件中的，因此需要解决的第一个问题，就是如何从这些文件里读取数据。</p>
<p>网络结构数据文件net.csv大概是长这个样子的：</p>

    Source,Target,Dis
    1,2,12.5
    2,3,3.6
    ... ...


<p>流量数据文件flow.csv长得也差不多：</p>


    Source,Target,Flow
    1,2,111
    2,1,222
    1,3,321
    ... ...



<p>下面，就是如何从文件里读取数据，并构建相应网络的代码：</p>

```python
# -*- coding: utf-8 -*-
#程序的开头要放上边这句，是为了支持中文注释或字符串变量
import networkx as nx #import一个Python的包，as是起一个短点的别名，后面引用方便：）

G=nx.Graph() #用Graph方法建立一个空的无向图G，用来存网络结构。networkx的所有方法或对象都可以用包名nx加点号引出，这时候有代码提示功能的IDE的好处就显现出来了：）
F=nx.DiGraph() #用DiGraph方法建立一个空的有向图F，用来存地点间的流量（因为从A到B和从B到A的流量可能不一样，所以这里用有向图）

netfile=open('net.csv') #打开一个文件。其实Python有专门的包处理csv文件读写，我这里只一般化的文本文件读写方式，更通用一些。
i=0 #设置一个计数器，为了避开读取csv文件的第一行标题
for line in netfile: #循环读取文件netfile中的每一行数据，到文件末尾会自动结束。for in是Python最基本的循环语句，任何可遍历的对象都可以for in，例如for in数字范围range(n)，就是从0循环到n-1。
    if i&gt;0: #从第二行开始读数据。if是条件控制语句，后面带条件表达式，然后用冒号与后面的语句分割（类似C里花括号的作用）。另外，凡是带冒号的语句（流程控制、函数定义等）后面的语句都要强制缩进，所以Python程序的可读性很好。
        col=line.split(',') #将文件中的一行按逗号分割，赋给一个数组col，然后用放括号加序号就可以引用数组中的元素了。当然，split也可以放其他字符作为分割符号。如果什么都不放，split()默认用空格和Tab分割字符串
        G.add_edge(col[0],col[1],dis=float(col[2])) #用add_edge方法为网络G添加一条含权的边，权重的名字是dis。注意距离是数字，因此需要用float将文本强制转换为浮点数
    i+=1 #计数器自加1，等价于i=i+1
netfile.close() #记得关掉用过的文件，Python会在后台释放内存。

'''
上面的代码注释写的太多了，下面读流量数据时来个干净点的，过程基本一样，只是流量网络是个有向图。
BTW，三引号是Python里另一种添加注释的方法，注释大段暂时不用的代码时非常有用：）
'''

flowfile=open('flow.csv')
i=0
for line in flowfile:
    if i&gt;0:
        col=line.split(',')
        F.add_edge(col[0],col[1],flow=float(col[2]))
    i+=1
flowfile.close()
```

## 3 计算网络效率
<p>前面已经说过，我们将流网络的效率定义为所有点对之间流量与最短路径长度之比的和。因此，最简单的代码可以写成下面这样：</p>

```python
sumeff=0 #存储网络总效率的变量
for u,v in F.edges(): #从流量图F中遍历每条边，边的端点是点对u到v。
    if F[u][v]['flow'] &gt;0 and nx.has_path(G,u,v): #只需要计算流大于零且相互之间存在可达路径（因为网络不一定是连通的）的点对。注意这里读取边权的方式F[u][v]['flow']——networkx里将图结构用嵌套的字典来处理，因此读取边权可以用字典的键来逐级引用：先是起点u，然后是终点v，然后是权的名称flow，注意加引号（关于字典这种Python里超级好用的数据结构，有必要搜一搜相关资源详细了解一下使用方法，会经常用到的）。
        sumeff+=F[u][v]['flow'] /nx.shortest_path_length(G,u,v,weight='dis') #shortest_path_length返回图G中两个点之间的最短路径长度，注意要指定距离dis作为权重，否则计算的是最短拓扑距离，而不是空间距离。
print sumeff #在终端里输出结果。写程序时经常性地用print检查一下中间计算结果，是一个好的编程习惯：）
```


<p>上边这段代码逻辑清楚，也没什么错误，但其实隐含着很大的问题，那就是效率太低了。学过Dijkstra算法的都知道，当我们找u到v之间的最短路径时，实际上同时也找出了u到网络中所有其他节点的最短路径。因此，上边的这段代码其实是多执行了n倍的最短路径查找算法（n是网络节点数量），当网络规模很大时，这会严重增加计算时间。因此，这段代码还需要优化一下：</p>

```python
sumeff=0
for u in F.nodes(): #遍历流量图F的每个点
    path=nx.shortest_path_length(G,source=u,weight='dis')#在网络G中计算从u开始到其他所有节点（注意包含自身）的最短路径长度。如果两个点之间没有路径，那path里也不会存储这个目标节点（比前面的代码又省了判断是否has_path的过程）
    for v in path.keys(): #path是一个字典，里面存了所有目的地节点到u的最短路径长度
        if u!=v: #如果起终点不同才累加计算效率
            sumeff+=F[u][v]['flow'] /path[v]
```

<p>现在，我们已经能计算出网络的总效率了。下一步，就是看删除每条边后网络的效率下降了多少。思路很简单，就是循环删除网络G的每条边，然后再用上边的代码算一遍效率就行了。不过不能直接在原始的网络G上进行删边操作，因为那样很快就把G删没边了：）那怎么办呢？很简单，克隆一个G删边就行，代码如下：</p>


```python
for u,v in G.edges():
    C=G.copy() #复制G到一个新的临时图C。注意不能直接写C=G，在Python里这样写只相当于给G另起了个名字C，删C的边，G里面的边也就跟着没了……
    C.remove_edge(u,v) #删除一条边u-v
    sumeff_rmv=0 #删边后的总效率
    for u in F.nodes():
        path=nx.shortest_path_length(C,source=u,weight='dis')#注意这里的网络用的是被删掉一条边后的C
        for v in path.keys():
            if u!=v:
                sumeff_rmv+=F[u][v]['flow'] /path[v]
    print abs((sumeff-sumeff_rmv)/sumeff) #输出相对损失效率
```

<p>看到这里有人可能会发现，前面这两段代码里至少有6行看起来是几乎一样的呀，不重要的事能不能不说两遍呢？必须能啊，Python支持自定义函数的，我们写个函数把这6行封装起来就行了：</p>


```python
def network_efficiency(F,G): #def关键字用来定义函数，括号后的变量是参数。参数可以不要，也可以指定每个参数的默认值，不过我们这里不需要。
    sumeff=0
    for u in F.nodes():
        path=nx.shortest_path_length(G,source=u,weight='dis')
        for v in path.keys():
            if u!=v:
                sumeff+=F[u][v]['flow'] /path[v]
    return sumeff #返回结果
```

<p>然后前面两段代码就可以跟在这个函数后面，简化成如下形式：</p>

```python
sumeff=network_efficiency(F,G) #计算不删边的网络效率
for u,v in G.edges():
    C=G.copy()
    C.remove_edge(u,v)
    sumeff_rmv=network_efficiency(F,C) #计算删边的网络效率
    print abs((sumeff-sumeff_rmv)/sumeff) #输出相对损失效率
```

<p>这下看起来爽多了吧：）</p>

## 4 将计算结果写入文件
<p>到这里，我们想解决的问题其实已经解决了。最后的步骤，就是把计算结果写到一个文件里存起来。写入文件的方法和最前面介绍的读取文件的方法很类似：</p>

```python
filesave=open('edgerank.csv','w') #注意open里第二个参数'w'是写入的意思。此外还有追加写入参数'a'，具体可查open的用法
filesave.write('Source,Target,LostEff\n') #先写一行表头，这样输出结果用表格处理软件打开看时比较方便。\n是换行的符号。
sumeff=network_efficiency(F,G)
for u,v in G.edges():
    C=G.copy()
    C.remove_edge(u,v)
    sumeff_rmv=network_efficiency(F,C)
    filesave.write(u+','+v+','+str(abs((sumeff-sumeff_rmv)/sumeff))+'\n')#将每一条边的起终点和删边后的损失效率写入文件。注意数据之间用逗号分隔，字符串用加号连起来，然后数值对象写入文件需要先强制转换为str类型。
filesave.close()
```

## 5 整个程序的完整代码
<p>如下（例子数据可以从这下载 <a href="http://computational-communication.com/uploads/flow.csv"">flow.csv</a> & <a href="http://computational-communication.com/uploads/net.csv"">net.csv</a>）：</p>


```python
# -*- coding: utf-8 -*-
import networkx as nx

G=nx.Graph()
F=nx.DiGraph()

#读网络文件
netfile=open('net.csv')
i=0
for line in netfile:
    if i&gt;0:
        col=line.split(',')
        G.add_edge(col[0],col[1],dis=float(col[2]))
    i+=1
netfile.close()

#读流量文件
flowfile=open('flow.csv')
i=0
for line in flowfile:
    if i&gt;0:
        col=line.split(',')
        F.add_edge(col[0],col[1],flow=float(col[2]))
    i+=1
flowfile.close()

#定义网络效率计算函数
def network_efficiency(F,G):
    sumeff=0
    for u in F.nodes():
        path=nx.shortest_path_length(G,source=u,weight='dis')
        for v in path.keys():
            if u!=v:
                sumeff+=F[u][v]['flow'] /path[v]
    return sumeff

#计算结果并保存
filesave=open('edgerank.csv','w')
filesave.write('Source,Target,LostEff\n')
sumeff=network_efficiency(F,G)
for u,v in G.edges():
    C=G.copy()
    C.remove_edge(u,v)
    sumeff_rmv=network_efficiency(F,C)
    filesave.write(u+','+v+','+str(abs((sumeff-sumeff_rmv)/sumeff))+'\n')
filesave.close()
```

<p>可以看出来，Python代码是很简洁的。如果<a href="http://www.pythonclub.org/python-files/csv">用csv包读写文件</a>，上边的代码会更简洁易读。</p>

## 6 一点感想
<p>我个人觉得，Python编程的最大优势就是你想干什么几乎都可以找到相关的包，很方便地就可以完成你想要的功能，而不用自己去造每一个轮子。networkx就是一个典型的例子——关于图论和复杂网络分析的大部分经典算法，networkx都已经实现了（比如我们前面用到的shortest_path算法，你想挑战一下自己动手写一个吗？），我们需要做的只是了解它叫什么名字，原理如何，怎么调用而已。而且networkx还是一个更新很快的包，一些最新的理论与方法正被不断加入到networkx中。我常用的科学计算包还有数值和矩阵计算用的numpy和scipy，画图用的matplotlib，空间分析用的shapely，自然语言处理用的nltk等。这些包都和networkx类似——开源，更新快，有非常好的在线文档和丰富示例，有大量的用户讨论区资源可供参考。熟悉和使用这些科学计算包，可以极大提高我们的工作效率，将精力专注在要解决的问题，而不是语言本身上面。</p>
<p>这是我在计算传播网的第一篇文章（答应小可很久了，一直没时间写）。希望这篇文章，能对像Piggy一样的Python初学者有所帮助。后面有时间，我会继续写一些自己觉得有用或有趣的东西。</p>
