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

Offline evaluation: evaluation without user involvement

We conducted offline evaluation using retrospective data about awarded public contracts.
Matchmaking was tested on the task of the awarded bidder prediction.

It is common to use historical user interaction data to evaluate recommender systems [@Jannach2010, p. 169].
Contract award as an explicit user feedback
Framework agreements awarded to multiple bidders were excluded from the evaluation dataset.

### Evaluation protocol

Split into training and testing dataset.
5-fold cross-validation
<!-- Should we split by time? For example, use 8 years (2006-2014) as training and 2 years (2015-2016) for testing? -->

Using recall does not make sense, since there is only one positive. Hence, recall would be either 0 or 1.
<!-- = unary rating -->

Baseline results:

* Exact match via CPV
* Recommend most awarded bidders constantly
* Recommend random bidders
* Recommend bidders with highest PageRank

Since we evaluate matchmaking as a prediction of the awarded bidders, we need each public contract to have a single winner.
However, that is not the case for around 1 % of public contracts in our dataset. 
This may be either in error or when members of the winning groups of bidders are listed separately.
We decided to exclude these contracts from our evaluation sample.

<!--
TODO: Refer to Maidel (2008) in the discussion of setting the weights of expanded concepts:
* V. Maidel, P. Shoval, B. Shapira, and M. Taieb-Maimon, Evaluation of an ontology- content based filtering method for a personalized newspaper, Proceedings of the 2008 ACM Conference on Recommender Systems (RecSys ’08) Lawsanne, Switzerland) (Pearl Pu, Derek Bridge, Bamshad Mobasher, and Francisco Ricci, eds.), ACM, 2008, pp. 91–98.
Additionally, Maidel (ibid.) showed that weighting concepts (e.g., by TF-IDF) does not have an impact.

Discuss internal validity of the proposed evaluation design:
*"Internal validity refers to the extent to which the effects observed are due to the controlled test conditions (e.g., the varying of a recommendation algorithm’s parameters) instead of differences in the set of participants   (predispositions) or uncontrolled/unknown external effects."* [@Jannach2010, p. 168]

Adverse selction is caused by asymmetric distribution of information.
Collusion: agreement between multiple parties to limit open competition.
Rival bidders cooperate for mutual benefit.
Cartels are explicit collusion agreements.
A close problem: monopoly
Bid rigging: artificial bids to make a bid more appealing.

We cannot assume that bidders who were awarded multiple contracts from the same contracting authority "proven" their quality. It may just be a case of clientelism.
Can we identify "bad" bidders? Do they exhibit certain patterns that we can recognize in the data?
(Perhaps we can use data from ÚOHS. However, Sbírka rozhodnutí by ÚOHS is not machine readable.)

The majority of the Czech public contracts actually used an open procedure.

There is a systemic bias in our ground truth, since we do not have explicit evaluations of the awarded bidders after finishing the contracts.
What we have is this: Similar contracs are usually awarded to these bidders.

Matchmaking can therefore serve only as pre-filtering.
The problem with filtering is that it potentially leaves relevant bidders behind, so that we cannot say that the bias will be dealt with by manual screening of the matches.

Since learning from contracts awarded in the past is the fundamental part of our machine learning approach, the key question is this: Is the bias severe enough to make it better to avoid learning from past contracts?

Nevertheless, how can matchmaking work without learning from the awarded contracts? Can it only employ similarity-based retrieval?

There are several ways we attempted to ammeliorate the biases in our ground truth:

* We experimented with discounting contract awards by the zIndex scores of their contracting authorities.
  However, this is a blunt tool, since it applies across the board for all contracts by a contracting authority.
  Within large contracting authorities each contract may be administered by different civil servant.
  Moreover, the people involved in public procurement of a contracting authority change over time.
* We experimented with limiting contracts awards to those awarded in open procedures.
  An intuition motivating this experiment is that a contract awarded in an open procedure enables fairer competition and thus avoid some risks of adverse selection.
  However, a likely outcome of these corrective measures is performance loss in the evaluation via retrospective data.
  This can be described as underfitting, while learning from all contract awards overfits, so that it includes the negative effects in public procurement too.
* An alternative option is to restrict contract awards to learn from by their award criteria.
  It seems that the simplistic criterion of lowest price is fair, but, due to bidder collusion the lowest price may be intentionally inflated by fake bids.
  Other, more complex award criteria leave more room for deliberation of contracting authorities.
  As such, they can be made less transparent.
-->

### Evaluated metrics

The evaluated metris reflect both accuracy and diversity of the matchmaking results.

* Hit rate at 10 (HR@10): number of hits in top 10 results ⁄ number of queries
  <!-- More commonly named HitRatio -->
* Mean reciprocal rank at 10 (MRR@10): average of the hits' multiplicative inverse ranks
  * Used for evaluating systems where *"the user wishes to see one relevant document"* [@Craswell2009].
  * *"MRR is equivalent to Mean Average Precision in cases where each query has precisely one relevant document."* [@Craswell2009]
* Catalog coverage at 10 (CC@10): distinct entities in top 10 results ⁄ all entities
* Prediction coverage [@Herlocker2004, p. 40]
* Long-tail percentage [@Adomavicius2012]

<!--
Diversity of results is often low in case-based recommenders based on similarity-based retrieval.
There are several strategies to mitigate this issue:
- Bounded greedy selection: minimizes total similarity in the result set, while maximizing total similarity of the result set to the query.
-->

<!--
http://videolectures.net/eswc2014_di_noia_linked/?q=di%20noia
The task 2 of the challenge used F1-measure @ top 5.
The evaluation of task 3 on diversity is evaluated using intra-list diversity (ILD) with only dcterms:subject and dbo:author. We can also restrict the ILD to few properties (or property paths).
-->

Accuracy, however, is not a suitable metric for evaluation of matchmaking because of the class imbalance within matchmaking results. <!-- [@Christen2012] -->
Results with the status of non-match are much more prevalent in matchmaking than those with the status of match, which skews accuracy measure, as it takes the number of true negatives into account.

<!--
User coverage: a share of bidders for which the system is able of recommending contracts.
Use a more content-based approach (leveraging data from ARES) for cold-start users (i.e. those without an awarded contract)?
Alternative solutions:
* Users may subscribe to recommendations for other users. For example, they may be asked to list their competitors, who were awarded public contracts, and be subscribed to their recommendations.
* Ask users to rate a sample of public contracts either as relevant or irrelevant. The sample must be chosen in order to maximize the insight learnt from the rating, e.g., the sample should be generated dynamically to increase its overall diversity.
-->

The prediction power of offline evaluation is limited.
It can tell which of the evaluated approaches provides better results, but it cannot tell if an approach is useful.
Whether an approach is useful can be only evaluated by real users.
This is what online evaluation or qualitative evaluation can help with.

Limited correspondence between the evaluted metrics and usefulness in real world.

We used Wilcoxon signed-rank test [@Rey2014] to evaluate the statistical significance of differences between the distributions of ranks produced by the evaluated matchmakers.
We chose it because we compare ranks for the whole dataset and this test is suited for paired samples from the same population.
Moreover, it does not require the compared samples to follow normal distribution, which is the case of the distributions of ranks.

### Evaluation results

<!--
Evaluate statistical significance using Wilcoxon signed-rank test.
-->
