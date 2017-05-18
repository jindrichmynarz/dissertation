## SPARQL

The initial version of the SPARQL-based matchmaker was introduced in [@Mynarz2014b].
[@Mynarz2015] covers an improved version of the matchmaker.
The hereby described version is thus the third iteration of the matchmaker.

Matchmaking public contract to suitable bidders starts with retrieving similar contracts awarded in the past.
For each awarded contract a similarity score is computed and the contracts are grouped by bidders that won them.
Scores of each group are aggregated and sorted in descending order.
In this way, matchmaking uses both semantic and statistical properties of data on which it operates.
While the semantics of contracts' descriptions is employed in similarity measurement, the aggregation of scores reflects the statistics about past participation of bidders in public procurement [@AlvarezRodriguez2013, p. 122]. 

<!-- SPARQL: benefits & drawbacks -->

We chose SPARQL [@Harris2013] as a native way of processing RDF data using the RDF data model.
This technological choice has both benefits and drawbacks for use in matchmaking.

SPARQL operates directly on indices of RDF databases, so there is no need to pre-process data or build a model.
Thanks to this feature, SPARQL can answer matchmaking queries in real time.
In particular, having this property is useful for recommendations from streaming data.
Such requirement is to a certain degree also present in the public procurement domain because its data becomes quickly obsolete due to its currency bound on fixed deadlines for tender submission. 

Since the matchmaker is limited to the standard SPARQL without proprietary addons or extension functions, it is portable across RDF stores compliant with the SPARQL specifications.
The implementation of our matchmaker bases exclusively on querying a SPARQL endpoint without any previous data     preprocessing.
Our tool can thus be easily deployed by any public administration exposing its data via a SPARQL endpoint with no further tool or service needed.

The matchmakers suffer from the curse of dimensionality.
RDF data is typically complex and contains many dimensions.
Linear increase of dimensions leads to exponential growth of negative effects.

Since SPARQL retrieves exact matches, their ranking needs to be implemented on top of SPARQL.

While RDF stores in general suffer from performance penalty compared to relational databases, recent advancements in the application of column store technology for RDF data brought large performance improvements [@Boncz2014, p. 23].
Yet, in order to get the best performance of SPARQL, the matchmaker is limited to exact joins.
Fuzzy joins over literal ranges or overlapping substrings significantly decrease the matchmaker's performance and are therefore avoided.

The benefits of SPARQL come with costs.
As Maali [-@Maali2014, p. 57] writes, the pure declarative nature of SPARQL implies high evaluation cost and requires *"users to express their needs in a single query"*.
This is why the matchmaker employs a single-shot approach.
As it does not have a conversational interface with which users can iteratively refine their query, if no suitable match is found, users need to revise their query and start again, even though they may not be able to provide a detailed query from the start.
Moreover, due to its SPARQL basis the matchmaker employs materialize-then-sort query execution scheme [Magliacane2012, p. 345], which implies that matchmaker needs to compute scores for all matched solutions prior to sorting them even though only top $k$ matches are retrieved.

<!--
Materialization trade-offs
Fixed data may be materialized.
For instance, IDFs of CPV may be pre-computed.
-->

### Weighing

We adjust scores of matches by multiplying them with weights.

### Query expansion

We expand CPV concepts by following hierarchical relations in the CPV.
We follow either links to narrower concepts via `skos:narrowerTransitive`, to broader concepts via `skos:broaderTransitive`, or in both directions.

### Aggregation functions

<!--
Aggregation of weights, similarities
Contract similarities adjusted by weights
-->

Aggregation of multiple "sequential" weights over an inferential path: it is "fuzzy-conjunctive" and can be modelled as *t-norms*.

Aggregation of multiple "parallel" weights affecting an inferential node: it is thus "fuzzy-disjunctive" and can be viewed as *t-conorms*.

Product ($a*b$) and probabilistic sum ($a+b-a*b$) are the most commonly used types of t-norm and t-conorm,         respectively.
However, probabilistic sum requires aggregation by multiplication, which cannot be implemented directly in SPARQL  since it lacks an operator to multiply grouped bindings.
Therefore, we implemented the aggregation via post-processing of SPARQL results.
Eventually, since the difference on the evaluated metrics between the probabilistic sum and summation ($a + b$)    turned out to be statistically insignificant, we opted for summation, which can be computed in SPARQL and is       marginally faster.

