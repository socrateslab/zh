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
modified: 2018-11-25T11:55:22-04:00
comments: true
author_profile: true
author: "王成军"
---

{% include toc title="Table" icon="file-text" %}


实验中心配备了4台大内存服务器、两台网络服务器、两台nas，还有10台塔式服务器。之前一直通过学校外网ip进行使用，2018年搬到仙林校区紫金楼后仅仅申请了一个校内网固定ip（114.212.178.252），绑定防火墙mac地址（58696c0f42f8)，通过原有的防火墙设置了虚拟ip的映射。例如：

| Name | Outnet | Port|Innet |Port |
| - | :-: | :-: | :-: |-: |
|2223port|wan2/114.212.178.252|	**2223**/tcp	|192.168.50.13	|22/tcp|
|5961port	|wan2/114.212.178.252|	**5961**/tcp	|192.168.50.13	|5901/tcp|
|2224port|wan2/114.212.178.252|	**2224**/tcp	|192.168.50.14	|22/tcp|
|5981port	|wan2/114.212.178.252|	**5981**/tcp	|192.168.50.14	|5901/tcp|



# ssh工具Termius

[https://termius.com/download/](https://termius.com/download/)

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

![png]({{ site.url }}{{ site.baseurl }}/assets//img2018/termius.png)

# 图形化界面VNC

- Q:连接VNC出现too many security failures
- A:问题可能是因为VNC关闭了，重新启动一下VNC服务。

```
ssh root@ip -p port  #登录后，重启vnc服务器：
service vncserver restart
```

需要特别注意的是：每一个服务器做了两组映射，一组用于ssh，一组用于vnc。VNC的使用使用的是校内ip的vnc端口，这个端口映射到路由器ip的vncserver端口。

    MacBook-Pro:~ datalab$ telnet 114.212.178.252 5961
    Trying 114.212.178.252...
    Connected to 114.212.178.252.
    Escape character is '^]'.
    RFB 003.008


| Name | Outnet | Port|Innet |Port |
| - | :-: | :-: | :-: |-: |
|2223port|wan2/114.212.178.252|	**2223**/tcp	|192.168.50.13	|22/tcp|
|5961port	|wan2/114.212.178.252|	**5961**/tcp	|192.168.50.13	|5901/tcp|
|2224port|wan2/114.212.178.252|	**2224**/tcp	|192.168.50.14	|22/tcp|
|5981port	|wan2/114.212.178.252|	**5981**/tcp	|192.168.50.14	|5901/tcp|

![png]({{ site.url }}{{ site.baseurl }}/assets//img2018/vnc.png)

# 文件传输

- 可以使用filezilla

![png]({{ site.url }}{{ site.baseurl }}/assets//img2018/filezilla.png)


- 也可以采用bitvise软件在windows机器上图形化界面登陆。

Tunnelier is free for personal use, as well as for individual commercial use inside organizations. You can download Tunnelier here. http://www.bitvise.com/download-area



> ssh -N -f -L 8882:localhost:7777 server2
