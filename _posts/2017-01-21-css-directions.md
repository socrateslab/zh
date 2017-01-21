---
layout: single
title: "Computational Social Science: Exciting Progress and Future Directions"
header:
  teaser: "/assets/images/unsplash-gallery-image-1-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-29.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "In spite of many thousands of published papers, there’s been surprisingly little progress on the “big” questions that motivated the field of computational social science."
modified: 2017-01-21 19:49:48
comments: true
author: "Duncan J. Watts"
tags:
  - social science
  - Watts
categories:
  - 计算社会科学
---

{% include toc title="Table" icon="file-text" %}


Duncan J. Watts. (2013) Computational Social Science: Exciting Progress and Future Directions. The Bridge on Frontiers of Engineering 43:4 [^watts2017]

[^watts2017]: Duncan J. Watts. (2013) Computational Social Science: Exciting Progress and Future Directions. The Bridge on Frontiers of Engineering 43:4


The past 15 years have witnessed a remarkable increase in both the scale and scope of social and behavioral data available to researchers. Over the same period, and driven by the same explosion in data, the study of social phenomena has increasingly become the province of computer scientists, physicists, and other “hard” scientists. Papers on social networks and related topics appear routinely in top science journals and computer science conferences; network science research centers and institutes are sprouting up at top universities; and funding agencies from DARPA to NSF have moved quickly to embrace what is being called `computational social science`.

Against these exciting developments stands a stubborn fact: in spite of many thousands of published papers, there’s been surprisingly little progress on the “big” questions that motivated the field of computational social science—questions concerning systemic risk in financial systems, problem solving in complex organizations, and the dynamics of epidemics or social movements, among others.
{: .notice--warning}

Of the many reasons for this state of affairs, I concentrate here on three. First, social science problems are almost always more difficult than they seem. Second, the data required to address many problems of interest to social scientists remain difficult to assemble. And third, thorough exploration of complex social problems often requires the complementary application of multiple research traditions—statistical modeling and simulation, social and economic theory, lab experiments, surveys, ethnographic fieldwork, historical or archival research, and practical experience—many of which will be unfamiliar to any one researcher. In addition to explaining the particulars of these challenges, I sketch out some ideas for addressing them.

## Why Is Social Science Hard?

By definition, “social” phenomena are less about the behavior of individuals than of collections of individuals in groups, crowds, organizations, markets, classes, and even entire societies, all of which interact with each other via networks of information and influence, which in turn change over time. As a result, social systems—like complex systems in physics and biology—exhibit “emergent” behavior, meaning that the behavior of entities at one “scale” of reality is not easily traced to the properties of the entities at the scale below (Anderson 1972). Firms, for example, can exhibit highly stable identities and cultures even as the particular employees who work in them change completely over time, just as you remain you even as the cells in your body turn over during the course of your lifetime. Conversely, the stock market, the economy, or a political regime can collapse suddenly and unexpectedly even as the various players and background conditions remain the same.

Complicating matters further, emergent properties can be both the cause and the effect of social change. Sometimes, that is, the decisions of corporations or even governments may depend critically on the personal interests of a handful of executives, whereas at other times the behavior of those same individuals may be powerfully constrained by the corporate or political culture to which they belong.

Nor is `emergence` as simple as one scale of reality aggregating to another. Rather, in many problems of interest to social scientists, the actions of individuals, firms, regulatory and government agencies, markets, and political institutions may all play important roles. Moreover, because these different types of actors not only exist at different scales (firms comprise individuals, markets comprise firms and individuals, etc.) but also may interact with each other in important ways, problems of this type require one to consider events, actors, and forces across multiple scales simultaneously.

Given the unavoidably multiscale, complex, and emergent nature of social phenomena, it is not surprising that theories of social behavior and change have been difficult to work out in any realistic detail. Compounding this theoretical difficulty are two separate but related empirical difficulties. First, it has been impossible to collect observational data on the scale of hundreds of millions, or even tens of thousands, of individuals. Second, because cause and effect can be difficult to infer from observational data alone, experimental studies are also necessary. Yet experiments involving, say, the performance of an organization with a particular structure, or the popularity of songs in a single instance of a cultural market, represent the collective behavior of hundreds or even thousands of individuals, designs that are clearly impossible to implement in a physical lab (Zelditch 1969).

