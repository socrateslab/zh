---
layout: single
title: "Introduction to Social Simulation with Python"
header:
  teaser: "/assets/images/unsplash-gallery-image-2-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-16.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "Source code and materials for the tutorial 'Introduction to Simulation: Complex social dynamics in a few lines of code'. The tutorial was held on 11th July, 2016 within the **Digital Humanities conference** at Krakow, Poland."
modified: 2017-04-20 19:49:48
comments: true
author: "Xavier Rubio-Campillo"
tags:
  - power law
categories:
  - Python
---


Author: [Xavier Rubio-Campillo](http://www.ed.ac.uk/history-classics-archaeology/about-us/staff-profiles/profile_tab1_academic.php?uun=xrubioc&search=2)

https://github.com/xrubio/simulationdh （View it on [nbviewr](http://nbviewer.jupyter.org/github/xrubio/simulationdh/blob/v1.1/doc/DH2016tutorial.ipynb  ))


The tutorial was held on 11th July, 2016 within the **Digital Humanities conference** at Krakow, Poland. It is recommended to begin by taking a look at the introductory presentation at [doc/slides.pdf](https://github.com/xrubio/simulationdh). The second step would be to setup the environment and follow the tutorial at doc/DHtutorial.pdf. You can finally check the result against the code found in src/DHworkshop.py and extend the model to solve the challenges defined at the end of slides.pdf

We will create a model depicting **competition between two cultural traits** within a common population. This is a typical **cultural dynamics** scenario where individuals must adopt one option amongst two or more mutually exclusive options (i.e. religion, elections, football teams). In this case we are interested in situations when you have to choose one option (e.g., you cannot practice two religions), but more complex versions with individuals adopting more than one trait can easily be developed.

> Individuals can change their choice over time. The decision is based on the payoff of each trait.

This payoff is a measure of the relative interest of the trait, based on:

a) how many people exhibits the trait and

b) the attractiveness of the trait.


An example of this dynamic could be a competition between two different religions. The number of people practicing a belief makes this belief more appealing. However, some beliefs could be intrinsically more interesting for some individuals so part of the population could adopt them even if they are a minority. Finally, social norms are not static so the attractiveness of specific beliefs can vary over time.

