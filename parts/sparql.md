## SPARQL

The SPARQL-based matchmaker employs a case-based reasoning approach that learns from contracts awarded in the past.
For each awarded contract a similarity score is computed and the contracts are grouped by bidders who won them.
Scores of each group are aggregated and sorted in descending order.
In this way, the matchmaker uses both semantic and statistical properties of data on which it operates.
While the semantics of contracts' descriptions is employed in similarity measurement, the aggregation of scores reflects the statistics about past participation of bidders in public procurement [@AlvarezRodriguez2013, p. 122].

<!-- The publication activity around the matchmaker is inessential.
It should therefore not start this section. -->

The initial version of the SPARQL-based matchmaker was introduced in [@Mynarz2014b].
Our subsequent publication [@Mynarz2015] covers an improved version of the matchmaker.
The hereby described version is thus the third iteration of the matchmaker with extended configurability.

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

The matchmaker operates with a given query contract $c_{q}$, which is matched to contracts from the set $C$. <!-- _b -->
It retrieves contract objects that overlap with the object of the query contract, which are optionally expanded to include related CPV concepts.
Components of contract objects are weighted and these weights are combined into partial similarity scores.
Partial similarities are then aggregated per bidder to produce bidder's match score.

#### Contract objects {#sec:contract-objects}

Contract objects describe what products or services are sought by contracts.
There are many ways how a contract object can be described.
The matchmaker leverages contract objects described by terms from controlled vocabularies, such as CPV or the code list of contract kinds.
Concretely, the matchmaker can use CPV concepts, either as main or additional objects or their qualifiers (`pc:mainObject`, `pc:additionalObject`), contract kinds (`pc:kind`), and service categories (`isvz:serviceCategory`).
Consequently, we define the set of properties $P = \{\texttt{pc:mainObject}, \texttt{pc:additionalObject}, \texttt{pc:kind}, \texttt{isvz:serviceCategory}\}$ that associate concepts with contracts.
The range of each of these properties is enumerated by a controlled vocabulary.
We define the union of concepts in these vocabularies as $Con = Con_{CPV} \cup Con_{kind} \cup Con_{\substack{service \\ category}}$. <!-- _b -->
A concept can be either explicitly assigned to a contract or inferred via query expansion.
To capture this distinction we use concept assignment $ConA = \{\text{explicit}, \text{inferred}\}$.
Contract object $cobj$ is then a tuple $((con, p), cona) \colon con \in Con, p \in P, cona \in ConA$, in which a concept $con$ is paired with property $p$ that associates the concept to a contract and this pair is qualified with concept assignment $cona$.
Contract objects are represented as sets $Cobj$ of these tuples.
In order to obtain contract objects we use the function $obj \colon C \cup \left\{c_{q}\right\} \to \mathbb{P}(Cobj)$. <!-- _b -->
Here, $\mathbb{P}(Cobj)$ denotes the powerset of the set $Cobj$.
Accessing the elements of contract objects is in turn done by function $ccobj(cobj) = con \iff cobj = ((con, p), cona)$ for concepts and by function $pcobj(cobj) = p \iff cobj = ((con, p), cona)$ for properties.

#### Query expansion {#sec:query-expansion}

The controlled vocabularies that describe contract objects can be semantically structured, such as via hierarchical or associative relations.
Since relevance of a concept may entail relevance of concepts in its neighbourhood, we can leverage the structure of these vocabularies and perform expansion to include the related concepts in the query.
In particular, we expand CPV concepts by following transitive hierarchical relations in this vocabulary.
We follow either links to narrower concepts via `skos:narrowerTransitive`, links to broader concepts via `skos:broaderTransitive`, or links in both directions.
Query expansion can be parameterized by the maximum number of hops followed to obtain a graph neighbourhood of the expanded concept.
When a concept is expanded, its inferred concepts include those that are one to the maximum hops away from the expanded concept.
Note that it is possible to infer a concept already included in the explicitly assigned concepts when these are hierarchically related.
In such case, the concept appears twice in the contract object, distinguished by its concept assignment.
Similarly, the same inferred concept can be reached more times by expanding different concepts.
Such concept is present once in the results of query expansion since the results form a set.
Figures [@fig:expand-to-narrower] and [@fig:expand-to-broader] illustrate the query expansion, showing expansions to two-hop neighbourhoods. 

