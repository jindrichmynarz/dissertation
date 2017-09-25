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
With higher ranks we observe diminishing returns and, eventually, HR@10 ceases to improve at around rank 500, as the [@fig:hrs-per-rank] displays.
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
A comparison of a few selected values of the regularization parameters is shown in the [@tbl:regularization-parameters] for `pc:mainObject` at rank 50.

$\lambda_{A}$ $\lambda_{R}$     HR@10    MRR@10     CC@10    LTP@10
------------- ------------- --------- --------- --------- ---------
            0             0     0.049     0.024 **0.016** **0.493**
         0.01          0.01     0.066     0.028      0.01     0.272
           10           0.2     0.077     0.032     0.006     0.163
           10            10 **0.081** **0.032**     0.006     0.049
           20            20     0.081     0.032     0.006     0.042

Table: Evaluation of regularization parameters {#tbl:regularization-parameters}

The remaining hyper-parameters exposed by RESCAL include initialization methods and convergence criteria.
RESCAL can initialize the latent matrices either randomly or by eigenvalues of the input tensor, the latter method being clearly superior, as shown in the [@tbl:initialization-methods] for `pc:mainObject` at rank 50.
RESCAL stops when it reaches the given convergence criteria, which can be specified either as the maximum number of iterations or as the maximum residual.
We used the default values for these hyper-parameters.

Initialization method     HR@10    MRR@10     CC@10   LTP@10
--------------------- --------- --------- --------- --------
Random                    0.002     0.001     0.003    **1**
Eigenvalues           **0.081** **0.032** **0.006**    0.049

Table: Evaluation of initialization methods {#tbl:initialization-methods}

### Feature selection

<!-- Individual features -->

We evaluated the predictive power of descriptive features that can be obtained from our dataset.
We started by assessing the results of the individual features.
We combined each feature with the ground truth comprising contract awards and observed how well it can help predicting the awarded bidders.

<!-- Link the improvement gained by increasing rank to higher selectivity of the evaluated properties? -->

<!-- `pc:mainObject` + additional features -->

As in evaluation of the SPARQL-based matchmakers, we adopted `pc:mainObject` as our pivot feature that we combined with additional features.
Our next step after evaluating the features separately was thus to see how they perform in combination with `pc:mainObject`.

<!-- Larger combinations of features -->

Ultimately, we considered using larger sets of features including those that improved the results of `pc:mainObject` when combined with it.

<!--
`pc:mainObject`
`pc:additionalObject`
`pc:mainObject` + `skos:broaderTransitive` (approximating query expansion)
`pc:kind`
`isvz:serviceCategory`
`rov:orgActivity`
`rov:orgActivity` + `skos:broaderTransitive`
-->

### Ageing

Evaluation of ageing was done by time series cross-validation, as described in the [@sec:evaluation-protocol].

Ageing was applied to the tensor slice containing links between public contracts and awarded bidders, as described in the [@sec:loading-rescal].

<!--
Compare `pc:mainObject` normal and aged, in both cases using time series cross-validation, at ranks 50 and 500.
The main difference is in the mode of cross-validation.
Time series cross-validation achieves much lower results than n-fold cross-validation even when no ageing is used.
This can be explained in part by lower volume of training data.
However, it may hint a bug in the evaluation protocol.
-->

### Literals

<!--
Actual prices (i.e. `pc:actualPrice`) are known for 91.5 % of contracts in the evaluated dataset.
-->

If there is no improvement or a decrease in performance, it might be explainable by noisy data about prices.
Prices may be reported as coefficients to be multiplied by an implicit factor that is not part of the structured data.

<!-- Summary -->

<!--
TODO: Add a comparison of the best-performing configurations of SPARQL-based and RESCAL-based matchmakers.
-->