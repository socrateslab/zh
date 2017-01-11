---
layout: single
title: "Should social science be more solution-oriented?"
header:
  teaser: "/assets/images/unsplash-gallery-image-1-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-14.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "I argue that one way for social science to make progress is to adopt a more solution-oriented approach, starting first with a practical problem and then asking what theories (and methods) must be brought to bear to solve it."
modified: 2017-01-11 19:49:48
comments: true
author: "Duncan J. Watts"
tags:
  - social science
  - Watts
categories:
  - 计算社会科学
---

{% include toc title="Table" icon="file-text" %}


Duncan J. Watts. Should social science be more solution-oriented? Nature Human Behaviour. 1, 0015 (2017) doi:10.1038/s41562-016-0015[^watts2017]

[^watts2017]: Duncan J. Watts Should social science be more solution-oriented? Nature Human Behaviour. 1, 0015 (2017) doi:10.1038/s41562-016-0015

Over the past 100 years, social science has generated a tremendous number of theories on the topics of individual and collective human behaviour. However, it has been much less successful at reconciling the innumerable inconsistencies and contradictions among these competing explanations, a situation that has not been resolved by recent advances in ‘computational social science’. In this Perspective, I argue that this ‘incoherency problem’ has been perpetuated by an historical emphasis in social science on the advancement of theories over the solution of practical problems. I argue that one way for social science to make progress is to adopt a more solution-oriented approach, starting first with a practical problem and then asking what theories (and methods) must be brought to bear to solve it. Finally, I conclude with a few suggestions regarding the sort of problems on which progress might be made and how we might organize ourselves to solve them.

As a sociologist who spends a lot of time in the company of physicists, computer scientists and other outsiders to my field, I am often asked a question of the sort: “What is the social science perspective on X?”, where X is some topic of interest. To a social scientist, the question sounds hopelessly naïve: for any topic X, social science has dozens, if not hundreds, of perspectives, but no single perspective on which there is anything close to universal agreement. Nevertheless, I would argue that it is worth taking the question seriously, if only because it highlights an important difference between the social and physical/engineering sciences.

Physicists disagree of course — for example, about the best way to reconcile general relativity with quantum mechanics, or the best explanation for the ‘missing mass’ problem in cosmology — but overall there is tremendous agreement both on what physicists know about the universe (Newtonian mechanics, thermodynamics, electromagnetism, optics, special and general relativity, statistical mechanics, physics and so on) and where the remaining areas of uncertainty lie. By contrast, any representative cross-section of social scientists would have difficulty agreeing on almost any question at all, including which questions were the most important to be agreed upon. It could be argued that in economics there exist certain specialized subfields, such as mechanism design applied to auctions1,2 and matching markets3,4, that comprise cumulative bodies of self-consistent, empirically validated theory that have even proven useful in practice. But no such claims can be sustained for economics in general, let alone for problems of interest to the social sciences broadly.

Comparing the social sciences unfavourably to physics is of course a game with a long and, I would argue, quite unproductive history5. However, my thesis differs from the usual critique that social science should strive to be more like physics by identifying general principles. I shall argue that the problem with social science is not so much that it has one theory for one thing and another theory for another thing6, but rather that it has many theories for the very same thing. Even worse, these theories — although often interesting and plausible when considered individually — are fundamentally incoherent when viewed collectively. I then argue that this incoherency problem arises not only because of a lack of appropriate data for evaluating social scientific theories, but also because of the institutional and cultural orientation of social-science disciplines, which have historically emphasized the advancement of particular theories over the solution of practical problems. Finally, I argue that one possible solution to the incoherency problem is to reject the traditional distinction between basic and applied science, and instead seek to advance theory specifically in the service of solving real-world problems.