![Expansion to broader concepts](img/query_expansion_broader.png){#fig:expand-to-broader width=50%}

![Expansion to narrower concepts](img/query_expansion_narrower.png){#fig:expand-to-narrower width=50%}

Arguments of the query expansion function $exp$ are a set of contract objects, a direction of expansion, and a distance of the expansion.
The direction of expansion $Dir$ is the set $\{\texttt{skos:broaderTransitive}, \texttt{skos:narrowerTransitive}\}$ indicating either the expansion to broader or narrower concepts.
The distance is the maximum number of hops followed in the expansion.
Consequently, the query expansion function can be defined as $exp \colon \mathbb{P}(Cobj) \times Dir \times \mathbb{N}_{> 0} \to \mathbb{P}(Cobj)$. <!-- _b -->
Bidirectional expansion of the set of contract objects $\{cobj\} \subset Cobj$ to the distance $dis$ can thus be computed as $exp(\{cobj\}, \texttt{skos:broaderTransitive}, dis) \cup exp(\{cobj\}, \texttt{skos:narrowerTransitive}, dis)$.
We only require $exp$ to be monotonous, so that for every contract object $cobj \in Cobj$ holds that $((con, p), cona) \in cobj \;\; \Rightarrow \;\; ((con, p), cona) \in exp(cobj, dir, dis)$, hence the function $exp$ returns a union of its provided contracts objects with the inferred contract objects.
Concrete instantiations of $exp$ can limit which input contract objects are expanded.
In our case, either no contract objects are expanded or we only expand the explicitly assigned contract objects where $p = \texttt{pc:mainObject}$ and $con \in Con_{CPV}$. <!-- _b -->

#### Matching

The matchmaker examines only exact matches between concepts of contract objects.
Instead of matching complete contract descriptions or sets of concepts, matching on the finer level of individual concepts allows to capture partial overlaps between contracts.
The predicate $matches \colon Cobj \times Cobj \to \{T, F\}$ returns the boolean value true, denoted as $T$, if concepts in the compared contract objects are the same.

$$matches(cobj_{a}, cobj_{b}) =
  \begin{cases}
    T & \text{if}\ ccobj(cobj_{a}) = ccobj(cobj_{b}) \\
    F & \textrm{otherwise} \\
  \end{cases}$$ <!-- _b -->

Here, $ccobj(cobj_{a})$ accesses the concept in the contract object $cobj_{a}$.
As is evident, in order to achieve a match, the ranges of the properties in the compared contract objects must be the same.

Matching considers its input as the query contract, while the others are treated as contracts to be matched.
The function $match \colon \left\{c_{q}\right\} \times Dir \times \mathbb{N}_{> 0} \to \mathbb{P}(CMA)$ retrieves concept-mediated associations matching a given query contract $c_{q}$.

$$match(c_{q}, dir, dis) = \bigcup \left\{ \begin{split}
  & (ccobj(o_{q}), pcobj(o_{q}), pcobj(o_{m}), c_{m}) \colon \\
  & o_{q} \in exp(obj(c_{q}), dir, dis), \\
  & c_{m} \in C, \\
  & o_{m} \in obj(c_{m}), \\
  & matches(o_{q}, o_{m})
  \end{split}\right\}$$ <!-- _b -->

The direction of expansion $dir$ and the distance $dis$ are passed as arguments to the query expansion function $exp$.
The function $match$ produces a set of concept-mediated associations $CMA$ that are defined as 4-tuples $(con, p_{q}, p_{m}, c_{m}) \colon con \in Con, p_{q} \in P, p_{m} \in P, c_{m} \in C$.
We call them concept-mediated associations since they connect the query contract with the matched contracts via concepts.
In each association $p_{q}$ is a property associating a concept $con$ to the query contract and $p_{m}$ is a property associating $con$ to a matched contract $c_{m}$. <!-- _b -->

![Overall diagram of concept-mediated associations](img/matchmaking_overall_diagram.png){#fig:matchmaking-overall-diagram width=75%}

![Concept-mediated associations between contracts](img/concept_associations.png){#fig:concept-associations width=75%}

The [@fig:matchmaking-overall-diagram] shows an overall diagram of concept-mediated associations.
Query contract $c_{q}$ is associated to matched contracts $c_{1}, c_{2}, c_{3} \in C$ via concepts that are assigned to the query contract via $p_{q_{i}}$ and to the matched contracts via $p_{m_{i}}$.
As shown in [@fig:concept-associations], contracts may be associated through different kinds of concepts.
The matched contracts in turn lead to bidders $b_{1}, b_{2} \in B$.
Here, $B$ is the set of known bidders.
Contracting authority of $c_{q}$ is marked as $a_{q}$, while the contracting authority of $c_{3}$ is denoted as $a_{3}$.
For $a_{3}$ a zIndex score $z_{3}$ is available.

#### Weighting

The matchmaker can translate each part of concept-mediated associations into a weight $w \in \mathbb{R} \colon 0 \leq w \leq 1$.
In certain variants of the matchmakers the reference to concept $con$ is transformed to an inverse document frequency (IDF), in particular when dealing with concepts obtained via query expansion.
Similarly, the properties $p_{q}$ and $p_{m}$ can be weighted according to the degree in which they contribute to the similarity between contracts.
Likewise, the contract $c_{m}$ can be turned into a weight corresponding to its contracting authority's fairness score. <!-- _b -->
Some weights are given by data, such as the fairness scores, or derived from it, such as IDFs.
Others can be provided as configuration of the matchmaker, such as the inhibiting weight of `pc:additionalObject`.

There are several concrete ways in which weights can be applied to CPV concepts.
The matchmaker may apply an inhibiting weight to de-emphasize the concepts associated with contracts via the `pc:additionalObject` property in contrast to the `pc:mainObject`.
These weights are applied both to $p_{q}$ and $p_{m}$.
<!--
We could allow different weights for associations with the query contract and the matched contracts.
For example, an additional object of the query contract can be weighted lower than an additional object of a matched contract.
Such distinction may be motivated by different levels of trust in the consistency of contract descriptions of among the contract authorities.
For instance, while an authority may assign a smaller weight to additional objects of its contracts, it may assume a higher weight of additional objects of contract by other authorities.
-->
Similarly, qualifying concepts from the CPV's supplementary vocabulary can be discounted via a lower weight.
Concepts inferred by query expansion can be weighted either by a fixed inhibiting weight or their IDF.

Inverse document frequency is used to reduce the impact of popular CPV concepts on matchmaking.
Unlike infrequent and specific concepts, the popular ones may have lesser discriminative power to determine the relevance of contracts described by them.
Raw IDF of CPV concepts is defined as $idf \colon Con_{CPV} \to \mathbb{R}^{+}$ and is computed as follows: <!-- _b -->

$$idf(con) = \log\frac{\left\vert{C}\right\vert}{1 + \left\vert{\{c \in C \colon ((con, p), cona) \in obj(c)}\right\vert}$$

The denominator in the formula is incremented by 1 to avoid division by zero in case of concepts unused in contract objects.
Subsequently, we normalize IDF into the range of $\left[0, 1\right]$ by using its maximum value in order to be able to use it as a weight.

$$idf'(con) = \frac{idf(con)}{max(\{con' \in Con_{CPV} \colon idf(con')\})}$$ <!-- _b -->

Besides CPV, weights can be applied to specific properties from $P$.
In particular, the matchmaker can inhibit the objects of `pc:kind` when used in combination with CPV.
This property indicates the kinds of contracts, such as works or supplies, which classify contracts into broad categories.

The matchmaker also allows to weight the matched contracts indirectly via weights of their contracting authorities.
We use zIndex scores as weights of contracting authorities.
These scores are taken from the dataset described in [@sec:zindex].
We assume the function $authority \colon C \to Auth$ returns the contracting authority of a given contract.
Here, $Auth$ denotes the set of known contracting authorities.
The function $zindex \colon Auth \to \left[0, 1\right]$ produces a weight given to a contracting authority by the zIndex score.
The function weighting by zIndex can then be defined by composing these functions; i.e. $zindex \circ authority$.

#### Aggregation functions {#sec:aggregation-functions}

We use aggregation functions to turn weights into match scores.
Weights of components in each concept-mediated association are combined using the function $comb$.
The combined weights are aggregated via the function $agg$.

Aggregation functions take multiple numeric inputs and combine them into a single output.
The matchmaker uses these functions to combine weights and partial similarity scores to form a match score.
As such, aggregation functions constitute an important part of ranking.
In terms of fuzzy logic, aggregation functions can be interpreted as generalizations of logical conjunction and disjunction.
Instead of only boolean values, their inputs can be treated as degrees of probability, where 0 indicates impossibility and 1 indicates certainty.
Aggregation function $f$ can thus be defined as $f \colon \left[0, 1\right] \times \left[0, 1\right] \to \left[0, 1\right]$ [@Beliakov2015, p. 785]. 

The typical examples of these functions are triangular norms (t-norms) and conorms (t-conorms).
T-norms generalize conjunction and t-conorms generalize disjunction.
The basic t-norms can be defined as follows [@Beliakov2015, p. 792]:

* Gödel's t-norm (minimum t-norm): $T_{min}(x, y) = min(x, y)$
* Product t-norm: $T_{P}(x, y) = x \cdot y$
* Łukasiewicz's t-norm: $T_{L}(x, y) = max(x + y - 1, 0)$ <!-- _b -->

We use these t-norms to combine weights by the function $comb$.
The basic t-conorms, complementary to the mentioned t-norms, are the following:

* Gödel's t-conorm (maximum t-conorm): $S_{max}(x, y) = max(x, y)$
* Product t-conorm (probabilistic sum): $S_{P}(x, y) = x + y - x \cdot y$
* Łukasiewicz's t-conorm (bounded sum): $S_{L}(x, y) = min(x + y, 1)$ <!-- _b -->

We use these t-conorms to aggregate contract similarities into the match scores of bidders by the function $agg$.
Both t-norms and t-conorms are associative and commutative, so their computation can be extended to arbitrary collections of weights.

Given these formulas we can summarize how the matchmaker works.
The matchmaker retrieves concept-mediated associations $cma \in match(c_{q}, dir, dis)$ for a query contract $c_{q}$ using a configuration of query expansion and weighting.
Concept associations are partitioned into subsets by the bidder awarded with the contract $c_{m}$ from the association. <!-- _b -->
<!-- We can also create subpartitions by contract within these partitions. The aggregated weights in these subpartitions can be considered contract similarity scores. This may be closer to the informal explanation of matchmaking, yet it is unnecessary. -->
Each concept-mediated association in these partitions is subsequently weighted to produce an n-tuple of weights. 
The obtained weights are combined to a single weight of each concept-mediated association via the $comb$ function.
An n-tuple of the combined weights from a partition by bidder can be then aggregated by the $agg$ function to produce match scores. 
Finally, the matches are sorted by their score in descending order and the top-$k$ matches are output.

<!-- FIXME: Do we need to formalize sorting and accessing the bidders from concept associations? -->

### Blind matchmakers {#sec:blind-matchmakers}

Apart from the above-described matchmaker, we also implemented three blind approaches for matchmaking, none of which considers the query contract.
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
A side effect of this implementation is that the match scores in the matchmaker are not normalized.

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

The matchmaker, described in the [@sec:matchmaker-sparql], is implemented as a wrapper over the Virtuoso RDF store.
Example SPARQL queries used by the matchmaker can be found at <https://github.com/opendatacz/matchmaker/wiki/SPARQL-query-examples>.

<!--
Out-takes:

Resources in an RDF graph can be considered similar if their neighbourhoods are similar.
This leads to iterative computation and propagation of similarities through the RDF graph.
That is not what SPARQL is suited for.
-->
