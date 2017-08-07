## Offline evaluation

<!--
FIXME: Do we basically do grid search? Configuration can be considered as hyperparameters. We are basically trying to find the most important (sensitive) hyper-parameters.
Idea: distribution of the predicted bidders should be equal to the distribution of the bidder frequencies. (Suggested in <https://static.googleusercontent.com/media/research.google.com/en/pubs/archive/43146.pdf>.)

Effect size:
- Effect size measures substantive significance.
- To evaluate effect size, should we use Mann-Whitney's test? <http://yatani.jp/teaching/doku.php?id=hcistats:mannwhitney#effect_size>
- Compare effect sizes relative to the baseline?
-->

We used offline evaluation to filter matchmaking methods and configurations to those that were subsequently used in qualitative evaluation.
Since we test different matchmakers in the same context, this evaluation can be considered a trade-off analysis [@Wieringa2014, p. 260], in which we balance the differences in the evaluated measures.

### Ground truth

We conducted offline evaluation using retrospective data about awarded public contracts.
Matchmaking was tested on the task of predicting the awarded bidder.
In our case, we treat contract awards as explicit positive user feedback.
Thus, in terms of [@Beel2013], we use a "user-offline-dataset", since it contains implicit ratings inferred from contract awards.

<!-- Adjustments of the ground truth -->

Due to the design of the chosen evaluation task, we had to adjust our ground truth data.
Since we evaluate matchmaking as a prediction of the awarded bidders, we need each public contract to have a single winner.
However, that is not the case for around 1 % of public contracts in our dataset.
This may be either in error or when members of the winning groups of bidders are listed separately.
For example, framework agreements may be awarded to multiple bidders.
For the sake of simplicity we decided to exclude these contracts from our ground truth.

### Evaluation protocol

<!-- N-fold cross-validation -->

Our evaluation protocol is based on n-fold cross-validation.
We split the evaluation data into training and testing dataset.
The testing dataset contains the withheld contract awards that a matchmaker attempts to predict.
We used 5-fold cross-validation, so that we divided the evaluation data into five non-overlapping folds, each of which was used as a testing dataset, while the remaining folds were used for training the evaluated matchmakers.
In this way we tested prediction of each contract award in the ground truth.

<!--
Should we split by time? For example, use 8 years (2006-2014) as training and 2 years (2015-2016) for testing?
Should we add an explanation why we did not split folds by time?
-->

### Evaluated metrics

<!-- Metrics and objectives -->

The objectives we focus on in offline evaluation are accuracy and diversity of the matchmaking results.
The adopted evaluation metrics thus go beyond those that reflect accuracy.
We aim to maximize the metrics of accuracy.
In case of the non-accuracy metrics we strive to increase them without degrading the accuracy.

<!-- Evaluation of performance?
Perhaps a rough overall assessment can suffice. E.g., both the SPARQL-based and Elasticsearch-based matchmakers deliver real-time performance, while the RESCAL-based one has to be used in batch mode.
Performance ~ efficiency in time and space (e.g., speed and RAM consumption)
Mention restrictions by the computational cost of an evaluation protocol? E.g., not using a learning to rank algorithm?
-->

We define the evaluation metrics using the following notation.
Let $C$ be the set of public contracts and $B$ the set of bidders.
The function $match_{m}\colon C \to \mathbb{P}(B)$, where $\mathbb{P}(B)$ is the powerset of $B$, returns an ordered set of bidders recommended for a given public contract by matchmaker $m$.
The function $bidder\colon C \to B$ returns the bidder to whom a contract was awarded.
The function $wrank\colon C \to \mathbb{N}_{\ge 1} \cup \{ \text{nil} \}$ gives the rank of the bidder who won a given public contract.

$$wrank(c) =
  \small
  \begin{cases}
    n \in \mathbb{N}\colon bidder(c)\, \textrm{is in position}\, n\, \textrm{in}\, match_{m}(c)
    & \text{if}\ bidder(c) \in match_{m}(c) \\
    \quad\textrm{nil} & \textrm{otherwise} \\
  \end{cases}
  \normalsize$$

The function $awards\colon B \to \mathbb{N}$ returns the number of contracts awarded to a given bidder.

$$awards(b) = \left\vert{c \in C : bidder(c) = b}\right\vert$$

We measured accuracy using hit rate at 10 (HR@10) and mean reciprocal rank at 10 (MRR@10).
HR@10 [@Deshpande2004, p. 159] is the share of queries for which hits are found in the top 10 results.
We consider hits to be the results that include the awarded bidder.
We adopted HR@10 as the primary metric that we aim to increase.
This metric can be calculated for the matchmaker $m$ as follows:

$$HR@10 = \frac{\left\vert{c \in C : bidder(c) \in match_{m}(c) \land wrank(c) \leq 10}\right\vert}{\left\vert{C}\right\vert}$$ <!-- _b -->

MRR@10 [@Craswell2009] is the arithmetic mean of multiplicative inverse ranks.
Multiplicative inverse rank $mir\colon C \to \mathbb{Q}_{\ge 0}$ can be defined as such:

$$mir(c)=\begin{cases}
         \frac{1}{wrank(c)} & \text{if}\ bidder(c) \in match_{m}(c) \\
         0 & \text{nil}
       \end{cases}$$

This metric is used for evaluating systems where *"the user wishes to see one relevant document"* [@Craswell2009] and it is *"equivalent to Mean Average Precision in cases where each query has precisely one relevant document"* [@Craswell2009].
This makes it suitable for our evaluation setup, since for each query (i.e. a contract) we know only one true positive (i.e. the awarded bidder).
MRR@10 reflects how prominent the position of the hit is in the matchmaking results.
We aim to increase MRR@10, corresponding to a lower rank the hit has.
MRR@10 for the matchmaker $m$ can be defined as follows:

$$MRR@10 = \frac{1}{\left\vert{C}\right\vert}\sum_{c \in C} mir(c)$$ <!-- _b -->

The adopted metrics that go beyond accuracy include prediction coverage (PC), catalog coverage at 10 (CC@10), and long-tail percentage at 10 (LTP@10).
PC [@Herlocker2004, p. 40] measures the amount of items for which the evaluated system is able to produce recommendations.
We strive to increase PC to achieve a near-complete coverage.
PC for the matchmaker $m$ is defined as the share of queries for which non-empty results are returned.

$$PC = \frac{\left\vert{c \in C : match_{m}(c) \neq \varnothing}\right\vert}{\left\vert{C}\right\vert}$$ <!-- _b -->

CC@10 [@Ge2010, p. 258] reflects diversity of the recommended items.
Systems that recommend a limited set of items have a low catalog coverage, while systems that recommend diverse items achieve a higher catalog coverage.
We compute CC@10 for the matchmaker $m$ as the number of distinct bidders in the top 10 results for all contracts divided by the number of all bidders.

$$CC@10 = \frac{\left\vert{\bigcup_{c \in C} match_{m}(c)}\right\vert}{\left\vert{B}\right\vert}$$ <!-- _b -->

LTP@10 [@Adomavicius2012] is a metric of novelty, which is based on the distribution of the recommended items.
Concretely, it measures the share of items from the long tail in the matchmaking results.
If we sort bidders in descending order by the number of contracts awarded to them, the first bidders that account for 20 % of contract awards form the *short head* and the remaining ones constitute the *long tail*.
In case of the Czech public procurement data, 20 % of the awarded contracts concentrates among the 101 most popular bidders.
To avoid awarding contracts only to a few highly successful bidders, we aim to increase the recommendations from the long tail of bidders.
This is especially important for evaluation of the case-based matchmakers, which tend to favour the most popular bidders.
Let $(b_{1}, \dots, b_{n})$ be an n-tuple of all bidders $b_{i} \in B$, so that $(i > j) \implies awards(b_{i}) \geq awards(b_{j})$, so that the bidders are sorted in descending order by the number of contracts awarded to them. <!-- _b -->
The short head $SH$ of this ordered n-tuple can be then defined as:

$$SH = (b_{1},\dots,b_{e});\quad \textrm{so that}\, e : \sum_{k = 1}^{e - 1} awards(b_{k}) < \frac{\left\vert{C}\right\vert}{5} \leq \sum_{l = 1}^{e} awards(b_{l})$$ <!-- _b -->

$SH$ is delimited by the index $e$ of the bidder with the awards of whom the short head accumulates 20 % of all awarded contracts (i.e. $\frac{\left\vert{C}\right\vert}{5}$).
Long tail $LT$ is the complement of the short head ($LT = B \setminus SH$).
We then calculate LTP@10 for the matchmaker $m$ as follows:

$$LTP@10 = \frac{\sum_{c \in C} \left\vert{match_{m}(c) \cap LT}\right\vert}{\sum_{c \in C} \left\vert{match_{m}(c)}\right\vert}$$

<!--
We can also evaluate novelty in terms of time.
One way to assess novelty could be the average age of the recommended bidders.
We can compute the bidder's age from its establishment date.
The mean average age of the top 10 most popular bidders is 21.7 years.
The mean average age of all bidders is 17.5 years (median 19 years).
This is probably not such a large difference, since the maximum age is only
-->

<!-- Unused evaluation metrics -->

Due to our evaluation setup we avoided some of the usual metrics from information retrieval in general and from recommender systems in particular.
Both precision and recall have limited prediction power in our case, since only one true positive is known.
If we consider top 10 results only, precision would be either 1/10 or 0, while recall would either be 1 or 0.
This problem is known as class imbalance [@Christen2012].
Results with the status of non-match are much more prevalent in matchmaking than those with the status of match, which skews the evaluation measures that take non-matches into account.

<!-- Evaluation of statistical significance -->

We used Wilcoxon signed-rank test [@Rey2014] to evaluate the statistical significance of differences between the distributions of ranks produced by the evaluated matchmakers.
We chose it because we compare ranks for the whole dataset and this test is suited for paired samples from the same population.
Moreover, it does not require the compared samples to follow normal distribution, which is the case of the distributions of ranks.

### Results of SPARQL-based matchmakers

We chose SPARQL-based matchmaking via the `pc:mainObject` property without weighting as our baseline.
The developed matchmakers and configurations were assessed by comparing their evaluation results with the results obtained for the baseline configuration.
In this way, we assessed the progress beyond the baseline that various matchmaking factors were able to achieve.
We tested several factors involved in the matchmakers.
These factors included weighting, query expansion, aggregation functions, and data reduction.
All reported evaluation results are rounded to two decimal places.
The best results for each metric in each table are highlighted by using a bold font.

<!-- Blind matchmakers -->

As a starting point, we evaluated the blind matchmakers described in the [@sec:blind-matchmakers].
Results of their evaluation are summarized in the [@tbl:blind-matchmakers].
Since these matchmakers ignore the query contract, they are able to produce matches for any contract, and thus score the maximum PC.
They cover the extremes of the diversity spectrum.
On the one hand, the random matchmaker can recommend any bidder, most of whom come from the long tail.
On the other hand, recommending the top winning bidders yields the lowest possible catalog coverage, the intersection of which with the long tail is empty by definition.
Since 7 % of contracts is awarded to the top 10 most winning bidders, recommending them produces the same HR@10.
Recommending the bidders that score the highest page rank is not as successful as simply recommending the top winning bidders, achieving an HR@10 of 0.03.

Matchmaker               HR@10   MRR@10    CC@10       PC   LTP@10
--------------------- -------- -------- -------- -------- --------
Random                    0.00     0.00 **1.00** **1.00** **0.99**
Top winning bidders   **0.07** **0.03**     0.00 **1.00**     0.00
Top page rank bidders     0.03     0.01     0.00 **1.00**     0.80

Table: Evaluation of blind matchmakers {#tbl:blind-matchmakers}

<!-- There are also papers that consider multiple baselines, such as [@Garcin2014]. -->

<!-- Aggregation functions -->

We evaluated the aggregation functions from the [@sec:aggregation-functions].
The functions were applied to matchmaking via the `pc:mainObject` property with the weight of 0.6.
This weight was chosen in order to allow the differences between the functions to manifest.
For instance, if we used the weight of 1, Łukasiewicz's aggregation would not distinguish between bidders who won one matching contract and those who won more.
The results of this comparison are shown in the [@tbl:norms-conorms].
Product aggregation clearly outperforms the other functions in terms of accuracy, even though it does so at a cost of diminished diversity.
Both Gödel's and Łukasiewicz's aggregation functions do not learn sufficiently from the extent of matched data.
Similar findings were obtained in our previous work in @Mynarz2015.
This outcome led us to use the product aggregation in all other matchmakers we evaluated.

Aggregation function    HR@10   MRR@10    CC@10       PC   LTP@10
-------------------- -------- -------- -------- -------- --------
Gödel                    0.18     0.07 **0.60** **0.98**     0.83
Product              **0.25** **0.12**     0.57 **0.98**     0.68
Łukasiewicz              0.16     0.07     0.58 **0.98** **0.86**

Table: Evaluation t-norms and t-conorms {#tbl:norms-conorms}

<!-- Individual features -->

As we described in the [@sec:contract-objects], we used several properties that describe contract objects.
We evaluated these properties separately, without weighting, to determine their predictive powers.
Evaluation results of the matchmakers based on the four considered properties are given in the [@tbl:properties-evaluation].
The best-performing property is the `pc:mainObject`.
As the [@fig:cumulative-hr] illustrates, its HR@k grows logarithmically with $k$, starting at 7 % chance of finding the contact's winner as the first hit.
We chose this property as our baseline that we tried to improve further on.
The other properties achieved worse results.
While the `pc:additionalObject` better covers the long tail, its prediction coverage is low because it is able to produce matches only for the few contracts that are described with this property.
The `pc:kind` fails in diversity metrics, covering only a minute fraction of the bidders.
Since there are only few distinct kinds of contracts in our dataset, this property is unable to sufficiently distinguish bidders and thus concentrates only on recommending the most popular ones.
The weak performance of the `isvz:serviceCategory` may be attributed to its limit to contracts for services.

Property                  HR@10   MRR@10    CC@10       PC   LTP@10
---------------------- -------- -------- -------- -------- --------
`pc:mainObject`        **0.25** **0.12** **0.57**     0.98     0.68
`pc:additionalObject`      0.07     0.04     0.38     0.36 **0.69**
`pc:kind`                  0.10     0.04     0.00 **0.99**     0.00
`isvz:serviceCategory`     0.09     0.04     0.04     0.80     0.28

Table: Evaluation of individual properties {#tbl:properties-evaluation}

![HR@k for `pc:mainObject`](img/evaluation/cumulative_hr.png){#fig:cumulative-hr}

Having evaluated the properties individually we examined whether their combinations could perform better.
We combined the properties with the baseline property `pc:mainObject`, using a reduced weight of 0.1 for the added properties.
Besides the properties evaluated above, we also experimented with including the qualifiers of CPV concepts described in the [@sec:cpv].
Evaluation results of the matchmakers based on the combinations of properties are presented in [@tbl:combined-properties].
None of the properties produced a synergistic effect with `pc:mainObject`.
If there was an improvement, it was not practically meaningful.
We also experimented with a larger range of weights for the combination with `pc:additionalProperty`, however, none of the weights led to a significant difference in the evaluation results.
Our conclusion is in line with Maidel et al., who found in similar circumstances that *"the inclusion of item concept weights does not improve the performance of the algorithm"* [-@Maidel2008, p. 97].

------------------------------------------------------------------------
Property                    HR@10    MRR@10     CC@10       PC    LTP@10
------------------------ -------- --------- --------- -------- ---------
`pc:additionalObject`        0.25      0.12  **0.57**     0.99      0.65

`pc:kind`                    0.16      0.08      0.09     1.00      0.14

`isvz:serviceCategory`       0.20      0.09      0.39     0.99      0.37

Qualifier                    0.25  **0.12**      0.57     0.98  **0.69**

`pc:additionalObject`,   **0.25**      0.12      0.56     0.99      0.64
qualifiers

`pc:additionalObject`,       0.15      0.07      0.09 **1.00**      0.13
`pc:kind`,
`isvz:serviceCategory`
------------------------------------------------------------------------

Table: Evaluation of combined properties {#tbl:combined-properties}

<!-- Query expansion -->

Apart from using combinations of properties, we can also extend the baseline matchmaker via query expansion, as documented in [@sec:query-expansion].
We evaluated the expansion to related CPV concepts connected via hierarchical relations, both in the direction to broader concepts, to narrower concepts, or in both directions.
The query expansion followed a given maximum number of hops in these directions.
Following too many hops to related concepts can introduce noise [@DiNoia2012a], so we weighted the concepts inferred by query expansion either by a fixed inhibition or by a weight derived from their IDF.
The results of experiments with query expansion are gathered in the [@tbl:query-expansion].
Expansion to broader concepts was able to improve on the accuracy metrics slightly, although the difference was too small to be meaningful.
Overall, we found that introducing query expansion led only to minuscule changes in the performance of the baseline matchmaker.

Broader Narrower Weight    HR@10   MRR@10    CC@10       PC   LTP@10
------- -------- ------ -------- -------- -------- -------- --------
      1        0      1     0.25     0.12     0.51     0.99     0.67
      1        0    0.5     0.25     0.12     0.53     0.99     0.67
      1        0    0.1     0.26     0.13     0.56     0.99     0.68
      2        0    0.1     0.26     0.13     0.55     0.99     0.67
      3        0    0.1     0.26     0.13     0.52 **1.00**     0.65
      1        0    IDF     0.25     0.12     0.57     0.98     0.68
      2        0    IDF     0.25     0.12     0.57     0.98     0.68
      3        0    IDF     0.25     0.12     0.57     0.98 **0.68**
      0        1      1     0.25     0.12     0.53     0.98     0.68
      0        1    0.5     0.25     0.12     0.55     0.98     0.68
      0        1    0.1     0.25     0.13 **0.57**     0.98     0.68
      0        2    0.1     0.25     0.13     0.57     0.98     0.68
      0        3    0.1     0.25     0.13     0.56     0.98     0.68
      0        1    IDF     0.25     0.13     0.57     0.98     0.68
      0        2    IDF     0.25     0.13     0.57     0.98     0.68
      0        3    IDF     0.25     0.13     0.57     0.98     0.68
      1        1    0.1 **0.26** **0.13**     0.56     0.99     0.68
      1        1    IDF     0.25     0.12     0.57     0.98     0.68

Table: Evaluation of matchmakers using query expansion {#tbl:query-expansion}

<!-- Data reduction -->

We evaluated the impact of data reduction on HR@10 for the baseline matchmaker and the blind matchmaker that constantly recommends the top winning bidders.
Prior to running the evaluation we reduced the number of links between contracts and bidders to a given fraction.
For example, if the level of data reduction was set to 0.4, 60 % of the links were removed.
Links to remove were selected randomly.
The [@fig:data-reduction] shows HR@10 per level of data reduction for the two compared matchmakers.
In general, we decreased the data reduction level by 0.1 for each evaluation run, but a smaller step was used for the lower levels to better distinguish the impact of data reduction at smaller data sizes.
The evaluation showed that HR@10 grows logarithmically with the size of the data, while the blind matchmaker performs the same no matter the data size.
As can be expected, the baseline matchmaker improves its performance as the data it learns from accrues.
Both approaches suffer from the cold start problem, although the baseline matchmaker improves rapidly with the initial data growth and demonstrates diminishing returns as data becomes larger.

![HR@10 per level of data reduction](img/evaluation/data_reduction.png){#fig:data-reduction}

<!-- Data refinement -->

Of the data refinement steps undertaken, as described in the [@sec:transformation], we evaluated what impact better deduplication and mapping CPV 2003 to CPV 2008 had on the baseline matchmaker.
Both steps improved the evaluation results of the matchmaker, as can be seen in the [@tbl:data-refinement].
Better deduplication and fusion of bidders reduces the search space of possible matches, so that the probability of finding the correct match increases.
Mapping CPV 2003 to CPV 2008 enlarges the dataset the matchmaker can learn from by 15.31 %, accounting for older contracts described by CPV 2003.
However, while HR@10 improves after this mapping, CC@10 decreases, which may be explained by more data affirming the few established bidders.
Better deduplication improves the accuracy metrics only slightly, which may be due to the original data already being free of most duplicates.
Nevertheless, in our prior work [@Mynarz2015], deduplication produced the greatest improvement in the evaluation of the baseline matchmaker.

Dataset                          HR@10   MRR@10    CC@10       PC   LTP@10
----------------------------- -------- -------- -------- -------- --------
Prior to CPV 2003 mapping         0.24     0.12 **0.60**     0.93     0.80
Prior to better deduplication     0.25     0.12     0.55     0.96 **0.86**
Final                         **0.25** **0.12**     0.57 **0.98**     0.68

Table: Impact of data refinement on the baseline matchmaker {#tbl:data-refinement}

<!-- Counter-measures -->

We evaluated two approaches devised as counter-measures to address the limits of our ground truth.
One of them weighted contract awards by the zIndex fairness score of the contracting authority, the other limited the training dataset to contracts awarded in open procedures.
The proposed counter-measures were not successful.
Both approaches fared worse than our baseline, as documented in the [@tbl:counter-measures-evaluation].
While the impact of weighting by zIndex is barely noticeable, the restriction to open procedures decreased the observed metrics.
The decrease may be attributed to the smaller size of training data, even though the majority of the contracts in our dataset were awarded via an open procedure.

Matchmaker                          HR@10   MRR@10    CC@10       PC   LTP@10
-------------------------------- -------- -------- -------- -------- --------
`pc:mainObject`                  **0.25** **0.12** **0.57** **0.98**     0.68
`pc:mainObject`, zIndex              0.24     0.12     0.57 **0.98**     0.69
`pc:mainObject`, open procedures     0.21     0.11     0.47     0.96 **0.70**

Table: Evaluation of counter-measures to limits of the ground truth {#tbl:counter-measures-evaluation}

In conclusion, rather than improving on the baseline matchmaker, we managed to analyze what makes it perform well.
It benefits mostly from refining and extending the training data and from using the product aggregation function.
Other extensions of the baseline matchmaker were found to have no practical benefits.

<!--
### Out-takes:

*"Offline evaluations use pre-compiled offline datasets from which some information has been removed. Subsequently, the recommender algorithms are analyzed on their ability to recommend the missing information"* [~Beel2013, p. 8].

This is more about online evaluation:

Moreover, the limitations of the chosen ground truth have to be considered with respect to the internal validity of the proposed design of the offline evaluation.
Internal validity in the context of recommender systems can be defined as the *"extent to which the effects observed are due to the controlled test conditions (e.g., the varying of a recommendation algorithm's parameters) instead of differences in the set of participants (predispositions) or uncontrolled/unknown external effects"* [@Jannach2010, p. 168].

*"External validity refers to the extent to which results are generalizable to other user groups or situations"*  [@Jannach2010, p. 168]

Unused evaluation metrics:

http://videolectures.net/eswc2014_di_noia_linked/?q=di%20noia
The task 2 of the challenge used F1-measure @ top 5.
The evaluation of task 3 on diversity is evaluated using intra-list diversity (ILD) with only dcterms:subject and dbo:author. We can also restrict the ILD to few properties (or property paths).

User coverage: a share of bidders for which the system is able of recommending contracts.
-->

<!--
### Results for Elasticsearch-based matchmakers

### Results for RESCAL-based matchmakers

- Add discussion of sensitivity to hyperparameters?
  - Higher rank typically leads to better models.
-->