Before proceeding, however, let me clarify two points of possible confusion. First, I am not arguing that all, or even most, of social science should become solution-oriented. Social science can serve many purposes — for example, the field can challenge common-sense assumptions about the nature of social reality7,8,9, provide rich descriptions of lived experience10,11,12, inspire new ways of thinking about human behaviour13,14 and shed light on specific empirical puzzles15,16 — that do not directly address practical problems but can still provide valuable insight. My argument is not that social scientists should stop pursuing these other objectives in favour of solving practical problems; only that collectively we should pay more attention than we do to the latter. Second, I am also not suggesting that social scientists do not already devote themselves to solving practical problems: many do, especially in policy-relevant areas like education17, health care18, poverty19 and government20. Rather, what I am suggesting is that social scientists can profitably view the solution of practical problems as a mechanism for improving the coherency of social science itself.

## The incoherency problem in social science
To illustrate the problem, consider the topic of social contagion and collective behaviour. Reading around on this topic, it is highly likely that one will stumble upon one or both of the following papers: first, Mark Granovetter's 1978 paper ‘Threshold models of collective behavior’21 published in the prestigious American Journal of Sociology; and second, ‘A theory of fads, fashion, custom, and cultural change as informational cascades’22 published in 1992 by Bikhchandani, Hirshleifer and Welch in the equally prestigious Journal of Political Economy. These two papers are similar in many respects. Both propose simple yet plausible theoretical models of individual decision-making in the presence of social influence. Both motivate their respective models with a similar list of empirical examples, including fads, riots, financial crises and other puzzling collective social phenomena. Both seek to explain the same stylized feature of these phenomena, namely that small changes or ‘shocks’ to an apparently stable system can lead to large changes in collective behaviour. Finally, both have been enormously influential, each having been cited thousands of times.

Given these similarities in empirical motivation, theoretical objectives and subsequent impact, it might come as a surprise that the actual models proposed in the two papers are not just different, but are logically incompatible in the sense that each makes assumptions that, if true, would render the other false23. One might expect that such an obvious point of theoretical disagreement as this would immediately prompt calls for greater clarification, if not an empirical test. And yet, in more than 20 years of coexistence, not only has the discrepancy not been resolved, it has scarcely been noticed. Even worse, these two models are not the only examples of ostensibly similar models that turn out to be hard to reconcile: other examples include the SIR model adapted by Bass24 from mathematical epidemiology25, the Independent Cascade Model26 adapted from the theory of cellular automata, hazard rate models27 adapted from statistics, and models of pluralistic ignorance28 adapted from psychology. Nor is diffusion research the only topic in social science in which one can find a proliferation of irreconcilable theories. Indeed, for any topic on which I have undertaken a significant amount of reading — collective action, cooperation, organizational performance, network dynamics, systemic risk in financial systems, even individual decision-making — it is easy to find dozens of papers spanning sociology, economics and psychology, each of which is interesting in its own right, but that have little in common collectively other than the words in the title.

## More data is not the answer
What accounts for this state of affairs and what, if anything, can be done about it? One popular conjecture is that historically social science has not had access to the right kind of data29,30. Social phenomena, the argument goes, are inherently emergent properties of complex, multi-scale networked systems. Simply observing networks and behaviour at multiple scales over extended intervals of time is therefore already an extraordinary undertaking, while establishing cause and effect through ‘macro’ social experiments is even more difficult, and often impossible. In other words, one possible reason why social science seems less ‘scientific’ than we would like is simply that our ability to propose theories has for so long outstripped our ability to test them.

If this were the whole of the problem, then the era of ‘big data’ should be the solution. For the first time in history, the digital traces of ordinary everyday interactions — sending e-mails, checking social media, buying goods and services online, consuming content, expressing opinions — in principle allow us to observe individual-level behaviour and interactions on a large scale and over extended periods of time. At the same time, we can also conduct experiments on greater scales and with increasing complexity, whether in ‘virtual labs’31,​32,​33 or in online ‘field’ settings34,35. Combined with increasingly powerful computer simulations, the greater availability of high-resolution, large-scale data and naturalistic, large-scale experiments would surely herald a revolution in traditional social science, much as previous breakthroughs in instrumentation — for example, the telescope, the microscope, X-ray crystallography and the synchrotron — revolutionized the physical and biological sciences.

