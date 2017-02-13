## Offline evaluation

<!--
### Implementation notes

* Start a new Clojure project `matchmaker-evaluation`.
* Evaluation accepts input in EDN with matchmaking results.
* Define a schema of the matchmaking results:
  * Rank: HR@k, MRR@k
  * CC@k (catalog coverage)
* Copy and paste evalution metrics from the original `matchmaker` project.
* Incanter visualizations
-->

We conducted offline evaluation using retrospective data about awarded public contracts.
Matchmaking was tested on the task of the awarded bidder prediction.

It is common to use historical user interaction data to evaluate recommender systems ([Jannach et al., 2010, p. 169](#Jannach2010)).
Contract award as an explicit user feedback
Framework agreements awarded to multiple bidders were excluded from the evaluation dataset.

Split into training and testing dataset.
5-fold cross-validation

Using recall does not make sense, since there is only one positive. Hence, recall would be either 0 or 1.
<!-- = unary rating -->

Baseline results:

* Exact match via CPV
* Recommend most awarded bidders constantly
* Recommend random bidders
* Recommend bidders with highest PageRank

<!--
TODO: Refer to Maidel (2008) in the discussion of setting the weights of expanded concepts:
* V. Maidel, P. Shoval, B. Shapira, and M. Taieb-Maimon, Evaluation of an ontology- content based filtering method for a personalized newspaper, Proceedings of the 2008 ACM Conference on Recommender Systems (RecSys ’08) Lawsanne, Switzerland) (Pearl Pu, Derek Bridge, Bamshad Mobasher, and Francisco Ricci, eds.), ACM, 2008, pp. 91–98.
Additionally, Maidel (ibid.) showed that weighting concepts (e.g., by TF-IDF) does not have an impact.

Discuss internal validity of the proposed evaluation design:
*"Internal validity refers to the extent to which the effects observed are due to the controlled test conditions (e.g., the varying of a recommendation algorithm’s parameters) instead of differences in the set of participants   (predispositions) or uncontrolled/unknown external effects."* ([Jannach et al., 2010](#Jannach2010), p. 168)
-->

### Evaluated metrics

The evaluated metris reflect both accuracy and diversity of the matchmaking results.

* Hit rate at 10 (HR@10): number of hits in top 10 results ⁄ number of queries
  <!-- More commonly named HitRatio -->
* Average rank at 100 (AR@100): mean average rank of hits in top 100 results
* Catalog coverage at 10 (CC@10): distinct entities in top 10 results ⁄ all entities

<!--
Why did we drop Mean Reciprocal Rank (MRR)?
-->

<!--
http://videolectures.net/eswc2014_di_noia_linked/?q=di%20noia
The task 2 of the challenge used F1-measure @ top 5.
The evaluation of task 3 on diversity is evaluated using intra-list diversity (ILD) with only dcterms:subject and dbo:author. We can also restrict the ILD to few properties (or property paths).
-->

Accuracy, however, is not a suitable metric for evaluation of matchmaking because of the class imbalance within matchmaking results. <!-- [Christen, 2012](#Christen2012) -->
Results with the status of non-match are much more prevalent in matchmaking than those with the status of match, which skews accuracy measure, as it takes the number of true negatives into account.

<!--
User coverage: a share of bidders for which the system is able of recommending contracts.
Use a more content-based approach (leveraging data from ARES) for cold-start users (i.e. those without an awarded contract)?
Alternative solutions:
* Users may subscribe to recommendations for other users. For example, they may be asked to list their competitors, who were awarded public contracts, and be subscribed to their recommendations.
* Ask users to rate a sample of public contracts either as relevant or irrelevant. The sample must be chosen in order to maximize the insight learnt from the rating, e.g., the sample should be generated dynamically to increase its overall diversity.
-->

### Evaluation results

<!--
Evaluate statistical significance using Wilcoxon signed-rank test.
-->