## The Emergence of Computational Social Science

In light of these three interrelated difficulties—(1) the complexity of the theoretical issues confronting social science, (2) the difficulty of obtaining the relevant observational data, and (3) the difficulty of manipulating large-scale social organizations experimentally—it is hardly surprising that progress in social science has been slow relative to that in the physical, engineering, and biological sciences, in particular over the past century. But the computing revolution of the past two decades—a revolution that has dramatically increased not only the speed and memory of computers themselves but also the scale and scope of social data that can now be analyzed—has the potential to revolutionize traditional social science, leading arguably to a new paradigm of “computational social science”1 (Lazer et al. 2009).

The most prominent strand of research in computational social science leverages communication technologies—including email, social networking and microblogging services, and cellphones—as well as online games, ecommerce sites, and other Internet-enabled services. All of these devices and services generate digital signals, often referred to as digital exhaust or digital breadcrumbs, from which inferences can be made about individual and/or collective behavior. In this way, it is increasingly possible to observe the actions and interactions of hundreds of millions of individuals in real time as well as over time.

Data derived from instant messaging services and social networking sites, for example, have been used to construct networks of hundreds of millions of nodes, analysis of which (Leskovec and Horvitz 2008; Ugander et al. 2011) has confirmed earlier conjectures about the topology of large social networks (Newman 2003; Watts and Strogatz 1998). Other studies have mined email data to estimate the microlevel rules describing new tie formation (Kossinets and Watts 2006) or used blog networks to measure the propensity to join new groups (Backstrom et al. 2006). Others still have mapped the diffusion of online content (Bakshy et al. 2009; Dow et al. 2013; Goel et al. 2012; Leskovec et al. 2007; Sun et al. 2009) or conducted massive randomized field experiments to estimate the causal effects of social influence on adoption (Aral and Walker 2011), voter turnout (Bond et al. 2012), or likelihood to share content (Bakshy et al. 2012).

A less well explored but also important strand of research uses the web to create “virtual labs”: controlled environments for the conduct of “macrosociological” experiments (Hedstrom 2006). Although early efforts relied on volunteers (Dodds et al. 2003; Salganik et al. 2006), an important recent development in this field has been the use of crowdsourcing sites such as Amazon’s Mechanical Turk to recruit and pay subjects, analogous to the longstanding tradition in behavioral science of recruiting from college student populations (Mason and Watts 2009).

One important advance due to crowdsourced virtual labs has been resolution of the synchronicity problem to ensure that N subjects will arrive contemporaneously and remain engaged in the experiment for its duration (Suri and Watts 2011), thereby allowing for networked experimental designs. Another advantage is that experiments can be designed, launched, and executed on a much shorter timescale than has been historically feasible, and on a lower cost basis (Wang et al. 2012). Finally, by shrinking the hypothesis-testing cycle—the lag between analyzing one set of experimental results and running the next set of experiments—from months or years to days or even hours, crowdsourced virtual lab experiments can dramatically expand the range of conditions that can be studied.

## Challenges and Opportunities for Computational Social Science

As impressive as its recent accomplishments have been, computational social science faces a number of pressing challenges if it is to address the important questions of social science in a meaningful way. For example, organizational and interorganizational problem solving, collective action and decision making, the relationship between deliberation, governance, and democracy, the emergence of disruptive technologies, and the rise of new political or cultural movements are all core social scientific questions, but they have received little attention from computational social science largely on the grounds of limits to current data sources, platforms, or methods. In the following sections I describe three challenges and suggest some directions for future progress.

### Creating a Social Supercollider

First, the dominant digital exhaust model of data collection imposes important limitations on the type of research questions that can be answered.

