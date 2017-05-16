# Evaluation

Experimental design (experimental evaluation, controlled experiment)
- Lab studies
- Matchmaking as a classification task that produces a ranked list of relevant items.

Nonexperimental design: qualitative research via interviews with users (or domain experts)

+ Descriptive evaluation via example scenarios?
+ Cost-benefit analysis discussing the matchmaker's value compared with the costs in sustaining it (keeping it operable)?

We evaluated both the statistical and practical significance of our findings.
Evaluation of statistical significance was used to rule out the differences between the evaluated matchmakers that could be attributed to random error.
We considered practical importance of our research as part of qualitative evaluation via interviews with domain experts.
In this way, we attempted to demonstrate the utility of our developed artefacts.

<!--
Alternative evaluation protocol, widely used in top-k recommendation: <http://dl.acm.org/citation.cfm?id=1864721>

Evaluated dimensions:
* Effectiveness (quality)
* Efficiency (speed)
  - Additional indices may speed up retrieval.
  - Complexity of the distance function.
    - Blocking may be done by lower-bounding distance functions. Such functions are less complex and produce approximate lower distance.
-->

[@Beel2013] found that *"results of offline and online evaluations often contradict each other"* (p. 7).

However, conducting online evaluation is expensive since it requires an application with real users.
In order to attract sufficient mass of users to make the finding from the evaluation statistically significant, the application must be relatively mature and proven useful.
Due to the large effort required by setting up an online evaluation, we decided instead to balance the offline evaluation with qualitative evaluation using semi-structured interviews with domain experts and prospective users of the matchmakers.
We used offline evaluation to pre-screen viable matchmaking methods and configurations that we subsequently consulted with users.
