## Results of SPARQL-based matchmakers

We chose SPARQL-based matchmaking via the `pc:mainObject` property without weighting as our baseline.
The developed matchmakers and configurations were assessed by comparing their evaluation results with the results obtained for the baseline configuration. <!-- "hill climbing" -->
In this way, we assessed the progress beyond the baseline that various matchmaking factors were able to achieve.
We tested several factors involved in the matchmakers.
These factors included weighting, query expansion, aggregation functions, and data reduction.

### Blind matchmakers

As a starting point, we evaluated the blind matchmakers described in [Section @sec:blind-matchmakers].
The results of their evaluation are summarized in [Table @tbl:blind-matchmakers].
Since these matchmakers ignore the query contract, they are able to produce matches for any contract, and thus score the maximum PC.
They cover the extremes of the diversity spectrum.
On the one hand, the random matchmaker can recommend practically any bidder, most of whom come from the long tail.
On the other hand, recommending the top winning bidders yields the lowest possible catalog coverage, the intersection of which with the long tail is empty by the definition of this matchmaker.
Since 7 % of contracts is awarded to the top 10 most winning bidders, recommending them produces the same HR@10.
Recommending the bidders that score the highest page rank is not as successful as simply recommending the top winning bidders, achieving an HR@10 of 0.03.

Matchmaker               HR@10   MRR@10    CC@10       PC    LTP@10
--------------------- -------- -------- -------- -------- ---------
Random                   0.001        0    **1**    **1** **0.992**
Top winning bidders   **0.07** **0.03**    0.001    **1**         0
Top page rank bidders     0.03    0.007    0.001    **1**      0.80