Consider, for example, the problem of measuring how friends influence each other’s purchase behavior, a question that is of great interest to social scientists as well as to marketers, policymakers, and other change agents. Answering such a question requires the ability to observe both the complete friendship network (already a difficult task) and the shopping behavior of everyone in the network. Using existing systems, one might obtain an approximation of the friendship network by using, say, Facebook data or mining email logs, while ecommerce sites or retailer databases may show how much individuals are spending on particular products. Currently, however, it is extremely difficult to combine even two such sources of data, and of course there are many different modes of communication and many different places to make purchases.

Generalizing beyond this one example, many questions of interest to social scientists require studying the relation between different modes of social action and interaction—for example, search data to infer intent, network data to infer relationships, ecommerce data to infer choices, and social media data to infer opinions—but these modes are generally recorded and stored separately, often by different companies. A major breakthrough for computational social science, therefore, would be a “social supercollider”: a facility that combines multiple streams of data, creating richer and more realistic portraits of individual behavior and identity, while retaining the benefits of massive scale.

Against this considerable promise stands the equally pressing concern of protecting individual privacy. Privacy is already an important issue for all industries that collect digital information about their consumers; however, for the same reason that the social supercollider would be so powerful a scientific tool—namely that it would put all the pieces together—it raises far more serious questions about individual privacy even than are posed by existing commercial platforms. These questions have in fact already been raised by recent revelations of the National Security Agency’s Prism project, which also appears to be an attempt to combine data from multiple sources. Construction and management of anything like a social supercollider would therefore have to proceed under the strictest scrutiny, with respect to both governance and the end uses of the data.

### Expanding Virtual Labs

A second challenge for computational social science concerns the continued development of experimental macrosociology. Perhaps surprisingly, the major limitation to existing experimental designs is not technical but rather logistical—namely, the difficulty of recruiting large numbers of subjects in a reliable and cost-effective manner. For example, the largest synchronous virtual lab experiments to date have not exceeded N=36, largely because of the practical difficulty of recruiting more than that number at any single time.

One potential solution to this problem would be to construct a large, persistent, and well-documented panel of subjects—potentially hundreds of thousands of individuals—who might participate in many experiments over months or years. Increasing the scale of experiments from dozens to thousands of simultaneous participants would fundamentally alter the types of experiments that could be run—making it possible to, for example, study the proverbial army in a lab (Zelditch 1969). By allowing researchers to specify their sampling frame in advance, another advantage of a large persistent subject set would be to facilitate investigations of variation in behavior by demographic, national, or racial group.

Such a panel would also enable the study of entirely novel questions about the connections between individual attributes and behavior as well as between different elements of behavior itself. Do people who contribute generously to public goods games behave in any characteristic way when participating in a collaborative problem-solving exercise or in an exchange network?

Finally, beyond virtual lab experiments, a panel of this scale and duration could be of great value for survey research and randomized field experiments.

### Putting the “Social” in Computational Social Science

A final challenge for computational social science is that, in spite of many thousands of papers published on topics related to social networks, financial crises, crowdsourcing, influence and adoption, group formation, and so on, relatively few are published in traditional social science journals or even attempt to engage seriously with social scientific literature. The result is that much of computational social science has effectively evolved in isolation from the rest of social science, largely ignoring much of what social scientists have to say about the same topics, and largely being ignored by them in return.

It is unclear who is to blame for this state of affairs—computer scientists for being presumptuous, social scientists for being defensive, or both—and even whether it is a bad thing. Perhaps all interdisciplinary fields start out as ugly ducklings and have to become swans on their own, not by making friends with existing fields but by outcompeting them. My view, however, is that meaningful progress on important problems will require serious engagement between the communities, each of which has much to offer the other: computer scientists have technical capabilities that are of great potential benefit to social scientists, and  the latter’s deep subject matter knowledge is essential in order to ask the right questions and to formulate even simple models in ways that address these questions.

### New Institutions for Computational Social Science

