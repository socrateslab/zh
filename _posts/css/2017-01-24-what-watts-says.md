---
layout: single
title: "Duncan Watts' AMA Interview"
header:
  teaser: "/assets/images/unsplash-gallery-image-2-th.jpg"
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-30.jpg
  cta_label: "Read More"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "On the other hand a single high impact paper is worth many low impact papers, so from a career perspective it’s not necessarily a waste of time to devote a year or two to getting something into a top journal."
modified: 2017-01-24 19:49:48
comments: true
author: "Duncan J. Watts"
tags:
  - social science
  - Watts
categories:
  - 计算社会科学
---



Rep: We thank Duncan Watts for participating in SJMR’s AMA series. Dr. Watts is a prominent network sociologist and public figure. He is currently a principal researcher at Microsoft Research. Before that, he was a professor of sociology at Columbia University. We are grateful to Duncan for his insightful and frank responses, which are posted below. You can learn more about his research by visiting his [website](https://scholar.google.com/citations?user=LhOAiXMAAAAJ&hl=en&oi=ao).

-beakman


Questions.

Pre-amble: Thanks to beakman for the opportunity to write for SJMR and to the community for posing such thoughtful questions. I’ve really enjoyed thinking about them and I hope my answers are helpful.

-Duncan Watts


1 What are your impressions of the way that network science has gone? A lot of it increasingly (since small worlds especially) focuses on the shape of the network, rather than the attributes of nodes--do you think that's the right way forward? Is there anything big missing from network sociology, or a direction that you think it should be going in? Will "small data" networks be drown out by big data?
{: .notice--danger}


For me, network structure has always only been a means to an end, which is to understand collective social behavior. That might sound surprising because my early work did emphasize the importance of network structure. But if you look back at my original paper with Strogatz it has “collective dynamics” right there in the title—it was always the relationship between structure and behavior that we thought was interesting, not structure for its own sake.

We also didn't intend for the “small world” model that we proposed to be interpreted as a realistic model of network structure; rather we were trying to make a conceptual point that even subtle changes in micro-structure could have dramatic effects on macro-structure and hence possibly also macro-behavior. So I at least was surprised at how much subsequent work was devoted to exploring the properties of that particular model, along with other simple and equally unrealistic models, as if they were empirically accurate. I think I understand how that happened now, but I’ve also come to believe that modeling exercises that are unconstrained by data have a tendency to gravitate toward phenomena that are mathematically interesting, which is no guarantee of empirical relevance.

Fortunately I think that in recent years we’ve seen more emphasis on studying both network structure and collective behavior empirically. In part this trend has been driven by the increasing availability of “big data” from various online sources (email, ecommerce, social media, etc.), but in part it has been driven by novel types of “small data” as well, such as from virtual lab experiments.

I think both types are important. For some questions, such as when we are interested in rare events or estimating tiny effect sizes, it is indeed necessary to have a very large number of observations; in some of our recent work on diffusion, for example, it turns out that a billion observations is not excessive. But for other questions, the scale of the data is much less important than its type or quality. Sometimes it matters that a sample is unbiased or representative; other times it is important to have proper randomization in order to infer causality; and other times still it is important simply that you have instrumented the outcome variable of interest. Regardless, the point is that the data is relevant to the question you’re asking, not how big or small it is.

2 Economists have been pretty successful at clearly articulating a set of core concepts that have spread out into the broader world and form the basis for "economic thinking": supply and demand; markets; externalities; people respond incentives; perverse incentives; sunk costs; exogenous shocks; etc. Since your early work brought together core sociological concepts (namely social influence and the Matthew effect):
{: .notice--danger}

i) Do you think sociology should try to reorganize itself around core, "Soc 101" concepts that every introductory class would cover? We often talk about the "sociological imagination", but that is much less clear than "economic thinking".
{: .notice--danger}

This is a tough one. One of things I’ve always liked about sociology is its embrace of multiple viewpoints, both in terms of theory and methodology. Personally I think social reality is too complex to be adequately accounted for by any single theoretical framework—a point that Merton made very eloquently many years ago in his article on middle-range theories. Unfortunately I don’t think his argument was properly understood at the time (e.g. by rational choice theorists) and I don’t think it is still.

