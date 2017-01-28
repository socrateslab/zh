---
layout: single
title: "12行Python代码回复微信拜年"
header:
  teaser: "/assets/images/unsplash-gallery-image-3-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-8.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "今天上午在朋友圈读到了[《12行Python代码，自在随心应付微信拜年群发》](https://zhuanlan.zhihu.com/p/25034403)一文，非常简单，主要是借助于两个python的包 itchat和pillow，可以使用pip安装。"
modified: 2017-01-28 12:49:48
comments: true
author: "王成军"
tags:
  - wechat
categories:
  - python
---

今天上午在朋友圈读到了[《12行Python代码，自在随心应付微信拜年群发》](https://zhuanlan.zhihu.com/p/25034403)一文，非常简单，主要是借助于两个python的包 itchat和pillow，可以使用pip安装。

```terminal
pip install itchat pillow
```

[itchat](https://github.com/littlecodersh/ItChat)是 `A complete and graceful API for Wechat`. 微信个人号接口、微信机器人及命令行微信，三十行即可自定义个人号机器人。了解更多使用方法，可以阅读使用[文档 ](http://itchat.readthedocs.io )。

我在Mac上运行以下代码:

```python
# -*- coding:utf-8 -*-
import itchat, time, re
from itchat.content import *

@itchat.msg_register([TEXT])
def text_reply(msg):
    match = re.search(u'年', msg['Text']).span()
    if match:
      itchat.send((u'新春快乐，鸡年大吉，身体健康，万事如意！'), msg['FromUserName'])

@itchat.msg_register([PICTURE, RECORDING, VIDEO, SHARING])
def other_reply(msg):
    itchat.send((u'新春快乐，鸡年大吉，身体健康，万事如意！'), msg['FromUserName'])

itchat.auto_login(enableCmdQR=2,hotReload=True)
itchat.run()
```

因为是Python2.7版本，所以注明了utf8编码。另外需要注意的还有两点：

1. linux系统块字符的宽度为一个字符（正常应为两字符），故`enableCmdQR=2`,赋值为2，默认为True。
2. 微信二维码的阴影信息非常关键，所以白色背景的terminal无法正确运行，需要更改terminal的颜色为其它颜色;如果你在其它编程环境（如jupyter notebook）中运行并显示二维码，那么也需要页面为其它深色背景。

如果我们在terminal中运行，只需要把以上程序保存下来，比如我放在Users/chengjun/github/wechat/index.py，只需要在terminal中运行下图代码即可。

```terminal
cd gitub/wechat
python index.py
```

![mac-itchat](http://oaf2qt3yk.bkt.clouddn.com/809147ac86ad5ee6d338c3c01706dceb.png)

生成二维码后，扫描二维码即可登录，亲测有效。
