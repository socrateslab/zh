---
title:  "Welcome to Jekyll, Markdown, and Atom!"
header:
  teaser: "https://farm5.staticflickr.com/4076/4940499208_b79b77fb0a_z.jpg"
categories:
  - Jekyll
tags:
  - update
---

# 一、关于Jekyll

这个网站使用Jekyll构建。Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll's GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: http://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/


You'll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes.

You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter.

Take a look at the source for this post to get an idea about how it works.


# 二、关于Markdown

Jekyll较好地支持了markdown写作，关于markdown的简单介绍参见：

[https://guides.github.com/features/mastering-markdown/](https://guides.github.com/features/mastering-markdown/)

### 程序代码

Jekyll also offers powerful support for code snippets:

    ```ruby
    def print_hi(name)
      puts "Hi, #{name}"
    end
    print_hi('Tom')
    #=> prints 'Hi, Tom' to STDOUT.
    ```

效果如下：


```ruby
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
```

### 参考文献

markdown可以较好地支持参考文献功能。例如：It is intended only for human readers.[^1]

[^1]: jekyll <http://en.wikipedia.org/wiki/Syntax_highlighting>

实现以上效果的方式如下：

```jekyll
It is intended only for human readers.[^1]

[^1]: <http://en.wikipedia.org/wiki/Syntax_highlighting>
```


# 三、使用Atom编辑markdown文件

使用**Atom**来编写markdown非常不错，按ctr+shift+m就可以进入预览模式，我想markdownpad可以抛弃掉了。这个软件更流畅，非常棒！因为我经常要写github的博客，使用atom时最容易的形式。减少了甚多负担，非常的自由，如果它具有上传功能就好了。

### Atom的markdown预览插件

安装了markdown-preview-enhanced可以实时展示markdown文件的编辑效果，这个插件的好处是当你上下滚动浏览markdown文件的时候，右侧的预览部分也会追踪鼠标上下移动。按```ctrl+ shift+ m```即可进入预览。

markdown-preview-enhanced可以很方便的预览数学公式，比如 $x = y^2$。推荐设置本插件使用mathjax来预览数学公式，因为我们在github上的网站使用mathjax来展现数学公式。

使用美元符号和latex格式的数学公式即可，比如：

    $E = MC^2$

效果如下：

$E = MC^2$



### Atom的图片上传插件

结果就发现阿里巴巴程序员knightli的两个atom插件：qiniu-uploader和markdown-assistant。设置好七牛的账号既可以非常方便地使用图床了。赞。

![qiniu-uploader](http://oaf2qt3yk.bkt.clouddn.com/1895b6670f7276a1f10903cf1305e686.png)

### Atom的Git上传插件

接着又找到了[git-plus](https://atom.io/packages/git-plus)这个强大的插件，可以直接在atom里上传了。好吧！社区的力量真强大。太好了。

- 按 *command+shift+H*打开操作界面。
- 选择`add all commit+push`就可以上传了！只需要填写commit的内容，按command+s保存即可上传

![surprise](http://oaf2qt3yk.bkt.clouddn.com/7497f687c919c447882fd0abd4d68bc2.png)

震惊脸！！！!


### Atom的atom-html-preview插件

如果你需要修改的html文件的话，可以很方便地使用atom-html-preview插件。

![atom-html-preview](http://oaf2qt3yk.bkt.clouddn.com/d832f904c15079ed7f38816a5407c1b6.png)