Perhaps that’s because simple universal frameworks are institutionally powerful even when they’re scientifically questionable. And that’s why it’s a tough question: because I think that one reason why economics is so much more influential than sociology in government, in the media, and in society, is precisely because economists can articulate a fairly coherent worldview that they can all (by and large) get behind, whereas sociologists can’t really agree on anything. Economists are therefore in a much better position to offer answers to questions that people care about, whereas sociologists tend to point out all the ways in which the question is more difficult than the questioner realized. Even if the sociologist’s response better reflects our true understanding of the world, it’s no surprise that most people would prefer to listen to the economist.

That said, I wouldn’t advocate sociology trying to develop a single set of core concepts just to compete with economics. Rather I would propose that sociologists identify a small set of nontrivial real-world problems that we believe we can actually solve, or at least make some meaningful progress towards solving, and then demonstrating that progress. Identifying nontrivial but solvable social problems isn’t easy, nor do I think that solving problems is the only measure of progress in a discipline. So I certainly wouldn’t advocate that everyone drop what they’re doing to work on these problems, or even try to agree on what they should be. But I do think that being able to point to a set of problems that sociologists have arguably “solved” would greatly enhance our collective reputation and help us to attract more students.

ii) If you could pick a handful of sociological concepts and then have everyone outside of sociology learn them, and they'd be as familiar as the economic examples listed above, what would they be?
{: .notice--danger}

I wrote a book a few years ago called Everything is Obvious: Once you Know the Answer about the failures of commonsense reasoning and how we systematically ignore them. I think the contents of that book is pretty close to the list of concepts I would like everyone to understand, including: the nature of common sense itself; the difference between rational choice and behavioral conceptions of individual decision making; cumulative advantage and intrinsic unpredictability; the fallacy of the representative individual; the perils of ex-post explanations and dangers of “overfitting” to known outcomes; the consequences of overfitting for predictions about the future; and the implications of all of these problems for practical matters of predicting success, rewarding performance, deciding what is fair, and even what is knowable. I wouldn’t claim that these concepts constitute a core of knowledge comparable to core concepts in economics, nor do I think it would help students directly solve real-world problems of the kind I just advocated for, but I do think it would teach students some epistemic modesty and might eventually lead to more intelligent public discourse about these problems. I’m not sure the book has accomplished any of that, but that’s why I wrote it.

3 What's your take on the facebook experiment ethics side? Did you face similar issues with your sociological work at yahoo or microsoft?
{: .notice--danger}


