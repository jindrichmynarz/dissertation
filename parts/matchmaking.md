## Matchmaking

Matchmaking is an information retrieval task that ranks pairs of demands and offers according to the degree the offer satisfies the demand.
It is defined as *"the process of searching the space of possible matches between demand and supplies"* [@DiNoia2004, p. 9].
For example, matchmaking can pair job seekers with job postings, discover suitable opponents for doctoral theses, or match dating partners.

<!-- Dual perspective: data vs. query -->

Matchmaking recasts either demands or offers as queries, while the rest is treated as data to query.
In this setting, *"the choice of which is the data, and which is the query depends just on the point of view"* [@DiNoia2004].
Both data describing offers and data about demands can be turned either into queries or into queried data.
For example, in our case public contracts may be treated as queries for suitable bidders, or, vice versa, bidder profiles may be recast as preferences for public contracts.
Matchmakers are given one query and produce $k$ results best fulfilling the query [@DiNoia2007, p. 278].
Viewed in this perspective, matchmaking can be considered a case of top-$k$ retrieval.

<!-- Complex structured data 
Since demands and supplies are usually complex, *"most real-world problems require multidimensional matchmaking"* [@Veit2001].
Cannot be reduced to price tags
Difference from filtering on a single dimension
-->

<!-- Semantic matchmaking -->

Our work focuses on semantic matchmaking.
Semantic matchmaking requires semantic level of agreement between offers and demands.
In order to be able to compare descriptions of offers or demands, they need to share the same semantics [@GonzalezCastillo2001].
Semantic matchmaking thus describes both queries and data *"with reference to a shared specification of a conceptualization for the knowledge domain at hand, i.e., an ontology"* [@DiNoia2007, p. 270].
Ontologies give the entities involved in matchmaking comparable schemata.
Data pre-processing may reformulate demands and offers to be comparable, e.g., by aligning their schemata.

<!-- Distinction between matchmaking and recommender systems -->

Matchmaking overlaps with recommender systems in many respects.
Both employ similar methods to achieve their task.
However, *"every recommender system must develop and maintain a user model or user profile that, for example, contains the user's preferences"* [@Jannach2010, p. 1].
Instead of using user profiles, matchmaking uses queries.
Although this is a simplifying description, designating our work as matchmaking is more telling.

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

We adapted two general methods for matchmaking: case-based reasoning and link prediction.

### Case-based reasoning

Case-based recommender systems
Case-based recommenders are usually classified as subset of knowledge-based recommenders [@Jannach2010].

Similarity-based retrieval
Limitation: favours larger and longer-established suppliers. <!-- An opportunity to normalize by the bidder's age from ARES? -->
Schema-aware vs. schema-agnostic matchmaking

Public contract ~ case
Reinterpretation of previously awarded public contracts as experiences of solved problems.
Reinterpretation of contract award as a positive rating (in the context of the awarded contract)
Limitation: We have only positive ratings.

<!--
Similarity search
- "Query by example"
- Pairwise distance functions
- k-nearest neighbour queries: specifies a number of results to retrieve
Curse of dimensionality: RDF is complex and contains a multitude of dimensions. Linear increase of dimensions => exponential growth of negative effects.
-->

The matchmaker learns from interactions between contracting authorities and bidders
A contract is an explicit specification of user's needs.

Similarly to collaborative recommendation approaches, case-based recommenders exploit data about past behaviour.
Collaborative recommender systems: explicit offers (product or services) + demand behaviour (user interactions)
Our case-based recommender: explicit demands (contracts) + offer behaviour (histories of bidders)

Contract award can be interpreted an implicit rating of the awarded bidder.
The histories of bidders are held in memory instead of a model in SPARQL-based and Elasticsearch-based matchmaking.

<!-- TODO: Explain the difference between matchmaking and recommender systems. (Notion of a query.) -->

Case-based recommendation is a kind of knowledge-based recommendation that uses similarity-based retrieval.

Query-based approaches: often users have to respecify their query in case no results are found.
Browsing-based approaches: navigation of the item space, for example using critique-based navigation
- Critiquing can be used to reformulate matchmaking queries (e.g., assign different weights) or query the results (e.g., filter to meet the critique).

<!--
TODO: Does "collaboration via content" fit our recommender? (M. J. Pazzani, A framework for collaborative, content-based and demographic filtering, Artificial Intelligence Review 13 (1999), no. 5–6, 393–408.)
-->

### Link prediction
