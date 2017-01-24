# Evaluation

## Offline evaluation

We conducted offline evaluation using retrospective data about awarded public contracts.
Matchmaking was tested on the task of the awarded bidder prediction.

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

<!--
TODO: In order to be able to interpret CTR correctly, read: T. Joachims, L. Granka, B. Pan, H. Hembrooke, and G. Gay, Accurately interpreting clickthrough data as implicit feedback.
-->

### Evaluated metrics

* Click-through rate

### Evaluation results

<!--
TODO: Qualitative evaluation via interview with public procurement experts to obtain feedback on the quality of recommendations.
-->
