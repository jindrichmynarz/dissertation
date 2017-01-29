# Evaluation

Experimental design (experimental evaluation, controlled experiment)
- Lab studies
- Matchmaking is a classification task that produces a ranked list of relevant items.

Nonexperimental design: qualitative research via interviews with users (or domain experts)

+ Descriptive evaluation via example scenarios?
+ Cost-benefit analysis discussing the matchmaker's value compared with the costs in sustaining it (keeping it operable)?

Statistical significance
Practical importance: demonstrate utility of the developed artefact

## Offline evaluation

We conducted offline evaluation using retrospective data about awarded public contracts.
Matchmaking was tested on the task of the awarded bidder prediction.

It is common to use historical user interaction data to evaluate recommender systems ([Jannach et al., 2010, p. 169](#Jannach2010)).
Contract award as an explicit user feedback

Split into training and testing dataset.
n-fold cross-validation

Using recall does not make sense, since there is only one positive. Hence, recall would be either 0 or 1.

Baseline results:

* Exact match via CPV
* Recommend most awarded bidders constantly
* Recommend random bidders
* Recommend bidders with highest PageRank

### Evaluated metrics

The evaluated metris reflect both accuracy and diversity of the matchmaking results.

* Hit rate at 10 (HR@10): number of hits in top 10 results ⁄ number of queries
* Average rank at 100 (AR@100): mean average rank of hits in top 100 results
* Catalog coverage at 10 (CC@10): distinct entities in top 10 results ⁄ all entities

Accuracy, however, is not a suitable metric for evaluation of matchmaking because of the class imbalance within matchmaking results. <!-- [Christen, 2012](#Christen2012) -->
Results with the status of non-match are much more prevalent in matchmaking than those with the status of match, which skews accuracy measure, as it takes the number of true negatives into account.

### Evaluation results

<!--
Evaluate statistical significance using Wilcoxon signed-rank test.
-->

## Online evaluation

The results of offline testing can differ dramatically from the results obtained via online testing done at system runtime with real users ([Said et al., 2013](#Said2013)).
In particular, the recommender systems research community is reassessing the dominance of offline testing focused on evaluating accuracy metrics.
It is becoming more common to emphasize online testing and non-accuracy metrics, such as recommendation diversity.

Click-through can be reinterpreted as implicit positive rating.

<!--
TODO: In order to be able to interpret CTR correctly, read: T. Joachims, L. Granka, B. Pan, H. Hembrooke, and G. Gay, Accurately interpreting clickthrough data as implicit feedback.
-->

A/B testing

### Evaluated metrics

* Click-through rate

### Evaluation results

<!--
TODO: Qualitative evaluation via interview with public procurement experts to obtain feedback on the quality of recommendations.
-->
