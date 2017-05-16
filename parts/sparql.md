## SPARQL

An initial version of the SPARQL-based matchmaker was introduced in [@Mynarz2014b].
[@Mynarz2015] covers an improved version of the matchmaker.
The hereby described version is thus the third iteration of the matchmaker.

The histories of bidders are held in memory instead of a model in SPARQL-based and Elasticsearch-based matchmaking.

Since SPARQL-based matchmaking operates directly on database indices and there is no need to build a model, it can be used for real-time recommendations on streaming data.

<!--
TODO: Describe aggregation functions used to compute match score.

Comparison of CBR systems with databases in [@Richter2013, p. 524].
SPARQL retrieves exact matches. Ranking needs to be implemented on top of SPARQL.
SPARQL operates under the closed world assumption. CBR assumes open world.

Curse of dimensionality: RDF is complex and contains a multitude of dimensions. Linear increase of dimensions => exponential growth of negative effects.

Combination functions [@Beliakov2007], [@Beliakov2015]

Recommendation of the top-most popular bidders ~ non-personalized recommendation.

Refer to [@Maidel2008] in the discussion of setting the weights of expanded concepts.
Maidel showed that weighting concepts (e.g., by TF-IDF) does not have an impact.
-->

<!--
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
