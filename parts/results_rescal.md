## Results of RESCAL-based matchmakers

The approach for exploring the space of configurations of RESCAL-based matchmakers was similar to the one used for SPARQL-based matchmakers.
We started with `pc:mainObject` as the principal feature and examined what improvement can be achieved via adjustments of hyper-parameters, combination with additional features, or other treatments.
The adopted heuristic for tuning the matchmakers' performance can be considered a manually guided grid search.
Note that RESCAL exhibits a greater degree of non-determinism than the SPARQL-based method, so that its evaluation results have greater variance.

We measured the same evaluation metrics for the RESCAL-based matchmakers as for the SPARQL-based ones.
Since we do not use any threshold for RESCAL-based matchmakers, their prediction coverage is always maximum.
Consequently, we omit this metric from the evaluation results.

### Hyper-parameters

The central hyper-parameter of RESCAL is the rank of its decomposition.
As reported in literature, RESCAL's accuracy improves with increasing rank of the factorization.
With higher ranks we observe diminishing returns and, eventually, HR@10 ceases to improve at around rank 500, as the [@fig:hrs-per-rank] displays.
An analogous impact can be observed for CC@10, although its growth is much more subtle.
We tested ranks ranging from 10 to 1000, using smaller intervals for greater resolution in low ranks.
Runtime of tensor factorization with RESCAL increases approximately linearly with the rank, so there is a need to balance the quality of RESCAL's results with the available time to compute them.

![HR@10 and CC@10 per rank](img/evaluation/hrs_per_rank.png){#fig:hrs-per-rank}

We observed that performance improves with rank only for more selective properties, e.g., `pc:mainObject`.
Properties that have fewer distinct values, such as `pc:kind`, reach their peak performance already at lower ranks.

<!--
Initialization methods: random, eigenvalues
- Do we need to discuss them?
- We should probably do experiments with the baseline `pc:mainObject` showing the impact of different initialization methods.

Omit setting maximum iterations or maximum residual? (We used the default values.)
-->

RESCAL allows to tune its generalization ability via the regularization parameters *lambda A* for the latent factor matrix $A$ and *lambda R* for the tensor $R$ that captures the interactions of the latent components.
Increasing the amount of regularization helps avoid overfitting.
Optimal values of the regularization parameters are dataset-specific.
While @Padia2016 achieved the best results with *lambda A* = 10 and *lambda R* = 0.2, @Kuchar2016 obtained the peak performance by setting both to 0.01. 
In our case, we found that relatively high values of the regularization parameters tend to achieve the best results.
We set both *lambda A* and *lambda R* to be 10.

<!--
- Add discussion of sensitivity to hyperparameters?
-->

### Feature selection

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

Time series cross-validation

### Literals

Actual prices (i.e. `pc:actualPrice`) are known for 91.5 % of contracts in the evaluated dataset.

If there is no improvement or a decrease in performance, it might be explainable by noisy data about prices.
Prices may be reported as coefficients to be multiplied by an implicit factor that is not part of the structured data. 

<!-- Summary -->

Overall, the RESCAL-based matchmakers produce results with very low diversity, especially when considering their CC@10.
They tend to recommend the same bidders repeatedly. 

<!--
TODO: Add a comparison of the best-performing configurations of SPARQL-based and RESCAL-based matchmakers.
-->
