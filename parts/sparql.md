## SPARQL

<!--
Is the matchmaker based on correlations between bidders and CPV concepts?
-->

The SPARQL-based matchmaker employs a case-based reasoning approach that learns from contracts awarded in the past.
For each awarded contract a similarity score is computed and the contracts are grouped by bidders who won them.
Scores of each group are aggregated and sorted in descending order.
In this way, the matchmaker uses both semantic and statistical properties of data on which it operates.
While the semantics of contracts' descriptions is employed in similarity measurement, the aggregation of scores reflects the statistics about past participation of bidders in public procurement [@AlvarezRodriguez2013, p. 122].

<!-- The publication activity around the matchmaker is inessential.
It should therefore not start this section. -->

The initial version of the SPARQL-based matchmaker was introduced in [@Mynarz2014b].
Our subsequent publication [@Mynarz2015] covers an improved version of the matchmaker.
The hereby described version is thus the third iteration of the matchmaker.

### Benefits and drawbacks

This matchmaker explores the use of SPARQL [@Harris2013] for matchmaking.
We introduced SPARQL in [@sec:linked-data].
The choice of this technology for matchmaking has both benefits and drawbacks.

#### Benefits

<!-- Nativeness -->

SPARQL is a native way of querying and manipulating RDF data.
As it is designed for RDF, it is based on graph pattern matching.
Graph patterns in SPARQL are based on data in the Turtle syntax [@Beckett2014] extended with variables.
Consequently, there is little impedance mismatch between data and queries, which improves developer productivity.

<!-- Universality -->

The design of SPARQL makes it into a universal tool for working with RDF.
Thanks to its expressivity and declarative formulation it can be used for many varied tasks.
For example, besides matchmaking we also adopted it as our primary tool for data preparation, as described in [@sec:data-preparation].

<!-- Standardization -->

SPARQL is a standard [@Harris2013], so most RDF stores support it.
The matchmaker can thus be set up simply by loading data into an RDF store.
Since the matchmaker is limited to the standard SPARQL without proprietary add-ons or extension functions, it is portable across RDF stores compliant with the SPARQL specifications.
As such it is not tied to any single RDF store vendor.

<!-- Real-time -->

SPARQL operates directly on indices of RDF databases, so there is no need to pre-process data or build a machine learning model.
In terms of recommender systems, we can consider it a memory-based approach.
Thanks to this feature, SPARQL can answer matchmaking queries in real time.
In particular, this is useful for recommendations from streaming data.
Public procurement data shares some of the characteristics of streaming data as it becomes quickly obsolete due to its currency bound on fixed deadlines for tender submission.

#### Drawbacks

The benefits of SPARQL come with costs.
As Maali [-@Maali2014, p. 57] writes, the pure declarative nature and expressivity of SPARQL implies a high evaluation cost.
RDF stores in general suffer from a performance penalty when compared to relational databases.
Nevertheless, recent advancements in the application of the column store technology for RDF data achieved large performance improvements [@Boncz2014, p. 23].
SPARQL also lends itself to advanced query optimization that can avoid much of the performance costs.

<!-- Limitation to exact matches -->

In order to get the best performance of SPARQL, the matchmaker is limited to joins based on exact matches.
SPARQL supports just exact matches.
Exact matches can distinguish only between identical and non-identical resources.
Fuzzy matches are needed to differentiate the degrees of similarity between resources.
However, fuzzy matches have to be implemented on top of the default graph pattern matching in SPARQL.
For example, the `FILTER` clauses can match partially overlapping strings or numbers within a given distance.
SPARQL is not designed to perform such matches efficiently.
Although SPARQL engines can optimize fuzzy matches, e.g., by using additional indices for literals, if literals are not indexed, they have to be analysed at query time, which incurs a significant performance penalty for the queries employing fuzzy matches.

<!-- Materialize-then-sort -->