To some extent this hope has been realized: among the countless papers that exploit digital data and experiments, there are many that are very good and some that establish genuinely new and interesting ideas. Some even explicitly set out to test existing theories against novel data with the goal of deciding among competing explanations or simply placing limits on what we can hope to explain. All of this work represents exciting progress. And yet, ten years into the era of what is now called computational social science, it seems to me that more data, and even better data, is not enough. Nor has the influx of physicists and computer scientists into the social sciences over the past two decades clearly ameliorated the coherency problem. Far from the social sciences acquiring a coherent physics-inspired core of empirically validated theoretical knowledge, they have instead acquired a whole new batch of physics-inspired models that have, if anything, added to the confusion.

## What is the purpose of social science?
Jerry Davis, the then editor of Administrative Science Quarterly, recently raised a similar concern about the state of organizational science. In a provocative essay36 he likened his chosen field to the Winchester Mystery House, a sprawling mansion in San Jose, California that was constructed in the late nineteenth and early twentieth centuries by Sarah Winchester, heiress to the Winchester rifle fortune. According to the story, Winchester was inspired by a psychic to build a house in order to accommodate the souls of those killed by her company's rifles. Because the dream didn't specify any particular plan for the house, however, she embarked on an open-ended construction project in which hundreds of rooms, stairwells and other elements of a normal house were added over nearly 40 years of continuous construction with no overall objective other than to keep building. The result was an agglomeration of components, each of which was individually well-constructed, but that did not cohere into any sort of functional whole: stairways ran directly into walls, doors did not open, stained glass windows were installed in interior rooms with no light exposure, and so on. In Davis's view, organizational science has the same problem: although each individual contribution must comply with strict disciplinary standards, no attention is paid to how all the contributions fit together; as a consequence, they do not.

Davis was writing specifically about research on organizations, but I think the mystery-house metaphor applies to social science in general, and for much the same reason: Although our work is ostensibly motivated by a desire to understand, explain and possibly intervene in real-world social phenomena, neither the training nor the structure of incentives in academia are specifically designed for this purpose. Rather, social scientists — and, more recently, physicists and computer scientists — are raised inside disciplinary environments where they are immersed in particular theoretical and methodological frameworks. They are then encouraged to take the framework they have absorbed — whether it is critical analysis, rational action, new institutionalism, statistical mechanics or instrumental variables — and apply it to every problem they work on. Finally, they are rewarded for publishing their work, typically in peer-reviewed journals and conference proceedings, most of which value novel, counterintuitive or otherwise interesting results over steady cumulative advances in knowledge. Critically, while the peer review system places great importance on acknowledging the relevant literature, what is considered relevant generally falls within a single discipline, and acknowledgment amounts to little more than citing prior work. In other words, at no point does the existing system for producing social scientific knowledge either facilitate or reward the activity of reconciling disparate frameworks37. As a result, facts and theories pile up in an incoherent heap, much like the multitude of rooms and stairwells piling up in Sarah Winchester's house.

And yet, a sceptic may ask, what is wrong with trying to advance theory? Physicists rely on much the same academic publishing system as social scientists, and in physics a great deal of progress has been made by taking a particular theory and pushing it to see how far it will go. Why should the same approach not work in social science? One answer is that physics has simply been around for much longer; as Merton5 put it, “between twentieth-century physics and twentieth-century sociology stand billions of man-hours of sustained, disciplined, and cumulative research.” But another answer is that theories in physics are testable in a way that social-science theories are not. If one has a theory of projectile motion, for example, one can build an apparatus to test it, and the results will be relatively unequivocal: if the projectile does not go where the theory says it is supposed to go then the theory is probably wrong and needs revisiting. In the social sciences, by contrast, unequivocal tests of theories are much harder to design and implement; thus predictions in the social sciences, if they they are made at all, tend to come with considerable wiggle room38. Yet, a third answer is that even when such tests could be designed in principle, conducting them in practice would require a larger investment of resources than anyone is willing to make8.

