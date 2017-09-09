### Results of RESCAL-based matchmakers

<!--
The approach for exploring the space of configurations of RESCAL-based matchmakers was similar to the one used for SPARQL-based matchmakers.

A heuristic/method of tuning the hyper-parameters: informed/guided grid search?

Since we do not using any threshold for RESCAL-based matchmakers, their prediction coverage is always maximum.
Consequently, we omit it from the evaluation results.

Note that RESCAL has a greater degree of non-determinism, so that its evaluation results have greater variance.

#### Random baseline

Is it a meaningful baseline?
Or should we instead use only the `pc:mainObject` as the baseline, similarly to the SPARQL-based matchmakers?
-->

#### Hyper-parameters

As reported in literature, RESCAL's accuracy improves with increasing rank of the factorization.
With higher ranks we observe diminishing returns and, ultimately, the accuracy ceases to improve at around rank 500. 

![HR@10 per rank](img/evaluation/hrs_per_rank.png){#fig:hrs-per-rank}

<!--
Initialization methods: random, eigenvalues
Regularization parameters: lambda A, lambda R
- best found by [@Kuchar2016]: both 0.01
- best found by [@Padia2016]: lambda A = 10, lambda R = 0.2
- We found that relatively high values of the regularization parameters tend to achieve the best results. We set both lambda A and lambda R to be 10.
Rank
- Higher rank typically leads to better models. We tested ranks 10 to 1000.
Omit setting maximum iterations or maximum residual? (We used the default values.)

- Add discussion of sensitivity to hyperparameters?

#### Feature selection

`pc:mainObject`
`pc:additionalObject`
`pc:mainObject` + `skos:broaderTransitive` (approximating query expansion)
`pc:kind`
`isvz:serviceCategory`
`rov:orgActivity`
`rov:orgActivity` + `skos:broaderTransitive`

Actual prices (i.e. `pc:actualPrice`) are known for 91.5 % of contracts in the evaluated dataset.

Overall, the RESCAL-based matchmakers produce results with very low diversity, especially when considering their CC@10.

#### Ageing

If there is no improvement or a decrease in performance, it might be explainable by noisy data about prices.
Prices may be reported as coefficients to be multiplied by an implicit factor that is not part of the structured data. 
-->
