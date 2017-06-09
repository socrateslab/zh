---
layout: single
title: "LDAvis——用R做中文LDA主题模型可视化分析"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-8.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "LDAvis 是一个交互式的主题模型可视化包，可以将主题模型建模后的结果，利用D3.js封装好的一个可视化模板，制作成一个网页交互版的结果分析工具。"
modified: 2015-12-17T11:55:22-04:00
comments: true
categories:
  - 可视化
tags:
- R
author_profile: true
author: "谈和"
---


<p><em>前言：本文话语极为啰嗦，因为想让更多技术背景不深的人也能看懂，所以望能谅解。</em></p>
<p>LDA主题模型在2002年被David M. Blei、Andrew Y. Ng（是的，就是吴恩达老师）和Michael I. Jordan三位第一次提出，近几年随着社会化媒体的兴起，文本数据成为越来越重要的分析资料；海量的文本数据对社会科学研究者的分析能力提出了新的要求，于是LDA主题模型（Topic Model）作为一种能够从大量文本中提取出主题的概率模型，被越来越多的运用到主题发现、文档标记等社会科学研究中来。</p>
<p>关于主题模型的详细介绍，大家可参考<a href="http://www.cnblogs.com/siegfang/archive/2013/01/30/2882391.html">概率主题模型简介</a>、<a href="http://blog.csdn.net/huagong_adu/article/details/7937616">主题模型——LDA浅析</a>，如果想更深入地了解其背后的数学原理，不妨看看这本<a href="http://yuedu.baidu.com/ebook/d0b441a8ccbff121dd36839a">LDA算法漫游指南</a>。</p>
<p>前不久，易红发介绍了<a href="http://computational-communication.com/2015/12/python-%E4%B8%8B%E7%9A%84%E6%96%87%E6%A1%A3%E8%81%9A%E7%B1%BB%E5%92%8C%E4%B8%BB%E9%A2%98%E5%BB%BA%E6%A8%A1/">Python下的文档聚类和主题模型</a>，沈浩老师在微信朋友圈中分享的过程中告知我们还有一个能将LDA主题模型的分析结果进行可视化展现的python模块——<a href="https://pyldavis.readthedocs.org/en/latest/">pyLDAvis</a>。于是受我去研究了一下，现将研究结果分享于此：</p>
<p><strong>pyLDAvis的来历</strong></p>
<p>pyLDAvis 是一个交互式的主题模型可视化包，可以将主题模型建模后的结果，利用D3.js封装好的一个可视化模板，制作成一个网页交互版的结果分析工具。但是在pyLDAvis之前，已经有人用R语言制作出LDAvis，所以pyLDAvis是在参考了R语言版本的基础上再次开发出来的。<a href="http://nlp.stanford.edu/events/illvi2014/papers/sievert-illvi2014.pdf">LDAvis</a>开发者开发这款工具的初衷是为了回答三个问题：</p>
<ol>
<li>What is the meaning of each topic? 每个主题的意义是什么？</li>
<li>How prevalent is each topic? 每个主题有多么的普遍？</li>
<li>How do the topics relate to each other? 主题之间有什么关联？</li>
</ol>
<p>LDA主题模型有很多工具和代码都可以实现，但是真正难的是对分析结果的解释。笔者的本科毕业论文运用了这种方法，当时感觉最难的部分就是如何去解释每个主题，以及如何澄清提取出来的主题在什么程度上能够覆盖文本里的意义。所以LDAvis的作者在制作这款工具的时候，多半也是想到了这些问题，最终这款工具提供的可视化呈现，也正好回答了上面三个问题，下面我们会详述。</p>
<p><strong>为什么没用pyLDAvis</strong></p>
<p>pyLDAvis的安装需要几个依赖的包，如future、numexpr、numpy、pandas、jinjia2、scikit-bio、graphlab等，我在用pip安装pyLDAvis的时候，总是会报错，后来在stackoverflow上找到答案，问题出在这里：</p>
<blockquote>
<p>scikit-bio is not yet supported nor installable on Windows. We have plans to add Windows support in an upcoming release (tentatively 0.5.0, scheduled for early 2016).</p>
</blockquote>
<p>scikit-bio目前不支持windows系统上的安装，所以如果你跟我一样，打算用windows系统尝尝鲜，那么至少目前是用不了的。</p>
<p>既然pyLDAvis用不了，何不直接用它的师傅——基于R语言的LDAvis.下面我们言归正传，正式介绍如何使用LDAvis制作可视化的主题模型分析结果（逼逼了半天……）。由于国外的例子都是基于英文语言的应用，本着将研究方法本土化的目的，我们将用中文的例子，来分享上述工具的使用。因此，您将从下面的分享中了解到：</p>
<ol>
<li>如何用R对中文文本进行分词？</li>
<li>如何用R做主题模型建模？</li>
<li>如何用LDAvis对建模的结果进行可视化展现？</li>
</ol>
<p>需要用到的R包有：jiebaR、lda、LDAvis</p>
<p><strong>jiebaR中文分词</strong></p>
<blockquote>
<p>jiebaR是“结巴”中文分词（Python）的R语言版本，支持最大概率法（Maximum Probability），隐式马尔科夫模型（Hidden Markov Model），索引模型（QuerySegment），混合模型（MixSegment）共四种分词模式，同时有词性标注，关键词提取，文本Simhash相似度比较等功能。项目使用了Rcpp和CppJieba进行开发。目前托管在GitHub上。安装很简单。<a href="http://qinwenfeng.com/cn/jiebaR-dev/">jiebaR中文分词——R的灵活，C的效率</a></p>
</blockquote>
<p>是的,笔者用过jiebaR后，发现确实很方便。最方便的是不会有为rJava设置环境Path的烦恼，安装了就能用；而且用的是RCpp开发的，据说jiebaR的分词速度是其他R语言分词包的5-20倍。</p>