Unfortunately, harnessing the complementary strengths of multiple research communities is easier said than done. Consider, for example, the problem of managing systemic risk in financial systems. On the one hand, simple and elegant models of financial crises that are inspired by the analogy of contagion in networks (Delli Gatti et al. 2012; Gai and Kapadia 2010; May and Arinaminpathy 2010; Nier et al. 2007) turn out to omit certain features of real banking systems—for example, that banks “create” money by expanding their balance sheets or that prices must adjust so that markets will clear—that are critical to understanding recent crises. On the other hand, descriptively accurate accounts of real financial crises tend to be so complex and multifaceted (Brunnermeier 2009; Financial Crisis Inquiry Commission 2011; Gorton 2012; Hellwig 2009) that it is difficult even for experts to agree on which mechanisms are the most important and therefore what features are critical to include in even a simple model.

The existence of diverse and even incommensurate literatures on the same topic is a surprisingly common problem in social science, and resolving it requires substantial investment in time as well as considerable diversity of expertise. As no one individual is likely to satisfy this requirement, interdisciplinary teams of researchers who have both the resources and the incentives to engage in long-term, high-risk collaborations seem increasingly necessary. Such collaborations are also challenging, however, in light of the cultural and language differences that separate disciplines like computer science from the social sciences, as well the wide variations in publication norms and timescales. Finally, to be successful computational and experimental research designs must be coordinated with methods drawn from the theoretical, survey, and ethnographic traditions of social science.

Deep and significant progress in social science, in other words, will require not only new data and methods but also new institutions that are designed from the ground up to foster long-term, large-scale, multidisciplinary, multimethod, problem-oriented social science research. To succeed, such an institution will require substantial investment, on a par with existing institutes for mind, brain, and behavior, genomics, or cancer, as well as the active cooperation of industry and government partners.

The current and justifiable excitement surrounding computational social science presents an opportune moment to engage in such an undertaking.

## Conclusion

Driven by new sources of data, ever-increasing computing power, and the interest of computer scientists, social science is becoming a computational discipline much as biology did in the late 1990s. As exciting and important as this development is, however, social science is not and should not become a subfield of computer science or “data science.” Just as in computational biology, the computational element of computational social science should remain in service to the substantive and substantial questions of social science.

Achieving this goal will require significant investments in new sources of data, new platforms for organizing existing data, and new institutional arrangements for fostering team-based interdisciplinary research. Although somewhat novel for social science, which has long operated on the model of the single-authored book or paper, the research lab model is familiar from the biological and medical sciences, and with the appropriate commitment could revolutionize social science in the 21st century.

## References

Anderson PW. 1972. More is different. Science 177:393–396.

Aral S, Walker D. 2011. Creating social contagion through viral product design: A randomized trial of peer influence in networks. Management Science 57(9):1623–1639.

Backstrom L, Huttenlocher D, Kleinberg J, Lan X. 2006. Group formation in large social networks: Membership, growth, and evolution. In: Proceedings of the 12th ACM SIGKDD International Conference on Knowledge Discovery and Data Mining, Philadelphia. p 44–54.

Bakshy E, Karrer B, Adamic LA. 2009. Social influence and the diffusion of user-created content. In: Proceedings of the 10th ACM Conference on Electronic Commerce, Association of Computing Machinery, Stanford, California.

Bakshy E, Rosenn I, Marlow C, Adamic L. 2012. The role of social networks in information diffusion. In Proceedings of the 21st International ACM Conference on World Wide Web, Lyon, France. p 519–528.

Bond RM, Fariss CJ, Jones JJ, Kramer AD, Marlow C, Settle JE, Fowler JH. 2012. A 61-million-person experiment in social influence and political mobilization. Nature 489:295–298.

Brunnermeier MK. 2009. Deciphering the liquidity and credit crunch 2007-2008. Journal of Economic Perspectives 23:77–100.

Delli Gatti D, Gallegati M, Greenwald B, Stiglitz J, Battiston S. 2012. Liaisons dangereuses: Increasing connectivity, risk sharing and systemic risk. Journal of Economic Dynamics and Control 36:1121–1141.

Dodds PS, Muhamad R, Watts DJ. 2003. An experimental study of search in global social networks. Science 301:827–829.

