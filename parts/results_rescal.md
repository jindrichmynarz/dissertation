## Results of RESCAL-based matchmakers

The approach for exploring the space of configurations of RESCAL-based matchmakers was similar to the one used for SPARQL-based matchmakers.
We started with `pc:mainObject` as the principal feature and examined what improvements can be achieved via adjustments of hyper-parameters, combinations with additional features, or other treatments.
The adopted heuristic for tuning the matchmakers' performance can be considered a manually guided grid search.
Note that RESCAL exhibits a greater degree of non-determinism than the SPARQL-based method, so that its evaluation results have greater variance.

We measured the same evaluation metrics for the RESCAL-based matchmakers as for the SPARQL-based ones.
Since we do not use any threshold for the RESCAL-based matchmakers, their prediction coverage is always maximum.
Consequently, for brevity, we omit this metric from the evaluation results.

### Hyper-parameters

The central hyper-parameter of RESCAL is the rank of its decomposition.
As reported in existing research, RESCAL's accuracy improves with increasing rank of the factorization.
With higher ranks we observe diminishing returns and, eventually, HR@10 ceases to improve at around rank 500, as [Fig. @fig:hrs-per-rank] displays.
An analogous impact can be observed for CC@10, although its growth is much more subtle.
We tested ranks ranging from 10 to 1000, using smaller intervals for greater resolution in low ranks.
Runtime of tensor factorization with RESCAL increases approximately linearly with the rank, so there is a need to balance the quality of RESCAL's results with the available time to compute them.