Performance of the matchmaker is also degraded by the unnecessary work SPARQL does for top-$k$ queries.
SPARQL employs the materialize-then-sort query execution scheme [@Magliacane2012, p. 345], which implies that the matchmaker needs to compute scores for all matched solutions prior to sorting them, even though only top $k$ matches are retrieved.
Matchmaking in SPARQL depends on aggregations and sorting, both of which are examples of operations called the pipeline breakers in the query execution model.
Such operations prevent lazy execution, since they require their complete input to be realized.
For example, SPARQL treats sorting as a result modifier, which needs to be provided with all results.

### Ranking

SPARQL queries retrieve exact matches satisfying the query conditions.
Since SPARQL can tell only matches from non-matches, the degrees to which matches satisfy the query are unknown.
Ranking of matches thus needs to be implemented on top of SPARQL.
We need to relax the match conditions to avoid filtering partial matches, and then compute scores to rank the matches.

The matchmaker retrieves contract objects that overlap with the object of the query contract, which is optionally expanded to include related CPV concepts.
Components of contract objects are weighted and these weights are combined into a contract similarity score.
Contract similarities are aggregated per bidder to produce bidder's match score.

Contract objects describe what products or services are sought by the contracts.
There are many ways how a contract object can be described.
However, due to the above-mentioned limitation of SPARQL to exact matches, the matchmaker is restricted to descriptions via object properties.
It leverages terms from controlled vocabularies, such as CPV or the code list of contract kinds.
Concretely, the matchmaker can use CPV concepts, either as main or additional objects or their qualifiers (`pc:mainObject`, `pc:additionalObject`), contract kinds (`pc:kind`), and service categories (`isvz:serviceCategory`).
<!-- Contract objects can be represented as collections of weights. -->

The scoring function $mscore\colon C \times B \to \mathbb{R}_{\ge 0}$ can defined as