Combined, the effect of these differences is that theories in social science tend to rise and fall in popularity more like works of fiction than of science, gaining support for reasons other than their ability to account for empirical observations. Thus, economists cite Bikhchandani et al. more than Granovetter not because the former is a better model of collective behaviour than the latter — it may or may not be —but perhaps because the model itself fits more easily into economists’ pre-existing theoretical frameworks, or because the writing style is more familiar to them, or simply because it was published in an economics journal rather than in sociology. Marketers love ‘influencers’ not because there exists a sustained body of empirical evidence that supports using influencers to promote one's products or ideas over any other obvious marketing method, but perhaps because Malcolm Gladwell wrote a fun and interesting book about them that became a phenomenal bestseller39. And police departments around the country embraced the ‘broken windows’ theory of crime not because the theory itself was ever empirically validated40, but perhaps because the aggressive policing practices that it inspired happened to be implemented during a time when crime plummeted for a variety of reasons41. In all of these cases it would have been possible in principle to systematically test the dominant theory against its natural competitors. And yet, in spite of the considerable time, energy, and in some cases money and lives, that favoured theories can consume, evaluations of this sort are extremely rare.

## Solution-oriented social science
So, what can be done? One proposal that has received considerable attention lately is for social science to place more emphasis on replicability than on novelty, surprise or even importance. The rationale is that if a claim is not replicable then it is not true, and hence not science, no matter how novel or interesting it might be42,​43,​44. Almost certainly, more emphasis on replication would reduce the rate of published claims that turn out to be false (or simply unfalsifiable), and for this reason alone the change would be welcome. But it would not necessarily help to reconcile competing claims, especially when they arise in different disciplines. Another possibility, therefore, is for social science to place more emphasis on solving practical problems of the sort that outsiders would recognize — for example, “How do I maximize the impact of my advertising spending?” or “How do I increase productivity in my organization?” or “How do I increase pro-social behaviour in my community?”

Shifting the mode of scientific production from published papers to solved problems would have several advantages for generating novel and useful research. First, the requirement that solutions work in the real world would automatically satisfy replicability requirements, thereby disciplining social-scientific theorizing in ways that would augment the existing peer review system. Second, solving any nontrivial real-world problem would almost certainly require fundamental advances in social-behavioural science, and possibly also in related fields such as computer science and statistics. Third, realizing these advances would require tightly coordinated, multidisciplinary team-based research of the sort that is common in industry but largely absent in academic social science. Fourth, constructing teams of this sort would bring the incoherency problem to the forefront and force researchers to address it directly. Finally, the emphasis on practical applications would help justify larger upfront investments than are typical for social-science research, thereby enabling more ambitious research designs.

To reiterate, it is of course true that social scientists already engage in the practical problems of business and government, sometimes directly as advisors or consultants, and at other times indirectly, as when their technical work becomes known to a general audience via media coverage or trade publications. How would this model of solution-oriented social science differ from these existing activities, or indeed from the much larger community of consultants, advertising and branding agencies, human-resources firms, political advisors, and polling and market research companies, all of which engage in what might be viewed as applied social science?

The answer is that whereas conventional applied work is almost wholly concerned with real-world impact, solution-oriented social science would be equally concerned with impacting social science itself. In other words, solution-oriented social science rejects the ‘linear’ model of research advanced by Vannevar Bush45, in which basic science provides the ‘feedstock’ of knowledge on which applied science is then assumed to draw. Importantly, in Bush's model, basic and applied science are distinct activities, where the former is defined by its pursuit of fundamental knowledge without regard for practical applications and the latter is defined oppositely. By contrast, solution-oriented social science embraces both simultaneously, treating them not as substitutes where one necessarily drives out the other, but rather as complements. In other words, solution-oriented social science falls into what Stokes46 called Pasteur's quadrant — defined as use-inspired research that advances fundamental understanding — as distinct from what he called Bohr's quadrant (traditional basic research) and Edison's quadrant (traditional applied research).

