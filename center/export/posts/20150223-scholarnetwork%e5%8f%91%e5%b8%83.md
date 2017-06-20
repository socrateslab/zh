title: scholarNetwork发布
link: http://ccc.nju.edu.cn/?p=113
author: admin
description: 
post_id: 113
created: 2015/02/23 16:31:01
created_gmt: 2015/02/23 16:31:01
comment_status: closed
post_name: scholarnetwork%e5%8f%91%e5%b8%83
status: publish
post_type: post

# scholarNetwork发布

scholarNetwork是一个由王成军等人开发的python第三方包，今天已经发布（https://pypi.python.org/pypi/scholarNetwork/），它可以帮助抓取并可视化个人的谷歌学术页面的共同作者网络。

# Install

Install from pypi using pip or easy_install
    
    
    pip install scholarNetwork
    

or
    
    
    easy_install scholarNetwork
    

# Use
    
    
    # scholarNetwork
    
    from scholarNetwork import scholarNetwork 
    import matplotlib.pyplot as plt 
    import networkx as nx
    
    ## The seed of crawler
    
    seed = 'https://scholar.google.nl/citations?user=nNdt_G8AAAAJ&hl=en&oe=ASCII'
    
    # How many nodes do you want to visulize? Always start with a small one.
    
    Nmax = 21
    
    ## Get the graph g
    
    g = scholarNetwork.getGraph(seed, Nmax)
    
    ## plot the network
    
    pos=nx.spring_layout(g) #setup the layout
    
    nx.draw(g, pos, node_shape = 'o', edge_color = 'gray', width = 0.5, with_labels = True, arrows = True) 
    plt.show()