## Matchmaking

Matchmaking is an information retrieval task that ranks pairs of demands and offers according to the degree the offer satisfies the demand.
It can be considered a special case of top-$k$ retrieval.

<!--
request, query
data, resources, advertisements

Results: 1..n
1 query to n results
Either demand or offer is recasted as query.

Top-N recommendation

Comparable schemata, shared conceputalization, i.e. an ontology
Semi-structured data
Semantic matchmaking requires semantic level of agreement between offers and demands.
In order to be able to compare their descriptions, they need to share the same semantics [@GonzalezCastillo2001].
-->

*"Matchmaking is generally defined as the ranking of a set of offers according to a request"* [@Agarwal2005].
Matchmaking is defined as *"the process of searching the space of possible matches between demand and supplies"* [@DiNoia2004, p. 9].
*"Matchmaking is an information retrieval task whereby queries (a.k.a. demands) and resources (a.k.a. supplies) are expressed using semi-structured data in the form of advertisements, and task results are ordered (ranked) lists of those resources best fulfilling the query"* [@DiNoia2007, p. 278].
*"the objective of a matchmaking process is to discover best available offers to a given request"* [@DiNoia2007, p. 269]
*"Semantic matchmaking is a matchmaking task whereby queries and resources advertisements are expressed with reference to a shared specification of a conceptualization for the knowledge domain at hand, i.e., an         ontology"* [@DiNoia2007, p. 270]

<!-- Demand and supply meet -->

<!-- Dual perspective -->

In matchmaking *"the choice of which is the data, and which is the query depends just on the point of view"* [@DiNoia2004].
Both data describing supply and data about demand can be turned either into queries or into queried data.
To illustrate the inverse direction, matchmaking can provide, for example, alerts to companies about relevant business opportunities in public procurement. 

Viewed as an information retrieval problem, the process of matchmaking can be thus considered as rewriting demands or offers to executable queries.

<!-- Distinction between matchmaking and recommender systems -->

Matchmaking overlaps with recommender systems in many ways.
However, *"every recommender system must develop and maintain a user model or user profile that, for example, contains the user's preferences"* [@Jannach2010, p. 1].
Instead of using user profiles, matchmaking uses queries.
Describing our work as matchmaking is more fitting.

<!--
Push-based recommendations ~ matchmaking subscriptions
- Proactive recommendation: *"A proactive recommender system pushes recommendations to the user when the current situation seems appropriate, without explicit user request."* (<http://pema2011.cs.ucl.ac.uk/papers/pema2011_vico.pdf>)
-->

<!-- Reification of demand -->

In most cases the demand is not externalized as data.

<!--
Calls for tenders are queries.
Matchmaking mediates between offers and demands.

Public contracts ~ history of queries ~ query log

Description logics: query is formulated as a class of matches
- Matches tested via subsumption (or satisfiability of constraints)

Matchmaking dates back to 1990s (e.g., <https://www.ijcai.org/Proceedings/95-1/Papers/088.pdf>).
- Based e.g., on KQML
- Declarative forward-chaining rules

Subscription to streams
- Notifications

TODO: Provide example applications illustrating matchmaking. E.g., matching job seekers to job postings, matching suitable opponents with doctoral theses, matching dating partners

Should we distinguish two phases of matchmaking?
1. Filtering: satisfaction of non-negotiable constraints
2. Ranking: ordering results based on the degree they satisfy the query
-->