![path_intro](http://oaf2qt3yk.bkt.clouddn.com/f801e211a3cf1f0275214fc73d2fb5a0.png)

Time is divided in discrete steps starting at t = 0.

At each step t the two populations At and Bt are updated as individuals move from A to B and from B to A. Take into accout that the value here can be negative meaning that more people move from B to A.

At+1=At+ΔAB

Bt+1=Bt−ΔAB


Let's see how we can express it in code.

First, we need to define the number of individuals in the population. Say we want to start with 100 people. The text after a hash symbol is just a comment so you can skip it for now, but in general it is a good idea to keep documenting the code as you write.



```python
N = 100   # total population size
```


```python
# Then, we decide on how many believers of each cultural option (religion) we want to start with.
A = 65    # initial number of believers A
B = N - A # initial number of believers A
```

```python
t = 0
MAX_TIME = 100
while t < MAX_TIME:
    # variation has not been defined yet.
    A = A + variation
    B = B - variation

    # advance time to next iteration
    t = t + 1  
```

So let's calculate **variation** based on the population switching trait based on a comparison between payoffs. For example if B has higher payoff then A then we should get something like this:

### $$\Delta_{A \rightarrow B} = A (Payoff_{A \rightarrow B} - Payoff_{B \rightarrow A})$$

So the proportion of population A that switches to B is proportional to the difference between payoffs. As we mentioned the payoff of a trait is determined by the population exhibiting the competing trait as well as its intrinsic attractiveness.

To define the payoff we need to implement the following competition equations:

###    $$ Payoff_{B \rightarrow A} = \frac{A_t}{N} \frac{T_A}{T_A + T_B}$$

###    $$ Payoff_{A \rightarrow B} = \frac{B_t}{N} \frac{T_B}{T_A + T_B}$$

- The first term is the proportion of the entire population N holding a particular cultural trait (At/N for A and Bt/N for B).
- The second element of the equations is the balance between the attractiveness of both ideas (TA and TB) expressed as the attractiveness of the given trait in respect to the total 'available' attractiveness (TA+TB).




```python
def payoff(believers, Tx,Ty):    
    proportionBelievers = believers/N
    attraction = Tx/(Ty + Tx)
    return proportionBelievers * attraction
```


```python
# temporal dimension
MAX_TIME = 100
t = 0               # initial time

# init populations
N = 100          # population size
A = 65           # initial population of believers A
B = N-A             # initial population of believers B

# additional params
Ta = 1.0            # initial attractiveness of option A
Tb = 2.0            # initial attractiveness of option B
alpha = 0.1         # strength of the transmission process
```


```python
# calculate the payoff for change of believers A and B in the current time step       
variationBA = payoff(A, Ta, Tb)      
variationAB = payoff(B, Tb, Ta)     
difference = variationBA - variationAB
difference

# the proportion of population B that switches to A is proportional to the difference between payoffs.
```







```python
# when difference > 0, B will switch to A
# Else, A will switch to B.

# B -> A   
if difference > 0:
    variation = difference*B
# A -> B        
else:
    variation = difference*A

variation

# when variation > 0, B will switch to A
# Else, A will switch to B.
```





```python
# control the pace of change with alpha
variation = alpha*variation
```


```python
while t < MAX_TIME:
    # calculate the payoff for change of believers A and B in the current time step       
    variationBA = payoff(A, Ta, Tb)      
    variationAB = payoff(B, Tb, Ta)     
    difference = variationBA - variationAB

    # B -> A   
    if difference > 0:
        variation = difference*B
    # A -> B        
    else:
        variation = difference*A

    # control the pace of change with alpha
    variation = alpha*variation  

    # update the population    
    A = A + variation
    B = B - variation

    # advance time to next iteration
    t = t + 1
```

## Tracing the changes

- First, add the initial number of believers to their respective lists.
- Second, we also need to update the number of believers for each step.


```python
# initialisation
MAX_TIME = 100
t = 0               # initial time
N = 100           # population size
A = 65              # initial proportion of believers A
B = N-A             # initial proportion of believers B

Ta = 1.0            # initial attractiveness of option A
Tb = 2.0            # initial attractiveness of option B
alpha = 0.1         # strength of the transmission process

# initialise the list used for plotting
believersA = []    
believersB = []

# add the initial populations
believersA.append(A)
believersB.append(B)
```


```python
while t < MAX_TIME:
    # calculate the payoff for change of believers A and B in the current time step       
    variationBA = payoff(A, Ta, Tb)      
    variationAB = payoff(B, Tb, Ta)     
    difference = variationBA - variationAB

        # B -> A   
    if difference > 0:
        variation = difference*B
    # A -> B        
    else:
        variation = difference*A

    # control the pace of change with alpha
    variation = alpha*variation  

    # update the population    
    A = A + variation
    B = B - variation   

    # save the values to a list for plotting    
    believersA.append(A)
    believersB.append(B)

    # advance time to next iteration
    t = t + 1
```


```python
%matplotlib inline
import matplotlib.pyplot as plt      # plotting library
plt.style.use('ggplot')              # makes the graphs look pretty
```


```python
# plot the results    
plt.plot(believersA, label = 'A')
plt.plot(believersB, label = 'B')
plt.xlabel('$Time$', fontsize = 20)
plt.ylabel('$Number$', fontsize = 20)
plt.legend(loc = 0)
plt.show()
```

![social simulation 1](http://oaf2qt3yk.bkt.clouddn.com/cb201bbf89d946a001e6f724b63dfba6.png)


## Let the attractiveness of each optio change through time.


```python
def attractiveness(Ta, Tb):
    Ka = 0.1  
    Kb = 0

    Ta = Ta + Ka
    Tb = Tb + Kb
    return Ta, Tb
```


```python
# initialisation
MAX_TIME = 100
t = 0               # initial time
N = 100           # population size
A = 65              # initial proportion of believers A
B = N-A             # initial proportion of believers B

Ta = 1.0            # initial attractiveness of option A
Tb = 2.0            # initial attractiveness of option B
alpha = 0.1         # strength of the transmission process

# initialise the list used for plotting
believersA = []    
believersB = []

# add the initial populations
believersA.append(A)
believersB.append(B)
```


```python
while t < MAX_TIME:
    # update attractiveness
    Ta, Tb = attractiveness(Ta, Tb)
    # calculate the payoff for change of believers A and B in the current time step           
    variationBA = payoff(A, Ta, Tb)      
    variationAB = payoff(B, Tb, Ta)     
    difference = variationBA - variationAB

        # B -> A   
    if difference > 0:
        variation = difference*B
    # A -> B        
    else:
        variation = difference*A

    # control the pace of change with alpha
    variation = alpha*variation  

    # update the population    
    A = A + variation
    B = B - variation   

    # save the values to a list for plotting    
    believersA.append(A)
    believersB.append(B)

    # advance time to next iteration
    t = t + 1
```


```python
# plot the results    
plt.plot(believersA, label = 'A')
plt.plot(believersB, label = 'B')
plt.xlabel('$Time$', fontsize = 20)
plt.ylabel('$Number$', fontsize = 20)
plt.legend(loc = 0)
plt.show()
```


![social simulation 2](http://oaf2qt3yk.bkt.clouddn.com/f01ee4996485d9653dc2104ce5784764.png)

There are a number of functions we can use to dynamically change the 'attractiveness' of each trait.
Try the following ones:



```python
import numpy as np # stick this line at the beginning of the script alongside other 'imports'


def attractiveness2(Ta, Tb):
    # temporal autocorrelation with stochasticity (normal distribution)
    # we get 2 samples from a normal distribution N(0,1)
    Ka, Kb = np.random.normal(0, 1, 2)
    # compute the difference between Ks
    diff = Ka-Kb
    # apply difference of Ks to attractiveness
    Ta += diff
    Tb -= diff
    return Ta, Tb

def attractiveness3(Ta, Tb):
    #  anti-conformism dynamics (more population means less attractiveness)

    # both values initialized at 0
    Ka = 0
    Kb = 0

    # first we sample gamma with mean=last popSize of A times relevance    
    diffPop = np.random.gamma(believersA[t])
    # we sustract from this value the same computation for population B
    diffPop = diffPop - np.random.gamma(believersB[t])

    # if B is larger then we need to increase the attractiveness of A
    if diffPop < 0:
        Ka = -diffPop
    # else A is larger and we need to increase the attractiveness of B
    else:
        Kb = diffPop

    # change current values
    Ta = Ta + Ka
    Tb = Tb + Kb

    return Ta, Tb
```

###  temporal autocorrelation with stochasticity (normal distribution)



```python
# initialisation
MAX_TIME = 100
t = 0               # initial time
N = 100           # population size
A = 65              # initial proportion of believers A
B = N-A             # initial proportion of believers B

Ta = 1.0            # initial attractiveness of option A
Tb = 2.0            # initial attractiveness of option B
alpha = 0.1         # strength of the transmission process

# initialise the list used for plotting
believersA = []    
believersB = []

# add the initial populations
believersA.append(A)
believersB.append(B)
```


```python
while t < MAX_TIME:
    # update attractiveness
    Ta, Tb = attractiveness2(Ta, Tb)
    # calculate the payoff for change of believers A and B in the current time step           
    variationBA = payoff(A, Ta, Tb)      
    variationAB = payoff(B, Tb, Ta)     
    difference = variationBA - variationAB

        # B -> A   
    if difference > 0:
        variation = difference*B
    # A -> B        
    else:
        variation = difference*A

    # control the pace of change with alpha
    variation = alpha*variation  

    # update the population    
    A = A + variation
    B = B - variation   

    # save the values to a list for plotting    
    believersA.append(A)
    believersB.append(B)

    # advance time to next iteration
    t = t + 1
```


```python
# plot the results    
plt.plot(believersA, label = 'A')
plt.plot(believersB, label = 'B')
plt.xlabel('$Time$', fontsize = 20)
plt.ylabel('$Number$', fontsize = 20)
plt.legend(loc = 0)
plt.show()
```


![social simulation 4](http://oaf2qt3yk.bkt.clouddn.com/e85d25a5ffcccde3f7f1db1e531bfc9b.png)

### anti-conformism dynamics (more population means less attractiveness)


```python
# initialisation
MAX_TIME = 100
t = 0               # initial time
N = 100           # population size
A = 65              # initial proportion of believers A
B = N-A             # initial proportion of believers B

Ta = 1.0            # initial attractiveness of option A
Tb = 2.0            # initial attractiveness of option B
alpha = 0.1         # strength of the transmission process

# initialise the list used for plotting
believersA = []    
believersB = []

# add the initial populations
believersA.append(A)
believersB.append(B)
```


```python
while t < MAX_TIME:
    # update attractiveness
    Ta, Tb = attractiveness3(Ta, Tb)
    # calculate the payoff for change of believers A and B in the current time step           
    variationBA = payoff(A, Ta, Tb)      
    variationAB = payoff(B, Tb, Ta)     
    difference = variationBA - variationAB

        # B -> A   
    if difference > 0:
        variation = difference*B
    # A -> B        
    else:
        variation = difference*A

    # control the pace of change with alpha
    variation = alpha*variation  

    # update the population    
    A = A + variation
    B = B - variation   

    # save the values to a list for plotting    
    believersA.append(A)
    believersB.append(B)

    # advance time to next iteration
    t = t + 1
```


```python
# plot the results    
plt.plot(believersA, label = 'A')
plt.plot(believersB, label = 'B')
plt.xlabel('$Time$', fontsize = 20)
plt.ylabel('$Number$', fontsize = 20)
plt.legend(loc = 0)
plt.show()
```


![social simulation 4](http://oaf2qt3yk.bkt.clouddn.com/460f04a96f3f350e29a98933e0470662.png)