```r
library(jiebaR) #加载
cutter <- worker(bylines = T,user = "./UsrWords.txt",stop_word = "./stopWords.txt")
#创建分词器，其中bylines是否按行来分，user用户词典，stop_word停用词典
comments_seg <- cutter["./Mobilecomments.txt"] #文件分词，直接输入文件地址，分完后自动保存成文件
```
<p>注：笔者演示所用数据为jd上某款手机的评论数据，每条评论一行。</p>
<p>上面三行代码完成了主题模型建模前很多的准备步骤，1、分词，2、根据用户词典分词，3、去掉没用的停用词（网上一搜“中文停用词表”就能搜到），执行了这三行命令后，R会自动保存一个分完词的文件在你的工作目录。结果如：</p>

```r
还行 慢慢 习惯 功能 便捷
手机 网上 价格 实惠
收到 货 满意 喜欢 值得 购买
```
<p>但是，由于LDA主题模型不是对文本进行运算，在做主题建模前，还需将文本转化为向量，用数字来代替文本，从而方便运算。</p>

```r
comments_segged<- readLines("./Mobilecomments.segment.2015-12-17_13_57_30.txt",encoding="UTF-8") #读取分词结果
comments <- as.list(comments_segged) #将向量转化为列表
doc.list <- strsplit(as.character(comments),split=" ") #将每行文本，按照空格分开，每行变成一个词向量，储存在列表里
```
<p>接下来，就像在python下gensim包里的操作一样，我们需要创建一个词典，并给每个词取一个编号：</p>

```r
term.table <- table(unlist(doc.list))
#这里有两步，unlist用于统计每个词的词频；table把结果变成一个交叉表式的factor，原理类似python里的词典，key是词，value是词频
term.table <- sort(term.table, decreasing = TRUE) #按照词频降序排列
```
<p>在前面，我们用stop_words去掉了数字、标点符号、虚词等，由于现代汉语里用单字表示一个词语的词已经很少了，这里为了提高建模效果，我们可以将单字去掉，同时也可以把出现次数少于5次的词去掉。</p>

```r
del <- term.table < 5| nchar(names(term.table))<2   #把不符合要求的筛出来
term.table <- term.table[!del]   #去掉不符合要求的
vocab <- names(term.table)    #创建词库
```
<p>接下来，我们要把文本的格式整理成lda包建模需要的格式。lda包对格式有具体要求：</p>

<blockquote>
<p>A list whose length is equal to the number of documents, D. Each element of documents is an integer matrix with two rows. Each column of documents&#91;[i]&#93; (i.e., document i) represents a word occurring in the document. documents[[i]][1, j] is a 0-indexed word identifier for the jth word in document i. That is, this should be an index &#8211; 1 into vocab. documents[[i]][2, j] is an integer specifying the number of times that word appears in the document.</p>
</blockquote>
<p>说人话就是…………还是上图吧！</p>

    [,1] [,2] [,3]
    [1,]    8  261   46
    [2,]    1    1    1

<p>这是一个文档，第一行是词的ID，第二行是词在文档里出现的频次。为了能生成这样的结构，这里我参考了LDAvis作者的代码：</p>

```r
get.terms <- function(x) {
index <- match(x, vocab)  # 获取词的ID
index <- index[!is.na(index)]  #去掉没有查到的，也就是去掉了的词
rbind(as.integer(index - 1), as.integer(rep(1, length(index))))   #生成上图结构
}
documents <- lapply(doc.list, get.terms)
```
<p>至此，我们就准备好了做LDA建模需要用的数据了。</p>
<p><strong>LDA主题建模</strong></p>
<p>这部分没啥好说的，直接上代码：</p>

