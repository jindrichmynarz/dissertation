## Results of SPARQL-based matchmakers

We chose SPARQL-based matchmaking via the `pc:mainObject` property without weighting as our baseline.
The developed matchmakers and configurations were assessed by comparing their evaluation results with the results obtained for the baseline configuration.
In this way, we assessed the progress beyond the baseline that various matchmaking factors were able to achieve.
We tested several factors involved in the matchmakers.
These factors included weighting, query expansion, aggregation functions, and data reduction.

### Blind matchmakers

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

### Aggregation functions

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

### Individual features

As we described in the [@sec:contract-objects], we used several properties that describe contract objects.
We evaluated these properties separately, without weighting, to determine their predictive power.
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

![HR@k for `pc:mainObject`](img/evaluation/cumulative_hr.png){#fig:cumulative-hr width=75%}

### Combined features

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

### Query expansion

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

### Data reduction

We evaluated the impact of data reduction on HR@10 for the baseline matchmaker and the blind matchmaker that constantly recommends the top winning bidders.
Prior to running the evaluation we reduced the number of links between contracts and bidders to a given fraction.
For example, if the level of data reduction was set to 0.4, 60 % of the links were removed.
Links to remove were selected randomly.
The [@fig:data-reduction] shows HR@10 per level of data reduction for the two compared matchmakers.
In general, we decreased the data reduction level by 0.1 for each evaluation run, but a smaller step was used for the lower levels to better distinguish the impact of data reduction at smaller data sizes.
The evaluation showed that HR@10 grows logarithmically with the size of the data, while the blind matchmaker performs the same no matter the data size.
As can be expected, the baseline matchmaker improves its performance as the data it learns from accrues.
Both approaches suffer from the cold start problem, although the baseline matchmaker improves rapidly with the initial data growth and demonstrates diminishing returns as data becomes larger.

![HR@10 per level of data reduction](img/evaluation/data_reduction.png){#fig:data-reduction width=75%}

### Data refinement

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

### Counter-measures to limits of ground truth 

We evaluated two approaches devised as counter-measures to address the limits of our ground truth.
One of them weighted contract awards by the zIndex fairness score of the contracting authority, the other limited the training dataset to contracts awarded in open procedures.
The proposed counter-measures were not successful.
Both approaches fared worse than our baseline, as documented in the [@tbl:counter-measures-evaluation].
While the impact of weighting by zIndex is barely noticeable, the restriction to open procedures decreased the observed metrics.
The decrease may be attributed to the smaller size of training data, even though the majority of the contracts in our dataset were awarded via an open procedure.

-----------------------------------------------------------------------------
Matchmaker                          HR@10   MRR@10    CC@10       PC   LTP@10
-------------------------------- -------- -------- -------- -------- --------
`pc:mainObject`                  **0.25** **0.12** **0.57** **0.98**     0.68
`pc:mainObject`, zIndex              0.24     0.12     0.57 **0.98**     0.69
`pc:mainObject`, open procedures     0.21     0.11     0.47     0.96 **0.70**
-----------------------------------------------------------------------------

Table: Evaluation of counter-measures to limits of the ground truth {#tbl:counter-measures-evaluation}

In conclusion, rather than improving on the baseline matchmaker, we managed to analyze what makes it perform well.
It benefits mostly from refining and extending the training data and from using the product aggregation function.
Other extensions of the baseline matchmaker were found to have no practical benefits.
Simply put, the evaluation indicated that *"simple models and a lot of data trump more elaborate models based on less data"* [@Halevy2009, p. 9].

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