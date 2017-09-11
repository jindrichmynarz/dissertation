## Matchmaking

Matchmaking is an information retrieval task that ranks pairs of demands and offers according to the degree the offer satisfies the demand.
It is a *"process of searching the space of possible matches between demand and supplies"* [@DiNoia2004, p. 9].
For example, matchmaking can pair job seekers with job postings, discover suitable opponents for doctoral theses, or match romantic partners.

<!-- Dual perspective: data vs. query -->

Matchmaking recasts either demands or offers as queries, while the rest is treated as data to query.
In this setting, *"the choice of which is the data, and which is the query depends just on the point of view"* [@DiNoia2004].
Both data describing offers and data about demands can be turned either into queries or into queried data.
For example, in our case we may treat public contracts as queries for suitable bidders, or, vice versa, bidder profiles may be recast as preferences for public contracts.
Matchmakers are given one query and produce $k$ results best-fulfilling the query [@DiNoia2007, p. 278].
Viewed in this perspective, matchmaking can be considered a case of top-$k$ retrieval.

<!-- Complex data -->

Matchmaking typically operates on complex data structures.
Both demands and supplies may combine non-negotiable restrictions with more flexible requirements or vague semi-structured descriptions.
Descriptions of demands and offers thus cannot be reduced to a single dimension, such as a price tag.
Matchmakers operating on such complex data thus often suffer from the curse of dimensionality.
Linear increase in dimensionality may cause an exponential growth of negative effects.
Complex descriptions make demands and offers difficult to compare.
Since demands and supplies are usually complex, *"most real-world problems require multidimensional matchmaking"* [@Veit2001].
For example, matchmaking may involve similarity functions that aggregate similarities of individual dimensions.

<!-- Semantic matchmaking -->

Our work focuses on semantic matchmaking that requires semantic level of agreement between offers and demands.
In order to be able to compare descriptions of offers or demands, they need to share the same semantics [@GonzalezCastillo2001].
Semantic matchmaking thus describes both queries and data *"with reference to a shared specification of a conceptualization for the knowledge domain at hand, i.e., an ontology"* [@DiNoia2007, p. 270].
Ontologies give the descriptions of entities involved in matchmaking comparable schemata.
Data pre-processing may reformulate demands and offers to be comparable, e.g., by aligning their schemata.
In order to be able to leverage the semantic features of data, our approach is schema-aware, as opposed to schema-agnostic matchmaking

<!-- Distinction between matchmaking and recommender systems -->

Matchmaking overlaps with recommender systems in many respects.
Both employ similar methods to achieve their task.
However, *"every recommender system must develop and maintain a user model or user profile that, for example, contains the user's preferences"* [@Jannach2010, p. 1].
Instead of using user profiles, matchmaking uses queries.
Although this is a simplifying description and the distinction between matchmaking and recommender systems is in fact blurry, designating our work as matchmaking is more telling.

<!-- Ambiguity of matchmaking -->

Besides its similarities with recommender systems, matchmaking may invoke different connotations, as the term is used in other disciplines with different meanings.
For instance, it appears in graph theory to produce subsets of edges without common vertices.
To avoid this ambiguity, in this text we will use the term "matchmaking" only in the way described here.

<!--
Calls for tenders are queries.
Matchmaking mediates between offers and demands.
Demand and supply meet

Public contracts ~ history of queries ~ query log

Should we distinguish two phases of matchmaking?
1. Filtering: satisfaction of non-negotiable constraints
2. Ranking: ordering results based on the degree they satisfy the query
-->

<!--
*"Matchmaking is generally defined as the ranking of a set of offers according to a request"* [@Agarwal2005].
*"Matchmaking is an information retrieval task whereby queries (a.k.a. demands) and resources (a.k.a. supplies) are expressed using semi-structured data in the form of advertisements, and task results are ordered (ranked) lists of those resources best fulfilling the query"* [@DiNoia2007, p. 278].
*"the objective of a matchmaking process is to discover best available offers to a given request"* [@DiNoia2007, p. 269]
-->

We adapted two general approaches for matchmaking: case-based reasoning and statistical relational learning.
Both have many things in common and employ similar techniques to achieve their goal.
Both learn from past data to produce predictions that are not guaranteed to be correct.
A more detailed comparison of case-based reasoning with machine learning is in Richter and Weber [-@Richter2013, p. 531].

<!-- TODO: Should we also discuss other approaches adopted for matchmaking in related research, e.g., reasoning with description logic? -->