```r
K <- 5   #主题数
G <- 5000    #迭代次数
alpha <- 0.10   
eta <- 0.02
```
<p>这些为LDA建模需要先设置的几个参数，关于alpha、eta的设置和作用，引用梁斌penny的一段话：</p>
<blockquote>
<p>其中α，大家可以调大调小了试试看，调大了的结果是每个文档接近同一个topic，即让p(wi|topici)发挥的作用小，这样p(di|topici)发挥的作用就大。其中的β，调大的结果是让p(di|topici)发挥的作用变下，而让p(wi|topici)发挥的作用变大，体现在每个topic更集中在几个词汇上面，或者而每个词汇都尽可能的百分百概率转移到一个topic上。</p>
</blockquote>
<p>接下来是主题建模的过程，以文本量大小和迭代次数多少，用时会不同，多则几十分钟，少则一两分钟。</p>

```r
library(lda)
set.seed(357)
fit <- lda.collapsed.gibbs.sampler(documents = documents, K = K, vocab = vocab, num.iterations = G, alpha = alpha, eta = eta, initial = NULL, burnin = 0, compute.log.likelihood = TRUE)
```
<p><strong>LDAvis可视化</strong></p>
<p>用LDAvis做可视化也很简单，只要把相应的参数准备好：</p>

```r
theta <- t(apply(fit$document_sums + alpha, 2, function(x) x/sum(x)))  #文档—主题分布矩阵
phi <- t(apply(t(fit$topics) + eta, 2, function(x) x/sum(x)))  #主题-词语分布矩阵
term.frequency <- as.integer(term.table)   #词频
doc.length <- sapply(documents, function(x) sum(x[2, ])) #每篇文章的长度，即有多少个词
```
<p>调用LDAvis:</p>

```r
library(LDAvis)
json <- createJSON(phi = phi, theta = theta,
               doc.length = doc.length, vocab = vocab,
               term.frequency = term.frequency)
#json为作图需要数据，下面用servis生产html文件，通过out.dir设置保存位置
serVis(json, out.dir = './vis', open.browser = FALSE)
```
至此，一个基于网页的可交互的主题模型可视化分析展示就做出来了，servis会在指定的路径下生成文件夹vis，里面包含：

![ladvisfiles](http://oaf2qt3yk.bkt.clouddn.com/d85fabdf8b1bfcb1e5105d35da0b8aea.png)

<p>将文件全部上传服务器或者用firefox（其他浏览器不行，因为网页需要读取数据文件，需在服务器环境下才行)，就可以看到如下的交互界面了：</p>

![ldavis_demo](http://oaf2qt3yk.bkt.clouddn.com/10fcb7f890f205832210150eedc8889d.png)

<p>这里还会出现一个问题，由于我们做的是中文的主题建模，而这个工具本身在英文环境下创建的，所以没有考虑中文显示的问题。做完上面的步骤后，打开网页，会出现乱码的问题。为了解决乱码的问题，我们需要将其中的lda.json文件的编码改成UTF8格式，你可以手动改，也可以用R来自动改。</p>

```r
writeLines(iconv(readLines("./vis/lda.json"), from = "GBK", to = "UTF8"),
       file("./vis/lda.json", encoding="UTF-8"))
```

<p>现在，是时候回答LDAvis最开始提出的三个问题了：</p>

<ol>
<li>每个主题表示什么意义？ 通过鼠标悬浮在左边的气泡上，我们可以选择查看具体的某个主题。选定后，右侧面板会相应地显示出跟这个主题相关的词汇，通过总结这些词汇表达的意义，我们可以归纳出该主题的意义。</li>
</ol>

<p>但是，作者却不局限于此，右侧词汇都是跟主题相关，但是到底谁更相关呢？在这里，LDAvis的作者提出了一个算法：</p>


```r
relevance(term w | topic t) = λ * p(w | t) + (1 - λ) * p(w | t)/p(w);
```

<p>某个词语主题的相关性，由λ参数来调节。如果λ接近1，那么在该主题下更频繁出现的词，跟主题更相关；如果λ越接近0，那么该主题下更特殊、更独有（exclusive）的词，跟主题更相关。所以读者可以通过调节λ的大小来改变词语跟主题的相关性，至于λ取多少，读者可以自己多尝试。</p>

<ol>
<li>
<p>每个主题有多么普遍？ 在跑完主题建模之后，我们就可以知道每个主题出现的频率。LDAvis的作者将这个数字，用圆圈的大小来表示，所以气泡的大小表示主题出现的频率。</p>
</li>
<li>
<p>主题之间有什么关联？ 这里作者用多维尺度分析，提取出主成分做维度，将主题分布到这两个维度上，主题相互之间的位置远近，就表达了主题之间的接近性。</p>
</li>
</ol>
<p>最后，由于我的模型跑出来效果不好，得改参数多尝试，所以先贴上LDAvis作者自己做的一个结果比较有意义的例子，这个例子是通过电影的描述语句，来对电影分类建模。</p>
<p>示例：<a href="http://cpsievert.github.io/LDAvis/reviews/vis/#topic=7&amp;lambda=0.6&amp;term="> Cornell Movie Review Topic Modeling</a></p>

<p><iframe src="http://cpsievert.github.io/LDAvis/reviews/vis/#topic=7&#038;lambda=0.37&#038;term=" width="1200" height="1000"> </iframe></p>