Dow PA, Adamic LA, Friggeri A. 2013. The anatomy of large Facebook cascades. In Proceedings of the Seventh International AAAI Conference on Weblogs and Social Media, Cambridge, MA.

Financial Crisis Inquiry Commission. 2011. Financial Crisis Inquiry Report: Final Report of the National Commission on the Causes of the Financial and Economic Crisis in the United States. Washington: Government Printing Office.

Gai P, Kapadia S. 2010. Contagion in financial networks. Proceedings of the Royal Society A: Mathematical, Physical and Engineering Science 466:2401–2423.

Goel S, Watts DJ, Goldstein DG. 2012. The structure of online diffusion networks. In Proceedings of the 13th ACM Conference on Electronic Commerce, Valencia, Spain. p 623–638.

Gorton GB. 2012. Misunderstanding Financial Crises: Why We Don’t See Them Coming. New York: Oxford University Press.

Hedstrom P. 2006. Experimental macro sociology: Predicting the next best seller. Science 311(5762):786–787.

Hellwig MF. 2009. Systemic risk in the financial sector: An analysis of the subprime-mortgage financial crisis. De Economist 157:129–207.

Kossinets G, Watts DJ. 2006. Empirical analysis of an evolving social network. Science 311:88–90.

Lazer D, Pentland A, Adamic L, Aral S, Barabasi AL, Brewer D, Christakis N, Contractor N, Fowler J, Gutmann M. 2009. Computational social science. Science 323(5915):721–723.

Leskovec J, Adamic LA, Huberman BA. 2007. The dynamics of viral marketing. ACM Transactions on the Web 1(1):1–46.

Leskovec J, Horvitz E. 2008. Planetary-scale views on a large instant-messaging network. In Proceedings of the 17th International World Wide Web Conference, Beijing, China.

Mason W, Watts DJ. 2009. Financial incentives and the performance of crowds. Proceedings of the ACM SIGKDD Workshop on Human Computation, Paris. p 77–85.

May RM, Arinaminpathy N. 2010. Systemic risk: The dynamics of model banking systems. Journal of the Royal Society Interface 7:823–838.

Newman MEJ. 2003. The structure and function of complex networks. SIAM Review 45:167–256.

Nier E, Yang J, Yorulmazer T, Alentorn A. 2007. Network models and financial stability. Journal of Economic Dynamics and Control 31:2033–2060.

Salganik MJ, Dodds PS, Watts DJ. 2006. Experimental study of inequality and unpredictability in an artificial cultural market. Science 311:854–856.

Sun ES, Rosenn I, Marlow CA, Lento TM. 2009. Gesundheit! Modeling contagion through Facebook news feed. In International Conference on Weblogs and Social Media, AAAI, San Jose.

Suri S, Watts DJ. 2011. Cooperation and contagion in web-based, networked public goods experiments. PLoS One 6(3):e16836.

Ugander J, Karrer B, Backstrom L, Marlow C. 2011. The anatomy of the Facebook social graph. arXiv 1111.4503.

Wang J, Suri S, Watts DJ. 2012. Cooperation and assortativity with dynamic partner updating supporting information. Proceedings of the National Academy of Sciences U S A 109(36):14363–14368.

Watts DJ, Strogatz SH. 1998. Collective dynamics of “small-world” networks. Nature 393:440–442.

Zelditch M. 1969. Can you really study an army in the laboratory? In: Etzioni A, ed. A Sociological Reader on Complex Organizations. Boston: Holt, Rinehart and Winston. p 528–539.


### FOOTNOTES

1 “Computational social science” is a contested label, referring in some quarters to simulation of agent-based models (see, for example, http://computationalsocialscience.org/) and in others strictly to the analysis of computationally challenging datasets (http://research.microsoft.com/en-us/groups/cssnyc/). Here I use the term somewhat liberally to refer to the emerging intersection of the social and computational sciences, an intersection that includes analysis of web-scale observational data, virtual lab–style experiments, and computational modeling.

About the Author: Duncan J. Watts is a principal researcher at Microsoft Research.