![HR@10 and CC@10 per rank](resources/img/evaluation/hrs_per_rank.png){#fig:hrs-per-rank}

We observed that performance improves with rank only for more selective properties, e.g., `pc:mainObject`.
Properties that have fewer distinct values, such as `pc:kind`, reach their peak performance already at lower ranks.

RESCAL allows to tune its generalization ability via the regularization parameters $\lambda_{A}$ for the latent factor matrix $A$ and $\lambda_{R}$ for the tensor $R$ that captures the interactions of the latent components.
Increasing the amount of regularization helps avoid overfitting.
Optimal values of the regularization parameters are dataset-specific.
While @Padia2016 achieved the best results with $\lambda_{A} = 10$ and $\lambda_{R} = 0.2$, @Kuchar2016 obtained the peak performance by setting both to 0.01.
In our case, we found that relatively high values of the regularization parameters tend to achieve the best results.
We set both $\lambda_{A}$ and $\lambda_{R}$ to be 10.
A comparison of a few selected values of the regularization parameters is shown in [Table @tbl:regularization-parameters] for `pc:mainObject` at rank 50.

$\lambda_{A}$ $\lambda_{R}$     HR@10    MRR@10     CC@10    LTP@10
------------- ------------- --------- --------- --------- ---------
            0             0     0.049     0.024 **0.016** **0.493**
         0.01          0.01     0.066     0.028      0.01     0.272
           10           0.2     0.077     0.032     0.006     0.163
           10            10 **0.081** **0.032**     0.006     0.049
           20            20     0.081     0.032     0.006     0.042

Table: Evaluation of regularization parameters {#tbl:regularization-parameters}

The remaining hyper-parameters exposed by RESCAL include initialization methods and convergence criteria.
RESCAL can initialize the latent matrices either randomly or by eigenvalues of the input tensor, the latter method being clearly superior, as shown in [Table @tbl:initialization-methods] for `pc:mainObject` at rank 50.
RESCAL stops when it reaches the given convergence criteria, which can be specified either as the maximum number of iterations or as the maximum residual.
We used the default values for these hyper-parameters.

Initialization method     HR@10    MRR@10     CC@10   LTP@10
--------------------- --------- --------- --------- --------
Random                    0.002     0.001     0.003    **1**
Eigenvalues           **0.081** **0.032** **0.006**    0.049

Table: Evaluation of initialization methods {#tbl:initialization-methods}

In the further experiments, we use rank 500, $\lambda_{A}$ and $\lambda_{R}$ set to 10, unless specified otherwise.

### Feature selection

<!-- Individual features -->

We evaluated the predictive power of the descriptive features that can be obtained from our dataset.
While most features correspond to RDF properties, some are derived from property paths, such as `pc:location/schema:address` or `pc:awardCriteriaCombination/pc:awardCriterion/pc:weightedCriterion`, which we shorten as `pc:weightedCriterion`.
We started by assessing the results of matchmakers based on the individual features.
We combined each feature with the ground truth comprising contract awards and observed how well the feature can help predict the awarded bidders.
We evaluated the HR@10 of selected features at ranks 50 and 500, as shown in [Fig. @fig:properties-per-rank].

![HR@10 per rank for individual properties](resources/img/evaluation/properties_per_rank.png){#fig:properties-per-rank}

Out of the features `pc:mainObject` obtained the best results.
Higher rank improves the results of most features, such as `pc:mainObject`, `pc:contractingAuthority`, or `isvz:serviceCategory`.
However, increasing rank has the inverse effect on other features, including `pc:procedureType`, `pc:actualPrice`, or `isvz:mainCriterion`.
We observed that features for which higher rank improves the evaluation results have higher cardinality, while the converse is usually true for features with low cardinality.
Here, cardinality is the number of distinct values a feature has in a dataset.
For instance, the cardinalities of the mentioned features for which results improve with the increased rank are 4588, 16982, and 43; whereas the cardinalities of the respective features that exhibit the inverse are 10, 15, and 4.
These observations suggest that higher rank can rearch better resolution if provided with a feature having a higher cardinality.
Conversely, RESCAL cannot leverage a higher rank if given a feature with low cardinality, in which case its latent features capture noise instead of informative distinctions.
Nevertheless, high cardinality does not imply good results, such as in case of `pc:weightedCriterion` that has 27793 distinct values in our dataset, yet achieves poor results.

Feature                         HR@10    MRR@10     CC@10    LTP@10
---------------------------- -------- --------- --------- ---------
`ares:zivnost`                  0.002         0     0.015     0.952
`isvz:mainCriterion`            0.075     0.031     0.009     0.048
`isvz:serviceCategory`          0.096     0.036     0.014     0.392
`pc:actualPrice`                0.078     0.028     0.013     0.083
`pc:additionalObject`           0.048     0.021     0.016     0.669
`pc:contractingAuthority`       0.137     0.064      0.02     0.202
`pc:kind`                       0.121     0.051     0.009     0.003
`pc:location/schema:address`    0.045     0.016     0.014     0.116
`pc:mainObject`              **0.17** **0.077**      0.02     0.211
`pc:procedureType`              0.071     0.021     0.009     0.012
`pc:weightedCriterion`          0.019     0.007     0.017     0.753
`rov:orgActivity`               0.001         0 **0.022** **0.995**

Table: Evaluation of individual features {#tbl:individual-features}

Results of all evaluation metrics for the individual features as listed in [Table @tbl:individual-features].
The `pc:mainObject` property clearly stands out with the best results of the accuracy metrics.
Although the properties of bidders, i.e. `ares:zivnost` and `rov:orgActivity`, achieve the best results for the diversity metrics, their poor accuracy is comparable to the results of random matchmaking.

<!-- `pc:mainObject` + additional features -->

As in the evaluation of the SPARQL-based matchmakers, we adopted `pc:mainObject` as our pivot feature that we combined with additional features.
After we evaluated the features separately our next step was thus to see how they perform in combination with `pc:mainObject`.
The evaluation results of these feature pairs are shown in [Table @tbl:additional-features].
In case of `rdf:type` we included the links to classes of public contracts and bidders.
The `skos:broaderTransitive` property adds the hierarchical relations in CPV, thus emulating the query expansion described in [Section @sec:query-expansion].
The `skos:related` property brings in the qualifying concepts from the supplementary vocabulary of CPV.^[In order to be able to qualify the CPV concepts proxy concepts were used instead of directly linking the concepts from contracts as in the other evaluated cases.]
We achieved the best improvement in all evaluated metrics with the `rov:orgActivity` property that associates bidders with concepts from the NACE classification in the Business Register, as covered in [Section @sec:ares].

Additional feature               HR@10    MRR@10     CC@10    LTP@10
---------------------------- --------- --------- --------- ---------
`ares:zivnost`                   0.171     0.078     0.023      0.17
`isvz:mainCriterion`             0.152     0.069     0.022     0.075
`isvz:serviceCategory`           0.172     0.076     0.021     0.212
`pc:additionalObject`            0.175     0.079     0.021     0.177
`pc:contractingAuthority`        0.171 **0.083**     0.023     0.215
`pc:kind`                        0.163     0.073      0.02     0.122
`pc:location/schema:address`     0.172     0.078      0.02     0.139
`pc:procedureType`               0.157     0.071     0.023      0.08
`pc:weightedCriterion`           0.164     0.075     0.021     0.121
`rdf:type`                       0.154     0.069     0.013     0.068
`rov:orgActivity`            **0.187** **0.083** **0.036** **0.295**
`skos:broaderTransitive`         0.174     0.079     0.021     0.156
`skos:related`                   0.173     0.078      0.02     0.176

Table: Evaluation of `pc:mainObject` and additional features {#tbl:additional-features}

<!-- Larger combinations of features -->

Ultimately, we examined a larger set of features that improved the results of `pc:mainObject` when combined with it one by one.
We tested separately a subset of the improving features that involved only the links to subject classifications via `pc:mainObject`, `pc:additionalObject` and `rov:orgActivity`, together with the hierarchical relations in both CPV and NACE represented via the `skos:broaderTransitive` property.
Evaluation results for both combinations of additional features are presented in [Table @tbl:combinations-features].

---------------------------------------------------------------------
Additional features               HR@10    MRR@10     CC@10    LTP@10
----------------------------- --------- --------- --------- ---------
`pc:additionalObject`,        **0.182** **0.081** **0.044** **0.311**
`rov:orgActivity`,
`skos:broaderTransitive`

`ares:zivnost`,                   0.125     0.065     0.017     0.208 
`isvz:serviceCategory`,
`pc:additionalObject`,
`pc:contractingAuthority`,
`pc:location/schema:address`,
`rov:orgActivity`,
`skos:broaderTransitive`
---------------------------------------------------------------------

Table: Evaluation of `pc:mainObject` and combinations of features {#tbl:combinations-features}

The subset of subject classifications fared better than indiscriminate inclusion of all improving features.
Yet still this combination of features did not surpass the evaluation results of `pc:mainObject` combined just with `rov:orgActivity`.
The worse results scored by the combinations of features individually improving the `pc:mainObject` baseline invalidate our assumption that the contributions of features do not cancel themselves out.
To the contrary, this interplay illustrates that the contributions of the individual features are not cumulative, and, in fact, some features diminish the contribution of other features.

The directionality of relations in the input tensor matters for RESCAL.
We examined this characteristic using the `rov:orgActivity` property.
In the source data, `rov:orgActivity` is a property of bidders associating them with NACE concepts.
We found out that the evaluation results differ widely if the domain of this property changes.
Apart from its directionality in the source data, we evaluated the cases in which the property is directly attached to contracts and when it is symmetric.
As can be seen in [Table @tbl:directionality], the symmetric option decidedly outperforms the others.
Nevertheless, treating relations as symmetric does not always lead to an improvement, as in the case of `pc:mainObject` when the symmetric interpretation worsens the evaluation results.

Domain of `rov:orgActivity`     HR@10    MRR@10     CC@10    LTP@10
--------------------------- --------- --------- --------- ---------
Bidder                          0.001         0     0.022 **0.995**
Contract                        0.003     0.001     0.015     0.951
Bidder and contract         **0.137** **0.105** **0.086**     0.656

Table: Evaluation of directionality of `rov:orgActivity` {#tbl:directionality}

### Ageing relations

Evaluation of ageing was done by time series cross-validation, as described in [Section @sec:evaluation-protocol].
Ageing was applied to the tensor slice containing links between public contracts and awarded bidders, which we covered in [Section @sec:loading-rescal].
We compared how ageing affects matchmaking with the `pc:mainObject` property. 
As shown in [Table @tbl:ageing], there is no significant observable difference when ageing is applied.
When compared to `pc:mainObject` evaluated using the n-fold cross-validation, the results in time series cross-validation are notably worse, which can be attributed to the lower amount of data available in this evaluation protocol.

Configuration            HR@10   MRR@10     CC@10    LTP@10
--------------------- -------- -------- --------- ---------
`pc:mainObject`       **0.07** **0.03** **0.013** **0.185**
`pc:mainObject`, aged **0.07** **0.03** **0.013** **0.185**

Table: Evaluation of ageing {#tbl:ageing}

### Use of literals

We experimented with a limited use of literals, namely via discretization of the actual prices of contracts, represented by the `pc:actualPrice` property, which we split into 15 equifrequent intervals having approximately the same number of members.
Actual prices were known for 91.5 % of contracts in the evaluated dataset.
We combined the discretized actual prices with `pc:mainObject`.
A comparison of the combination with `pc:mainObject` only is shown in [Table @tbl:discretization-actual-price].
Adding actual prices mostly worsens the evaluation results.
We surmise that the decrease can be explained by noisy data about prices.
Upon manual inspection, we found that prices may be reported as coefficients to be multiplied by an implicit factor that is not part of the structured data.

Features                             HR@10    MRR@10     CC@10    LTP@10
--------------------------------- -------- --------- --------- ---------
`pc:mainObject`                   **0.17** **0.077**      0.02 **0.211**
`pc:mainObject`, `pc:actualPrice`    0.155      0.07 **0.025**     0.086

Table: Evaluation of adding discretized actual prices {#tbl:discretization-actual-price}

<!-- Summary -->