But although it is easy to think of research in physics, medical science and engineering that fall in Pasteur's quadrant47,48 — for example, the Manhattan project, the Defense Advanced Research Projects Agency (DARPA)'s grand challenges in driverless vehicles and robotics, the Netflix Prize, cancer research and so on — it is much harder to think of examples in the social sciences. Stokes, who was himself a social scientist, offered only two: Keynesian economics, which was motivated in part by Keynes’ desire to alleviate the societal impact of economic recessions; and modern demography, motivated by policy problems arising from population change. Other possible examples include Katz and Lazarsfeld's seminal work on personal influence49, which was also an early example of applied market research, and Coleman's work on educational equality50, which was conducted in response to a direct policy need. And, as noted earlier, work on auctions1,2 and matching markets3,4 have solved practical problems while also producing Nobel prizes for their originators. Nevertheless, the vast majority of academic social-science research continues to be conducted in isolation of its potential applications in business, government and policy. Even where social-science research methods are deployed for practical ends, such as the use of randomized controlled field experiments for policy evaluation19, the impact is primarily on policy rather than science. Although laudable, such evidence-based policy work more properly belongs to Edison's quadrant than to Pasteur's.

One reason for the relative rarity of use-inspired basic social science is that, as noted above, real-world social problems are typically messy and multifaceted, thereby greatly complicating the task of evaluating progress or even defining the problem to be solved in the first place. Health, education, inequality, cultural norms, economic policies, and physical environments all interact in complicated ways to produce particular individual and group outcomes. Attempts to understand or influence these outcomes in the real world therefore often result in a difficult choice between focusing on such a small part of the problem that one misses the larger picture, and drowning in complexity. Exacerbating this difficulty is the reality that not everyone cares as much about standards of evidence as social scientists do3. Why invest in a multi-year research project when one can simply follow one's instincts, be inspired by a best-selling book, or pay a consultant to deliver an answer in a matter of months?

## Identifying Goldilocks problems
A major challenge for solution-oriented social science is, therefore, to identify a set of problems that are not so large and complex as to require a total theory of social, economic, and political life, but are still of sufficient difficulty to justify a genuinely scientific approach. Even better would be problems that are modular, in the sense that they can be expressed in a succession of increasingly ambitious versions. By starting with the most limited version of a problem and progressing up the hierarchy of complexity, one could hope to make concrete progress on a realistic timescale, while still maintaining a grand vision of ultimate progress. Finally, while the research itself would be understandable only to experts, it is important that no particular expertise be required to understand the problem statement or to check that proposed solutions work.

Identifying problems that have this ‘Goldilocks’ property of being neither too easy nor too hard is difficult, but one possible direction is to draw inspiration from engineering, and place more emphasis on building tangible devices and systems that have specific, well-defined properties. For example, the problem of building a driverless vehicle is easy to understand (a car that drives itself!) and relatively easy to evaluate (does it drive itself?), but is of sufficient difficulty to require fundamental advances in artificial intelligence (AI). By analogy, social scientists might propose building instruments for measuring social sentiment, or platforms for supporting political deliberation or economic exchange, or compilers that enable human workers and machines to collaborate on complex tasks. Solution-oriented social science, however, need not be restricted to solutions with direct engineering analogues. For example, systems of best practices could be developed, say for management or hiring, that are grounded in large-scale comparative observational studies, field experiments and algorithmic decision aids. Systems for generating and testing the policy implications of competing theories — with respect, say, to social influence or collective problem-solving — would also qualify.

Another potential approach is inspired by the ‘common-task framework’51,52, originally developed in AI research, according to which researchers compete to solve specific tasks (for example, machine translation), solutions are benchmarked using agreed-upon performance metrics (word error rate) and performance is evaluated on publicly available datasets (Canadian Hansards) by an independent referee (NIST, the National Institute of Standards and Technology). Perhaps surprisingly, by limiting the scope of the problems to be solved, the common task framework has yielded extraordinary advances in the performance of machine-learning algorithms over the past 30 years, ultimately producing working AI services such as Google and Skype translation systems, Siri and Cortana. Although adapting the common task framework to social science is not without complications — for example AI researchers may be satisfied with predictive accuracy whereas social scientists also typically seek to understand causal mechanisms — there is no reason in principle why ‘Netflix style’ contests could not be conducted using social datasets, potentially with important scientific and policy consequences.

