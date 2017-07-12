## Offline evaluation

<!--
FIXME: Do we basically do grid search? Configuration can be considered as hyperparameters. We are basically trying to find the most important (sensitive) hyper-parameters.
Idea: distribution of the predicted bidders should be equal to the distribution of the bidder frequencies. (Suggested in <https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/43146.pdf>.)

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
<!-- To avoid overlaps between the folds we sorted the divided contract awards by IRIs of contracts. (Unnecessary detail?) -->

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

### Evaluation results

We chose SPARQL-based matchmaking using exact matches via CPV without weighting as our baseline.
The developed matchmaking methods and configurations were assessed by comparing their evaluation results with the results obtained for the baseline configuration.
In this way, we measured the progress beyond the baseline that various matchmaking factors were able to achieve.

We test several factors involved in the matchmakers.
These factors include weighting, query expansion, aggregation functions, and data reduction.

<!-- Weighting -->

<!--
*"the inclusion of item concept weights does not improve the performance of the algorithm"* [@Maidel2009, p. 97].
-->

<!-- Query expansion
Too many hops to broader concepts introduce noise [@DiNoia2012a].
-->

<!-- Aggregation functions -->

<!--
Refer to [@Mynarz2015] for tests of Gödel's and Łukasiewicz's t-norms and t-conorms.
There is no need to replicate these findings.
-->

<!-- Data reduction -->

<!--
Data reduction ~ cold start problem.
-->

<!-- Non-personalized matchmakers -->

<!--
There are also papers that consider multiple baselines, such as [@Garcin2014].
-->

<!-- Evaluation results for countermeasures to limits of our ground truth:
* Weighting by zIndex
* Learning from contracts awarded in open procedures only.
  The majority of the Czech public contracts actually use an open procedure.
-->

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

Other baselines:

* Exact match via CPV
* Recommend most awarded bidders constantly
* Recommend random bidders
* Recommend bidders with highest PageRank
-->
