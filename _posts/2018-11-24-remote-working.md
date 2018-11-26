---
layout: single
title: "服务器远程登录的简单工具"
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-4.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "本文总结一些计算平台的简单管理工具，包括terminus、filezilla、VNCviewer等。"
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


linux 根目录以 / 开始，所以要想跑到最顶层，输入`cd /`打开顶层的文件夹


```
cd /
```

使用**dir**看某个文件夹下的文件：

```
dir
```

退出一个文件夹使用 `cd ..`


```
cd ..
```

![png]({{ site.url }}{{ site.baseurl }}/assets//img2018/terminus.png)

在 Termius 中,Linux 的一些基本操作命令:

1. `cd` [切换的目录] 切换到当前目录
2. `top` 监测 Linux 的系统状况,cpu 和内存的使用情况
3. `q` 可以退出 top
4. `ll` 查看目录
5. `nohup python3 **.py & ` 可以在关闭自己的电脑的铅矿下后台运行这个程序
6. `kill -9` [对应需要结束的程序的 PID] 强制中断一个进程的进行

提示:可以在手机上下载 Termius,可以在手机上监测 只能在有校园网的情况下使用


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

# filezilla文件传输

- 可以使用filezilla

![png]({{ site.url }}{{ site.baseurl }}/assets//img2018/filezilla.png)


- 也可以采用bitvise软件在windows机器上图形化界面登陆。

Tunnelier is free for personal use, as well as for individual commercial use inside organizations. You can download Tunnelier here. http://www.bitvise.com/download-area



# 从PC通过浏览器访问服务器上的Jupyter Notebook

为了更好地利用服务器的计算资源，一直希望能够有一种方法从PC通过浏览器访问服务器上的Jupyter Notebook。事实上，在IPython官网上有一份很详细的文档，说明了如何[**Running a notebook server**](https://ipython.org/ipython-doc/2/notebook/public_server.html)


不过，由于实验室的服务器网络情况特殊，几台服务器共用一个公网IP，要想直接访问其中的某一台服务器，还需要通过防火墙，因此要采取另一种方法，**建立ssh隧道**，就是在建立ssh连接的时候实现一个端口的转发就行了。

以下内容参考
[http://www.hydro.washington.edu/~jhamman/hydro-logic/blog/2013/10/04/pybook-remote/](http://www.hydro.washington.edu/~jhamman/hydro-logic/blog/2013/10/04/pybook-remote/)

## 第一步

如果PC为Linux或Mac，可以直接用ssh命令

``` bash
$ ssh -N -f -L [remote port]:localhost:[local port] -p [ssh port] -l [username] [公网IP]
```

例如，对于2223这台服务器而言，需要在个人的笔记本电脑的terminal中输入:

```bash
ssh -N -f -L 7777:localhost:7777 -p 2223 -l sysadmin 114.212.178.252  
```

在Windows下无法直接运行这条命令，因此要借助其他软件，陈志聪用的是Xshell，在Xshell的连接属性中建立一个隧道，实现一下端口的转发即可。

![png]({{ site.url }}{{ site.baseurl }}/assets//img2018/xshell.png)


## 第二步

在这样的一个ssh连接中启动jupter notebook服务，只需要使用termius登陆服务器，并输入如下命令

``` bash
$ jupyter notebook --no-browser --port=7777
```

将jupyter Notebook运行在服务器的7777端口，并且设置为不在服务器上打开浏览器，然后在PC上通过浏览器访问localhost:7777即可远程访问。

效果如下图（亲测有效）：

![png]({{ site.url }}{{ site.baseurl }}/assets//img2018/ssh-tunnel.png)