To conclude, let me restate that I am not arguing that solving problems is the only productive mode of social-science research, nor am I am arguing that social scientists never take it upon themselves to solve practical problems. What I am arguing, however, is that placing more emphasis on use-inspired research would benefit social science in two ways. First, it would force social scientists to deal with the incoherency problem, thereby advancing fundamental scientific understanding of the social world. And second, it would help social science to be more visibly useful to the world, thereby improving its status with an increasingly sceptical public53, as well as generating excitement and interest among students who might otherwise choose the natural sciences, engineering or some other profession entirely. Finally, concrete progress need not require sweeping changes in the organization of social science. If one could identify even a handful of Goldilocks problems, even a single research centre or institute could make exciting progress within a decade. If that happened, other institutes and centres might be inspired to follow, much as a single institute — the Laboratory of Molecular Biology (LMB) in Cambridge — jump-started the field of molecular biology and inspired many other similar institutes to follow54. Social science is of course different from molecular biology, and analogies with past successes are always at risk of being overblown. Nevertheless, given the limited downside of just one group of people trying to do something different in just one place for a limited time, and the considerable upside if they succeed, my vote is that it is worth the risk.

## References

1. Vickrey, W. Counterspeculation, auctions, and competitive sealed tenders. J. Financ. 16, 8–37 (1961).



2. Myerson, R. B. Optimal auction design. Math. Oper. Res. 6, 58–73 (1981).



3. Gale, D. & Shapley, L. S. College admissions and the stability of marriage. Am. Math. Mon. 69, 9–15 (1962).



4. Roth, A. E. & Sotomayor, M. in Handbook of Game Theory with Economic Applications Vol. 2 (eds Aumann, R. & Hart, S.) 485–541 (Elsevier, 1992).

5. Merton, R. K. Social Theory and Social Structure 39–72 (The Free Press, 1968).

6. Hidalgo, C. A. Disconnected, fragmented, or united? A trans-disciplinary review of network science. Appl. Network Sci. http://dx.doi.org/10.1007/s41109-016-0010-3 (2016).

7. Becker, H. S. Tricks of the Trade: How to Think about Your Research While You're Doing it (Univ. Chicago Press, 1998).

8. Watts, D. J. Everything Is Obvious: *Once You Know the Answer (Crown Business, 2011).

9. Frank, R. H. Success and Luck: Good Fortune and the Myth of Meritocracy (Princeton Univ. Press, 2016).

10. Klinenberg, E. Heat Wave: A Social Autopsy of Disaster in Chicago (Univ. Chicago Press, 2015).

11. Venkatesh, S. A. American Project: The Rise and Fall of a Modern Ghetto (Harvard Univ. Press, 2002).

12. Goffman, A. On the Run: Fugitive Life in an American City (Picador, 2015).

13. Kahneman, D. Thinking, Fast and Slow (Macmillan, 2011).

14. Thaler, R. H. & Sunstein, C. R. Nudge: Improving Decisions About Health, Wealth, and Happiness (Yale Univ. Press, 2008).

15. Gelman, A. Red State, Blue State, Rich State, Poor State: Why Americans Vote the Way They Do (Princeton Univ. Press, 2008).

16. Milanovic, B. The Haves and the Have-Nots: A Brief and Idiosyncratic History of Global Inequality (Basic Books, 2010).

17. Ravitch, D. The Death and Life of the Great American School System (Basic Books, 2010).

18. Gruber, J. Covering the uninsured in the United States. J. Econ. Lit. 46, 571–606 (2008).



19. Banerjee, A. & Duflo, E. Poor Economics: A Radical Rethinking of the Way to Fight Global Poverty (Public Affairs, 2011).

20. Sunstein, C. R. Simpler: The Future of Government (Simon & Schuster, 2014).

21. Granovetter, M. S. Threshold models of collective behavior. Am. J. Sociol. 83, 1420–1443 (1978)



22. Bikhchandani, S., Hirshleifer, D. & Welch, I. A theory of fads, fashion, custom, and cultural change as informational cascades. J. Polit. Econ. 100, 992–1026 (1992).

23. Watts, D. J. & Dodds, P. S. in The Oxford Handbook of Analytical Sociology (eds Hedström, P. & Bearman, P. S.) 475–497 (Oxford Univ. Press, 2009).

24. Bass, F. M. A new product growth for model consumer durables. Manage. Sci. 15, 215–227 (1969).