We also experimented with alternative t-norms and t-conorms: Gödel's and Łukasiewicz's methods [@Beliakov2007, p. 27].

<!--
Fuzzy logic
Approximate reasoning
-->

Combination of weights in matchmaking can be framed in terms of fuzzy logic.
Here, triangular norms (t-norms) generalize logical conjunction and triangular conorms (t-conorms or s-norms) generalize logical disjunction.

T-norms:

* Minimum or Gödel's t-norm: $T_{M}(x, y) = min(x, y)$
* Product t-norm: $T_{P}(x, y) = x \cdot y$
* Łukasiewicz's t-norm: $T_{L}(x, y) = max(x + y - 1, 0)$

T-conorms:

* Maximum or Gödel's t-conorm: $S_{M}(x, y) = max(x, y)$
* Product t-conorm or probabilistic sum: $S_{P}(x, y) = x + y - x \cdot y$
* Łukasiewicz's t-conorm or bounded sum: $S_{L}(x, y) = min(x + y, 1)$

### Non-personalized matchmaking

<!-- FIXME: Is "non-personalized" a correct term for these approaches? -->

We also implemented three non-personalized approaches for matchmaking.
We call these approaches non-personalized because none of them considers the query contract.
The most basic is the random matchmaker that recommends bidders at random.
While it is hardly going to deliver a competitive accuracy, it produces diverse results.
An approach opposite to random matchmaking is the recommendation of the top-most popular bidders.
For each contract this matchmaker recommends the same bidders that were awarded the most contracts.
A similar approach is employed in a matchmaker that recommends the bidders with the highest score on a PageRank-like algorithm implemented in the Virtuoso-specific `IRI_RANK` [@Virtuoso2017].
Since it uses a proprietary extension of SPARQL, this is an exception from the limitations to standard SPARQL.
We use these conceptually and computationally simpler approaches as baselines to which we can contrast the more sophisticated matchmakers.

### Implementation

The matchmaker is implemented using SPARQL query templates.
Each template receives a configuration and produces a SPARQL query.
The generated queries are executed on the configured SPARQL endpoint and return ordered sets of matches.
Each kind of matchmaker corresponds to a query template.
It may also expose specific parameters that can be provided via the configuration. 

We implement query expansion via SPARQL 1.1 property paths.

The basic graph pattern considered in most configurations of the matchmaker is illustrated in [@lst:property-path] using the SPARQL 1.1 Property Path syntax.

```{#lst:property-path caption="Matchmaker's SPARQL property path"}
?queryCFT (pc:mainObject|pc:additionalObject)/
  (skos:broaderTransitive|skos:narrowerTransitive)*/
  ^(pc:mainObject|pc:additionalObject)/
  pc:awardedTender/pc:bidder ?matchedBidder .
\end{lstlisting}
```

The actual implementation of the matchmaker in SPARQL is based on nested sub-queries and `VALUES` clauses used to associate the considered properties with weights.
Score aggregation is done using SPARQL 1.1 aggregates.
Matchmaker source code is available in a public repository^[<https://github.com/jindrichmynarz/matchmaker-sparql>] licensed as open source under the terms of Eclipse Public License.
Example SPARQL queries used by the matchmaker can be found at <https://github.com/opendatacz/matchmaker/wiki/SPARQL-query-examples>.

<!--
Comparison of CBR systems with databases in [@Richter2013, p. 524].
SPARQL operates under the closed world assumption. CBR assumes open world.

Combination functions [@Beliakov2007], [@Beliakov2015]

Refer to [@Maidel2008] in the discussion of setting the weights of expanded concepts.
Maidel showed that weighting concepts (e.g., by TF-IDF) does not have an impact.

Diversity of results is often low in case-based recommenders based on similarity-based retrieval.
There are several strategies to mitigate this issue:
- Bounded greedy selection: minimizes total similarity in the result set, while maximizing total similarity of the result set to the query.
-->

<!--
Use a more content-based approach (leveraging data from ARES) for cold-start users (i.e. those without an awarded contract)?
Alternative solutions:
* Users may subscribe to recommendations for other users. For example, they may be asked to list their competitors, who were awarded public contracts, and be subscribed to their recommendations.
* Ask users to rate a sample of public contracts either as relevant or irrelevant. The sample must be chosen in order to maximize the insight learnt from the rating, e.g., the sample should be generated dynamically to increase its overall diversity.
-->