As I’ve written [elsewhere](http://chronicle.com/blogs/conversation/2014/07/09/lessons-learned-from-the-facebook-study/), I think the main problem with the Facebook “emotional contagion” study was not that it was unethical but rather that it was not subject to any sort of ethical review before proceeding. [As others have also concluded](http://www.nature.com/news/misjudgements-will-drive-social-trials-underground-1.15553), my view is that had it been conducted by university researchers and subject to a university IRB, it would most likely have been allowed to proceed even without informed consent on the grounds that it exposed users only to minimal risk. It’s also true that existing rules about IRBs only apply to federally funded research, hence technically researchers at companies like Facebook don’t have to get their research approved by an IRB. Nevertheless, it was definitely human subjects’ research and so the right thing to do would have been to have it reviewed at the design stage for ethical considerations regardless of whether it was legally mandated. That’s the approach we are taking at Microsoft, where we’re exploring setting up an ethics training and review system for human subjects’ research.

Let me emphasize that I think subjecting our work to ethical review is not only the right thing to do but also the pragmatic thing. I believe there is tremendous societal value to using large-scale social data for social scientific ends, but it is clear to me that not everyone is persuaded of this view. I also think that the kind of data that researchers find most interesting is in some ways more problematic from an ethical perspective than what companies want. For example, companies might one day be willing to promise users that they will only use their data in ways that generate value for them personally. That might actually work fine for products whose value can be measured in terms of individual user experience, but social scientists interested in studying collective behavior in large networks can make no such promise. Even if that sort of research would prove extremely valuable to society in the long run, it’s almost impossible to say how it would benefit any particular individual in the short run; yet without everyone contributing “their” data such studies would be impossible. In the end, therefore, it is up to researchers to make the case for the value of what we are doing and to earn the public’s trust that we can do it in a responsible and ethical manner. University researchers may currently face a little less difficulty in that regard than researchers at companies, but ultimately I think they will end up facing the same scrutiny; so this is a challenge for the research community as a whole.

4 You made a transition from academia to the private sector. One of the ways that people have suggested improving the sociology PhD job market should is to make work in the private sector a clearer option from the beginning. What do you think about sociology PhDs and the private sector? How do you think sociology PhDs could or should be going about? What skills should they develop? How should they present themselves to companies?
{: .notice--danger}


It’s true that companies are increasingly excited about extracting value from data, which has made data science a very in-demand skill set. I also think that companies are starting to appreciate that truly valuable insight requires more than just good computational and statistical chops—some degree of theoretical knowledge is also required in order to ask the right questions, define the right metrics, and avoid basic errors of sampling bias, causal inference etc. This latter trend is much earlier in its life cycle than the former, but I think as companies learn more about the complexities and compromises associated with “big data” they will increasingly demand data scientists with social scientific training.

So on the bright side I think that there is real potential for sociology PhDs to find intellectually rewarding work in industry. The downside is that in order to realize any value from their sociological training they also need a level of technical skill that is well beyond what students can expect to learn in the vast majority of sociology PhD programs. In our postdoc hiring we are starting to see a handful of strong candidates with sociology PhDs—up from zero just a couple of years ago—so that’s encouraging. But I suspect that these students mostly figured it out on their own or took it up themselves to find the relevant courses in other departments. Which is fine, and if I were a current sociology PhD that’s what I would do, but I think it would be better for the field to provide a more systematic level of training.

5 You've been very successful publishing in journals such as AJS, while targeting broader audiences through high-impact journals such as Nature and Science. How is writing for an AJS audience different from writing for Nature and Science? Where would you send your manuscript if was rejected by Science? Do you think more sociologists should be looking to publish beyond our traditional journals in order to reach a broader community of scholars?
{: .notice--danger}


Writing for AJS is completely different from writing for Nature and Science in almost every sense: length, style, treatment of related literature, acceptable methodology, conception of theory, presentation of results…everything. It’s also different from writing for computer science conference proceedings and physics journals, and all of those different outlets are also different from one another. I also occasionally write magazine articles, op-eds and trade books, and those are also all different in their own way. Learning to write for different disciplinary outlets and in different styles is time consuming and sometimes frustrating—because different groups of readers care about such different things. But I think it’s an effort that sociologists should make. The fact is that with very few exceptions researchers in other disciplines don’t read sociology journal articles, and when they do they find them incredibly long and tedious. For example, all that effort that we devote to situating our work is completely lost on most computer scientists, so when they get to the results section they wonder why it was necessary to write 40 pages in order to explain one table of regression coefficients. Given that CS is a much bigger and more powerful discipline than sociology, if want to have an impact on them or convince them that we are worth taking seriously, we will have to speak to them in their language and probably in their own publication venues.

Another tricky question is how much time to devote to shooting for high status outlets like Science (or AJS for that matter) that have very low probability of acceptance, which in turn requires frequent rejections and time consuming rewrites. It’s not unusual, for example, for authors to send the same paper to Nature, then to Science, then to PNAS, then to PLoS One, a process that can take many months and burn up a lot of time for both authors and reviewers. It seems terribly inefficient, and from the perspective of advancing science it probably is.

On the other hand a single high impact paper is worth many low impact papers, so from a career perspective it’s not necessarily a waste of time to devote a year or two to getting something into a top journal. I do often wish that we could find a more efficient way to publish our research without compromising quality, and in that regard online-only, open-access journals like PLoS One and Sociological Science have some appealing properties. But the reality is that we live in a highly competitive world where attention is scarce; so my fear is that if we stopped using A-journal publications as a differentiator, the likely substitute (relentless self-promotion on social media anyone?) might be even worse.

6 You spent several years at the Columbia Sociology Department. During your time there you mentored several prominent junior scholars including Baldassari and Salganik. How was your experience being an academic sociologist and why did you decide to leave for industry? Will you consider returning to Academia?
{: .notice--danger}

I really loved my time at Columbia but around 2006 it started to dawn on me that, whether it liked it or not, sociology was going to become a computational science, much as biology had become a computational science in the early 1990s. All around us social data were exploding in volume and variety, from email to social networking services to online experiments of the kind I did with Matt (Salganik). It also occurred to me, **however, that sociologists weren’t well equipped to handle this transition and that if we were going to make rapid progress we would need to the computer scientists to help, and possibly psychologists and economists as well**. Columbia is now pretty open to interdisciplinary collaborations of this sort, and their data science institute is a great example of that openness, but at the time it was very hard to see how it would work within the confines of traditional academic departments.

**I was also having difficulty recruiting grad students with rigorous mathematical and computational backgrounds** (as you noted there were some like Matt and Delia and also Gueorgi Kossinets, but they were really the exceptions), and raising funding to support the whole thing.

**Towards the end I felt like I was spending all my time writing grant proposals or sitting in meetings and almost no time doing actual research**. So when Prabhakar Raghavan called me from Yahoo! to ask if I would come and help them set up a social science research unit it was very tempting. Even then I wasn’t sure I would do it, and certainly didn’t expect to do it for long, but it really worked out wonderfully and now I’ve been at Yahoo! and Microsoft Research for longer than I was at Columbia.

Perhaps surprisingly, I think the biggest difference between my experience at Columbia compared with Microsoft (or at Yahoo!) is that I now spend much more time doing and thinking about research. The other big difference is that, in contrast with most university faculty, I am surrounded (literally—we all sit in cubicles in an open plan office) by researchers from different disciplinary backgrounds including psychology, economics, physics, and computer science. One of my colleagues once observed that university departments comprise lots of people with similar training interested in different problems, whereas research labs like ours comprise lots of people with different training interested in the same problems. I think that’s roughly true, and it completely changes the nature of how we work, which is highly collaborative, interdisciplinary, and very problem oriented. That is not to say that we only do “applied” research—we do some of that but we also do a lot of basic science and publish all our work in all the same venues as our colleagues in universities. Rather what it means is that we are more concerned with the relevance of our work to real-world problems and less concerned about what particular disciplinary tradition it fits into.

Would I ever consider returning to academia? I don’t know. I’m very happy at Microsoft right now: I work with fantastic colleagues, we get amazing PhD student interns every summer, and we work on a wide variety of extremely interesting problems. It’s been a great experience and every day I’m grateful to have the job that I have. So although I wouldn’t rule out returning to academia one day I’m not in any hurry to leave.

7 You recently wrote an article on common sense and its importance for sociology. What was the intuition for it?
{: .notice--danger}

As I mentioned, I recently wrote a book about how people rely on common sense more than they realize, and in so doing end up persuading themselves that they understand much more about the world than they actually do. In course of writing the book, it occurred to me that sociologists make many of the same mistakes that other people do. Just like other people, that is, sociologists conflate causal explanations with explanations that “make sense” of outcomes they have observed, unconsciously substitute representative individuals for collectives, overfit their explanations to past data, and fail to check their predictions. I didn’t belabor this point in the book because, as I mentioned earlier, I wanted it be an advertisement for sociological thinking not a critique of it. Nevertheless I thought the implication was pretty clear, so I was disappointed that some of my colleagues who liked the book’s appeal to non-sociologists seemed to think it had nothing to say to them. I decided that if I wanted them to get the message I would have to sharpen it up a lot, and also make it a bit more constructive; so that’s what I tried to do in that paper.

8 If you were in charge of a Sociology department and could implement any change you'd like, what specific changes would you introduce to its graduate training program? Is there something that current sociology graduate students aren't doing that they should be doing?
{: .notice--danger}

As I mentioned earlier, I think that a data science sequence (e.g. data acquisition, cleaning and management; basic concepts and programming languages for parallel computing; advanced statistics, including methods of causal inference; some basic machine learning; design and construction of web-based experiments) would be super useful for sociology graduate students, and would make them both better social scientists and also much more attractive to prospective employers. There are already a handful of courses of this sort being trialed in various places, including Stanford, Columbia, and Princeton, and sociology departments could work with their colleagues in other departments to pull together a reasonable sequence from existing pieces. It would take some effort and probably resources, but I don’t think it’s unfeasible.

In the meantime, as I mentioned earlier: if I were a current sociology grad student, I would be busy taking courses in computer science and statistics to augment my sociology training. I would also look around for any groups doing computational social science and ask to join them. The downside of new, interdisciplinary fields is that nobody really knows what is involved or what the standards are, so you have to be prepared to take some risks and also to feel out of your depth much of the time. The upside is that it can be incredibly stimulating, and there is the possibility of doing something genuinely new. I think computational social science is in that phase now, so it’s a great time for ambitious and creative students to dive in and see what they can do.

9 Three sociologists walk into a bar. How does this joke end?
{: .notice--danger}


**It doesn’t.**
