---
layout: single
title: "服务器远程登录的简单工具"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-4.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "本文总结一些计算平台的简单管理工具"
modified: 2017-06-28T11:55:22-04:00
comments: true
author_profile: true
author: "王成军"
---

{% include toc title="Table" icon="file-text" %}



# ssh工具Termius

https://termius.com/download/

> Termius is available on iOS, Android, Mac OS, Ubuntu, and MS Windows. Download the app for free on your platform and become one of the more than a million happy users.

> Termius Basic fully supports essential functionality such as SSH, Telnet, and Port forwarding and it is available for free and ad-free, always.

- 填写ssh root@ip -p port  
- 输入密码

默认登录到sysadmin界面，使用**su**命令切换到root

```
su
```


linux 根目录以 / 开始，所以要想跑到最顶层，输入**cd /**打开顶层的文件夹


```
cd /
```

使用**dir**看某个文件夹下的文件：

```
dir
```

退出一个文件夹使用 **cd ..**


```
cd ..
```

# 图形化界面VNC

- Q:连接VNC出现too many security failures
- A:问题可能是因为VNC关闭了，重新启动一下VNC服务。

```
ssh root@ip -p port  #登录后，重启vnc服务器：
service vncserver restart
```

# 文件传输

- 可以使用filezilla
- 也可以采用bitvise软件在windows机器上图形化界面登陆。

Tunnelier is free for personal use, as well as for individual commercial use inside organizations. You can download Tunnelier here. http://www.bitvise.com/download-area


#