Table: Evaluation of blind matchmakers {#tbl:blind-matchmakers}

<!-- There are also papers that consider multiple baselines, such as [@Garcin2014]. -->

### Aggregation functions

We evaluated the aggregation functions from [Section @sec:aggregation-functions].
In each case, we used the t-norm and t-conorm from the same family, e.g., the Gödel's t-norm was used with the Gödel t-conorm.
The functions were applied to matchmaking via the `pc:mainObject` property with the weight of 0.6.
This weight was chosen in order to allow the differences between the functions to manifest.
For instance, if we used the weight of 1, Łukasiewicz's aggregation would not distinguish between bidders who won one matching contract and those who won more.
The results of this comparison are shown in [Table @tbl:norms-conorms].
Product aggregation clearly outperforms the other functions in terms of accuracy. 
Both Gödel's and Łukasiewicz's aggregation functions do not learn sufficiently from the extent of matched data.
Similar findings were obtained in our previous work in @Mynarz2015.
This outcome led us to use the product aggregation in all other matchmakers we evaluated.

Aggregation functions     HR@10    MRR@10     CC@10        PC    LTP@10
--------------------- --------- --------- --------- --------- ---------
Gödel                      0.18      0.07 **0.602** **0.978**     0.828
Product               **0.248** **0.124**     0.567 **0.978**     0.684
Łukasiewicz               0.159     0.068     0.582 **0.978** **0.858**

Table: Evaluation t-norms and t-conorms {#tbl:norms-conorms}

### Individual features

As we described in [Section @sec:contract-objects], we used several properties that describe contract objects.
We evaluated these properties separately, without weighting, to determine their predictive power.
Evaluation results of the matchmakers based on the four considered properties are given in [Table @tbl:properties-evaluation].
The best-performing property is the `pc:mainObject`.
As [Fig. @fig:cumulative-hr] illustrates, its HR@k grows logarithmically with $k$, starting at 7 % chance of finding the contact's winner as the first hit.
We chose this property as our baseline that we tried to improve further on.
The other properties achieved worse results.
While the `pc:additionalObject` covers the long tail better, its prediction coverage is low because it is able to produce matches only for the few contracts that are described with this property.
The `pc:kind` fails in diversity metrics, covering only a minute fraction of the bidders.
Since there are only few distinct kinds of contracts in our dataset, this property is unable to sufficiently distinguish the bidders and thus concentrates only on recommending the most popular ones.
The weak performance of the `isvz:serviceCategory` may be attributed to its limit to contracts for services.

Property                   HR@10    MRR@10     CC@10        PC   LTP@10
---------------------- --------- --------- --------- --------- --------
`pc:mainObject`        **0.248** **0.124** **0.567**     0.978    0.684
`pc:additionalObject`      0.073     0.035     0.384     0.359 **0.69**
`pc:kind`                  0.103     0.043     0.003 **0.993**        0
`isvz:serviceCategory`     0.094     0.042     0.036     0.797    0.282

Table: Evaluation of individual properties {#tbl:properties-evaluation}

![HR@k for `pc:mainObject`](resources/img/evaluation/cumulative_hr.png){#fig:cumulative-hr width=75%}

### Combined features

Having evaluated the properties individually we examined whether their combinations could perform better.
We combined the properties with the baseline property `pc:mainObject`, using a reduced weight of 0.1 for the added properties.
Besides the properties evaluated above, we also experimented with including the qualifiers of CPV concepts described in [Section @sec:cpv].
The evaluation results of the matchmakers based on the combinations of properties are presented in [Table @tbl:combined-properties].
None of the properties produced a synergistic effect with `pc:mainObject`.
If there was an improvement, it was not practically meaningful.
We also experimented with a larger range of weights for the combination with `pc:additionalProperty`, however, none of the weights led to a significant difference in the evaluation results.
Our conclusion is in line with Maidel et al., who found in similar circumstances that *"the inclusion of item concept weights does not improve the performance of the algorithm"* [-@Maidel2008, p. 97].

----------------------------------------------------------------------------
Property                    HR@10      MRR@10     CC@10        PC     LTP@10
------------------------ --------- ---------- --------- --------- ----------
`pc:additionalObject`        0.253      0.124  **0.57**      0.99      0.645

`pc:kind`                    0.162      0.075     0.092     0.996      0.144

`isvz:serviceCategory`       0.197      0.092     0.392     0.995      0.368

Qualifier                    0.249  **0.125**     0.568     0.978  **0.685**

`pc:additionalObject`,   **0.254**      0.123     0.557      0.99      0.639
qualifiers

`pc:additionalObject`,       0.154      0.072     0.088 **0.996**      0.129
`pc:kind`,
`isvz:serviceCategory`
----------------------------------------------------------------------------

Table: Evaluation of combined properties {#tbl:combined-properties}

### Query expansion

Apart from using combinations of properties, we can also extend the baseline matchmaker via query expansion, as documented in [Section @sec:query-expansion].
We evaluated the expansion to related CPV concepts connected via hierarchical relations, both in the direction to broader concepts, to narrower concepts, or in both directions.
The query expansion followed a given maximum number of hops in these directions.
Following too many hops to related concepts can introduce noise [@DiNoia2012a], so we weighted the concepts inferred by query expansion either by a fixed inhibition or by a weight derived from their IDF.
The results of the experiments with query expansion are gathered in [Table @tbl:query-expansion].
Here, ↑ denotes the number of hops expanded to the broader concepts and ↓ indicates the hops to the narrower concepts. 
Expansion to broader concepts was able to improve on the accuracy metrics slightly, although the difference was too small to be meaningful.
Overall, we found that introducing query expansion led only to minuscule changes in the performance of the baseline matchmaker.
For instance, expansion to broader concepts weighted by IDF produced results that differed only in higher decimal precision for the different numbers of hops followed.

↑ ↓ Weight     HR@10    MRR@10     CC@10        PC    LTP@10
- - ------ --------- --------- --------- --------- ---------
1 0      1     0.245     0.119      0.51      0.99      0.67
1 0    0.5     0.252     0.124     0.533      0.99     0.673
1 0    0.1     0.257     0.127     0.563      0.99     0.682
2 0    0.1     0.258     0.126     0.545     0.994     0.672
3 0    0.1     0.257     0.125     0.517 **0.996**      0.65
1 0    IDF     0.249     0.125     0.565     0.978 **0.684**
2 0    IDF     0.249     0.125     0.565     0.978 **0.684**
3 0    IDF     0.249     0.125     0.565     0.978 **0.684**
0 1      1     0.248     0.123     0.527     0.982     0.677
0 1    0.5     0.252     0.125     0.549     0.982     0.677
0 1    0.1     0.253     0.126 **0.569**     0.982     0.677
0 2    0.1     0.253     0.126     0.565     0.979     0.679
0 3    0.1     0.254     0.126     0.562     0.982     0.677
0 1    IDF     0.253     0.126     0.572     0.982 **0.684**
0 2    IDF     0.254     0.126     0.572     0.982      0.68
0 3    IDF     0.254     0.126     0.569     0.982     0.682
1 1    0.1 **0.259** **0.128**     0.563     0.991     0.678
1 1    IDF     0.249     0.125     0.565     0.978 **0.684**

Table: Evaluation of matchmakers using query expansion {#tbl:query-expansion}

### Data reduction

We evaluated the impact of data reduction on HR@10 for the baseline matchmaker and the blind matchmaker that constantly recommends the top winning bidders.
Prior to running the evaluation we reduced the number of links between contracts and bidders to a given fraction.
For example, if the level of data reduction was set to 0.4, 60 % of the links were removed.
Links to remove were selected randomly.
[Fig. @fig:data-reduction] shows HR@10 per level of data reduction for the two compared matchmakers.
In general, we decreased the data reduction level by 0.1 for each evaluation run, but a smaller step was used for the lower levels to better distinguish the impact of data reduction at smaller data sizes.
The evaluation showed that HR@10 grows logarithmically with the size of the data, while the blind matchmaker performs the same no matter the data size.
As can be expected, the baseline matchmaker improves its performance as the data it learns from accrues.
Both approaches suffer from the cold start problem, although the baseline matchmaker improves rapidly with the initial data growth and demonstrates diminishing returns as data becomes larger.

![HR@10 per level of data reduction](resources/img/evaluation/data_reduction.png){#fig:data-reduction width=75%}

### Data refinement

Of the data refinement steps undertaken, as described in [Section @sec:transformation], we evaluated what impact better deduplication and mapping CPV 2003 to CPV 2008 had on the baseline matchmaker.
Both steps improved the evaluation results of the matchmaker, as can be seen in [Table @tbl:data-refinement].
Better deduplication and fusion of bidders reduces the search space of possible matches, so that the probability of finding the correct match increases.
Mapping CPV 2003 to CPV 2008 enlarges the dataset the matchmaker can learn from by 15.31 %, accounting for older contracts described by CPV 2003.
However, while HR@10 improves after this mapping, CC@10 decreases, which may be explained by more data affirming the few established bidders.
Better deduplication improves the accuracy metrics only slightly, which may be due to the original data already being free of most duplicates.
Nevertheless, in our prior work [@Mynarz2015], deduplication produced the greatest improvement in the evaluation of the baseline matchmaker.

--------------------------------------------------------------------
Dataset                HR@10    MRR@10     CC@10        PC    LTP@10
------------------ --------- --------- --------- --------- ---------
Prior to CPV 2003      0.237      0.12 **0.595**     0.931     0.798
mapping 

Prior to better        0.245     0.121     0.554     0.955 **0.858**
deduplication 

Final              **0.248** **0.124**     0.567 **0.978**     0.684
--------------------------------------------------------------------

Table: Impact of data refinement on the baseline matchmaker {#tbl:data-refinement}

### Counter-measures to limits of ground truth 

We evaluated two approaches devised as counter-measures to address the limits of our ground truth, described in [Section @sec:ground-truth].
One of them weighted contract awards by the zIndex fairness score of the contracting authority, the other limited the training dataset to contracts awarded in open procedures.
The proposed counter-measures were not successful.
Both approaches fared worse than our baseline, as documented in [Table @tbl:counter-measures-evaluation].
While the impact of weighting by zIndex is barely noticeable, the restriction to open procedures decreased most of the observed metrics.
The decrease may be attributed to the smaller size of training data, even though the majority of contracts in our dataset were awarded via an open procedure.

-------------------------------------------------------------------------
Matchmaker                  HR@10    MRR@10     CC@10        PC    LTP@10
----------------------- --------- --------- --------- --------- ---------
`pc:mainObject`         **0.248** **0.124** **0.567** **0.978**     0.684

`pc:mainObject`, zIndex     0.243     0.121     0.566 **0.978**     0.687

`pc:mainObject`,            0.214     0.106     0.469     0.964 **0.702**
open procedures
-------------------------------------------------------------------------

Table: Evaluation of counter-measures to limits of the ground truth {#tbl:counter-measures-evaluation}

In conclusion, rather than improving on the baseline matchmaker, we managed to analyze what makes it perform well.
It benefits mostly from refining and extending the training data and from using the product aggregation function.
Other extensions of the baseline matchmaker were found to have no practical benefits.
Simply put, the evaluation indicated that *"simple models and a lot of data trump more elaborate models based on less data"* [@Halevy2009, p. 9].