25. Kermack, W. O. & McKendrick, A. G. A contribution to the mathematical theory of epidemics. Proc. R. Soc. Lond. A 115, 700–721 (1927).



26. Goldenberg, J., Libai, B. & Muller, E. Talk of the network: a complex systems look at the underlying process of word-of-mouth. Market. Lett. 12, 211–223 (2001).



27. Strang, D. & Tuma, N. B. Spatial and temporal heterogeneity in diffusion. Am. J. Sociol. 99, 614–639 (1993).



28. Bicchieri, C. & Fukui, Y. The great illusion: ignorance, informational cascades and the persistence of unpopular norms. Bus. Ethics Quart. 9, 127–155 (1999).



29. Watts, D. J. A twenty-first century science. Nature 445, 489 (2007).

30. Lazer, D. et al. Computational social science. Science 323, 721–723 (2009).


31. Mason, W. & Suri, S. Conducting behavioral research on Amazon's Mechanical Turk. Behav. Res. Meth. 44, 1–23 (2012).



32. Horton, J. J., Rand, D. G. & Zeckhauser, R. J. The online laboratory: conducting experiments in a real labor market. Exp. Econ. 14, 399–425 (2011).

33. Paolacci, G., Chandler, J. & Ipeirotis, P. G. Running experiments on Amazon Mechanical Turk. Judgm. Decis. Mak. 5, 411–419 (2010).


34. Aral, S. & Walker, D. Identifying influential and susceptible members of social networks. Science 337, 337–341 (2012).

35. Bakshy, E., Eckles, D., Yan, R. & Rosenn, I. Social influence in social advertising: evidence from field experiments. In Proc. 13th ACM Conf. Electronic Commerce 146–161 (ACM, 2012).

36. Davis, G. F. What is organizational research for? Admin. Sci. Quart. 60, 179–188 (2015).



37. Wallerstein, I. Open the Social Sciences: Report of the Gulbenkian Commission on the Restructuring of the Social Sciences (Stanford Univ. Press, 1996).

38. Tetlock, P. E. Expert Political Judgment: How Good Is It? How Can We Know? (Princeton Univ. Press, 2005).

39. Gladwell, M. The tipping point. The New Yorker (3 June 1996).

40. Sampson, R. J. & Raudenbush, S. W. Systematic social observation of public spaces: a new look at disorder in urban neighborhoods. Am. J. Sociol. 105, 603–651 (1999).



41. Harcourt, B. E. & Ludwig, J. Broken windows: new evidence from New York city and a five-city social experiment. Univ. Chicago Law Rev. 73, 271–320 (2006).

42. Meehl, P. E. Why summaries of research on psychological theories are often uninterpretable. Psychol. Rep. 66, 195–244 (1990).



43. Collaboration, O. S. Estimating the reproducibility of psychological science. Science 349, aac4716 (2015).

44. Gelman, A. & Loken, E. The statistical crisis in science. Am. Sci. 102, 460 (2014).

45. Bush, V. Science: the endless frontier. Trans. Kansas Acad. Sci. 48, 231–264 (1945).



46. Stokes, D. E. Pasteur's Quadrant: Basic Science and Technological Innovation (Brookings Institution Press, 2011).

47. Sarewitz, D. Saving science. The New Atlantis 49, 4–40 (2016).

48. Shneiderman, B. The New ABCs of Research (Oxford Univ. Press, 2016).

49. Katz, E. & Lazarsfeld, P. F. Personal Influence: The Part Played by People in the Flow of Mass Communications (The Free Press, 1955).

50. Hallinan, M. T. Equality of educational opportunity. Annu. Rev. Sociol. 249–268 (1988).

51. Liberman, M. Fred Jelinek. Comput. Linguist. 36, 595–599 (2010).



52. Donoho, D. 50 Years of Data Science (Tukey Centennial Workshop, 2015); http://courses.csail.mit.edu/18.337/201/docs/50YearsDataScience.pdf

53. Prewitt, K. Can social science matter? Items http://items.ssrc.org/can-social-science-matter/ (2016).

54. Judson, H. F. The Eighth Day of Creation (Simon & Schuster, 1979).
