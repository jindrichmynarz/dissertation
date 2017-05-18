# Evaluation

We evaluated both the statistical and practical significance of our contributions.
Evaluation of statistical significance was used to rule out the differences between the evaluated matchmakers that could be attributed to random error.
We considered practical importance of our research as part of the qualitative evaluation. 
In this way, we attempted to demonstrate the utility of our developed artefacts.
We used a combination of offline evaluation and qualitative evaluation.

<!-- TODO: Frame within the context of design science.

The evaluation includes both experimental and nonexperimental design.
The offline evaluation follows an experimental design, while the qualitative evaluation is nonexperimental.

In terms of Wieringa [-@Wieringa2014, p. 31], both our offline evaluation and qualitative evaluation are validation, because both use a model of how the developed matchmakers would be used in the real world.
-->

<!-- Offline evaluation -->

Offline evaluation is an experimental setting, in which past user interactions are used as ground truth.
In this setting, some interactions are withheld and the evaluated system is assessed on its ability to fill in the missing interactions. 
The term "offline evaluation" is established in recommender systems research in contrast to online evaluation.
While online evaluation involves users in real-time, offline evaluation approximates online evaluation by using pre-recorded user interactions.
Offline evaluation then *"consists of running several algorithms on the same datasets of user interactions (e.g., ratings) and comparing their performance"* [@Ricci2011, p. 16].

<!-- Limitations of offline evaluation -->

While using historical user interaction data for evaluation is a common practice [@Jannach2010, p. 169], it has several flaws that reduce its predictive power.
In addition to the domain-specific limitations of the ground truth, which we described in [@sec:ground-truth], the datasets used for offline evaluation can be incomplete and may contain systemic biases.
Ground truth in the datasets is incomplete, since it typically contains only a fraction of true positives.
In most cases, users review only few possible matches, excluding the rest, notwithstanding its relevance, from the true positives.
Consequently, if the evaluated system recommends relevant items that are not in the ground truth, these matches are ignored.
In other words, *"when incomplete datasets are used as ground-truth, recommender systems are evaluated based on how well they can calculate an incomplete ground-truth"* [@Beel2013, p. 11].

Due to these limitations offline evaluation has a weak prediction power. 
As such, *"offline evaluations of accuracy are not always meaningful for predicting the relative performance of different techniques"* [@Garcin2014, p. 176].
Offline evaluation can tell which of the evaluated approaches provides better results, but it cannot tell if an approach is useful.
There is a limited correspondence between the evaluted metrics and usefulness in real world.
Whether an approach is useful can be only evaluated by real users.
This is what online evaluation or qualitative evaluation can help with.

<!-- Upsides -->

However, one can also argue that *"offline evaluations are based on more thorough assessments than online evaluations"* [@Beel2013].
Ground truth in offline evaluation may be derived from more thorough examination of items, involving multiple features in tandem, while online evaluation may rely on superficial assessment, such as click-throughs based on titles only.

<!-- Online evaluation -->

Online evaluation is commonly recommended as a remedy to the afore-mentioned limitations of offline evaluation.
As a matter of fact, the results of online evaluation can differ widely from the results of offline evaluation.
Several studies found that *"results of offline and online evaluations often contradict each other"* [@Beel2013, p. 7] or acknowledged that *"there remains a discrepancy in the offline evaluation protocols, and the online deployment and accuracy estimate of the algorithms in a real-life setting"* [-@Said2013].
However, conducting online evaluation is expensive since it requires an application with real users.
In order to attract a sufficient mass of users to make the findings from the evaluation statistically significant, the application must be relatively mature and proven useful.
Moreover, we wanted to explore a large space of different matchmaker configurations, for which carrying out online evaluation would be prohibitively expensive.

<!-- Qualitative evaluation -->

Due to the large effort required by setting up an online evaluation, we decided to balance the shortcoming of offline evaluation with qualitative evaluation.
We used offline evaluation to prescreen viable matchmaking methods and configurations to select fewer promising variants that we subsequently consulted using semi-structured interviews with domain experts and prospective users of the matchmakers.

<!--
Alternative evaluation protocol, widely used in top-k recommendation: <http://dl.acm.org/citation.cfm?id=1864721>

Evaluated dimensions:
* Effectiveness (quality)
* Efficiency (speed)
  - Additional indices may speed up retrieval.
  - Complexity of the distance function.
    - Blocking may be done by lower-bounding distance functions. Such functions are less complex and produce approximate lower distance.
-->

<!--
Out-takes:

Experimental design (experimental evaluation, controlled experiment)
- Lab studies
- Matchmaking as a classification task that produces a ranked list of relevant items.

Nonexperimental design: qualitative research via interviews with users (or domain experts)

+ Descriptive evaluation via example scenarios?
+ Cost-benefit analysis discussing the matchmaker's value compared with the costs in sustaining it (keeping it operable)?
-->