$$mscore(c_{q}, b) = agg(\sum_{c \in C : bidder(c) = b} sim(c_{q}, c))$$ {#eq:mscore}

where $c_{q}$ is the query contract, $b$ is a bidder, $agg$ is an aggregation function, and $sim$ is a contract similarity metric ($sim\colon C \times C \to \mathbb{R}_{\ge 0}$).
The similarity scores in the matchmaker are not normalized.
The following sections cover the operations involved in computing the $mscore$.

<!--
$sim(c_{1}, c_{2}) = obj(c_{1}) \cap obj(c_{2})$
-->
<!-- FIXME: This is already mentioned in the section on weighting. -->
<!--
Contract similarity may be adjusted by zIndex.
We experimented with weighting contract similarity by zIndex of the matched contract's contracting authority.

$sim(c_{q}, c) \cdot zindex(c)$

* $o_{q}$: object of the query contract
* $o_{c}$: object of the matched contract

$exp(o_{q}) \bowtie o_{c}$
-->

#### Query expansion

We expand CPV concepts by following hierarchical relations in the CPV.
We follow either links to narrower concepts via `skos:narrowerTransitive` ([@fig:expand-to-narrower]), links to broader concepts via `skos:broaderTransitive` ([@fig:expand-to-broader]), or links in both directions.
Both figures illustrating the query expansion show expansions to two-hop neighbourhoods of the CPV concepts.

![Expansion to narrower concepts](img/expand_to_narrower.png){#fig:expand-to-narrower}

![Expansion to broader concepts](img/expand_to_broader.png){#fig:expand-to-broader}

<!--
FIXME: How explicit we want to be? Should be pass the direction of the expansion and the number of hops explicitly? -->
Query expansion can be defined as $exp\colon \mathbb{P}(O_{CPV}) \to \mathbb{P}(O_{CPV})$.
When no expansion is used, $exp$ is the identity function, which simply returns its argument.
Query expansion can be parameterized by the maximum number of hops followed to obtain a graph neighbourhood of the expanded concept.

#### Weighting

We adjust the scores computed by the matchmaker by multiplying them with weights defined as $w \in \mathbb{R} : 0 < w \leq 1$.
Some weights are given by data or derived from it, others can be provided as configuration to the matchmaker.
We apply weights to different kinds of relations and objects in the data.

Several weights can be applied to relations between contracts and CPV concepts.
We weight concept relations instead of the concepts directly, since the same concept may be present more than once in a contract's object.
For example, we can use query expansion to infer a concept that is already explicitly assigned to a contract.
This weighting scheme allows us to distinguish concepts associated by different relations.
For example, concepts may be linked by distinct properties or they may be either stated explicitly or inferred via query expansion.

There are several concrete ways in which weights can be applied to CPV concepts.
The matchmaker may apply an inhibiting weight to de-emphasize the concepts associated with contracts via the `pc:additionalObject` property.
These weights are applied both to associations with the query contract and those with the matched contracts.
Similarly, qualifying concepts from the CPV's supplementary vocabulary can be discounted by a lower weight.
Concepts inferred by query expansion can be weighted either by a fixed inhibition or their inverse document frequency (IDF).

Inverse document frequency is used to de-emphasize the impact of popular CPV concepts on matchmaking.
Unlike infrequent and specific concepts, the popular ones may have lesser discriminative power to determine the relevance of contracts described by them.
IDF ($idf\colon O_{CPV}$) is computed as follows:

$idf(o) = \log\frac{\left\vert{C}\right\vert}{1 + \left\vert{\{c \in C : o \in c\}}\right\vert}$

The denominator in the formula is incremented by 1 to avoid division by zero.
Subsequently, we scale IDF into the interval $(0, 1]$ in order to be able to use it as weight.

$idf'(o) = \frac{idf(o)}{max(\{o' \in O_{CPV} : idf(o')\})}$

Besides CPV, weights can be applied to objects of specific properties.
In particular, the matchmaker can inhibit the objects of `pc:kind` when used in combination with CPV.
This property indicates kinds of contracts, such as works or supplies, which classify contracts into broad categories.
The matchmaker also allows to weight contracts indirectly via weights of their contracting authorities.
We use zIndex scores as weights of contracting authorities.
These scores are taken from the dataset described in [@sec:zindex].

#### Aggregation functions

Aggregation functions take multiple numeric inputs and combine them into a single output.
The matchmaker uses these functions to combine weights and partial similarity scores to form a match score.
As such, aggregation functions constitute an important part of ranking.
In terms of fuzzy logic, aggregation functions can be interpreted as generalizations of logical conjunction and disjunction.
Instead of only boolean values, their inputs can be treated as degrees of probability, where 0 indicates impossibility and 1 indicates certainty.
Aggregation function $f$ can thus be defined as $f \colon \left[0, 1\right]^{n} \to \left[0, 1\right]$ [@Beliakov2015, p. 785].
The typical examples of these functions are triangular norms (t-norms) and conorms (t-conorms).
T-norms generalize conjunction and t-conorms generalize disjunction.
The basic t-norms can be defined as follows [@Beliakov2015, p. 792]:

* Gödel's t-norm (minimum t-norm): $T_{min}(x, y) = min(x, y)$
* Product t-norm: $T_{P}(x, y) = x \cdot y$
* Łukasiewicz's t-norm: $T_{L}(x, y) = max(x + y - 1, 0)$

We use these t-norms to combine weights.
The basic t-conorms, complementary to the t-norms, are the following:

* Gödel's t-conorm (maximum t-conorm): $S_{max}(x, y) = max(x, y)$
* Product t-conorm (probabilistic sum): $S_{P}(x, y) = x + y - x \cdot y$
* Łukasiewicz's t-conorm (bounded sum): $S_{L}(x, y) = min(x + y, 1)$

We use these t-conorms to aggregate contract similarities into the match scores of bidders.

### Non-personalized matchmaking

Apart from the above-described matchmaker, we also implemented three non-personalized approaches for matchmaking.
We call these approaches non-personalized because none of them considers the query contract.
The most basic is the random matchmaker that recommends bidders at random.
While it is hardly going to deliver a competitive accuracy, it produces diverse results.
An approach contrary to random matchmaking is the recommendation of the top-most popular bidders.
For each contract this matchmaker recommends the same bidders that were awarded the most contracts.
A similar approach is employed in the matchmaker that recommends bidders with the highest score computed by the PageRank-like algorithm implemented by the Virtuoso-specific `IRI_RANK` [@Virtuoso2017].
Since this score uses a proprietary extension of SPARQL, it is an exception from our constraint to standard SPARQL.
These conceptually and computationally simpler approaches are used as baselines to which we can contrast the more sophisticated ones in evaluation.

### Implementation

The matchmaker is implemented using SPARQL query templates.
Each template receives a configuration and produces a SPARQL query.
The generated queries are executed on the configured SPARQL endpoint and return ordered sets of matches.
Each kind of matchmaker corresponds to a query template.
It may also expose specific parameters that can be provided via the configuration.

The basic graph pattern considered in most configurations of the matchmaker is illustrated in [@lst:property-path] using the SPARQL 1.1 Property Path syntax.
The path is complicated by intermediate resources proxying CPV concepts connected via `skos:closeMatch`, as described in [@sec:concrete-data-model].

```{#lst:property-path caption="Matchmaker's basic SPARQL property path"}
?queryContract ^pc:lot/pc:mainObject/skos:closeMatch/
               ^skos:closeMatch/^pc:mainObject/pc:lot/
               pc:awardedTender/pc:bidder ?matchedBidder .
```

Apart from our baseline matchmaker, which uses the property path in [@lst:property-path], the implementation of the matchmakers is based on nested sub-queries and `VALUES` clauses used to associate the considered properties with weights.

We implemented query expansion via SPARQL 1.1 property paths.
Property paths allow us to retrieve concepts reachable within a given maximum number of hops transitively following the hierarchical relations in CPV.
We use the short-hand notation `{1, max}` for these property paths.
It defines a graph neighbourhood at most `max` hops away.
This notation is not a part of the SPARQL standard, but it is formally defined by Seaborne [-@Seaborne2014], and several RDF stores, including Virtuoso, support it.
However, it can be rewritten to the more verbose standard SPARQL notation if full standards-compliance is required.

Score aggregation via aggregation functions is done using SPARQL 1.1 aggregates.
However, probabilistic sum requires aggregation by multiplication, which cannot be implemented directly in SPARQL since it lacks an operator to multiply grouped bindings.
Therefore, we implemented this aggregation function via post-processing of SPARQL results.
Eventually, since the difference on the evaluated metrics between probabilistic sum and summation ($a + b$)    turned out to be statistically insignificant, we opted for summation, which can be computed in SPARQL and is       marginally faster.

<!-- Optimization -->

The execution time of the matchmaker can be improved by common optimization techniques for SPARQL.
We reordered triple patterns in the matchmaking queries in order to minimize cardinality of the intermediate results.
We reduced unnecessary intermediate bindings via blank nodes and property paths.
Performance can be also enhanced by materialization of pre-computed data.
While there is no need for data pre-processing, derived data that changes infrequently can be materialized and stored in RDF.
Doing so can improve performance by avoiding the need to recompute the derived data at query time.
This benefit is offset by increased use of storage space and an overhead with updates, since materialized data has to be recomputed when the data it is derived from changes.
We used materialization for pre-computing inverse document frequencies (IDF) of CPV concepts.
While IDF can be computed on the fly, we decided to pre-compute it and store it as RDF.
Computation of IDF is implemented via two declarative SPARQL Update operations, the first of which uses a Virtuoso-specific extension function for logarithm (`bif:log10()`), and the second normalizes the IDFs using the maximum IDF.

The matchmaker's source code is available in a public repository^[<https://github.com/jindrichmynarz/matchmaker-sparql>] licensed as open source under the terms of the Eclipse Public License 1.0.
Example SPARQL queries used by the matchmaker can be found at <https://github.com/opendatacz/matchmaker/wiki/SPARQL-query-examples>.

<!--
TODO: Add a diagram showing the technology stack involved in the matchmaker. 
-->

<!--
Out-takes:

Resources in an RDF graph can be considered similar if their neighbourhoods are similar.
This leads to iterative computation and propagation of similarities through the RDF graph.
That is not what SPARQL is suited for.
-->
