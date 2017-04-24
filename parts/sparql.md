## SPARQL

<!--
### Implementations notes

* Start a new Clojure project `matchmaker-sparql`.
* Only command-line interface (~ minimum viable product)
* Copy and paste code from the previous matchmaker.
* Custom benchmark manipulating data in the SPARQL endpoint.
* Matchmaker is provided as a component (e.g., mount) 
* SPARQL interactions are done via the `sparclj` library.
* Extensive configuration in EDN.
* Produces results in EDN.
-->

Initial version [@Mynarz2014b]
[@Mynarz2015]

The histories of bidders are held in memory instead of a model in SPARQL-based and Elasticsearch-based matchmaking.

Since SPARQL-based matchmaking operates directly on database indices and there is no need to build a model, it can be used for real-time recommendations on streaming data.

<!--
TODO: Describe aggregation functions used to compute match score.

Comparison of CBR systems with databases in [@Richter2013, p. 524].
SPARQL retrieves exact matches. Ranking needs to be implemented on top of SPARQL.
SPARQL operates under the closed world assumption. CBR assumes open world.

Curse of dimensionality: RDF is complex and contains a multitude of dimensions. Linear increase of dimensions => exponential growth of negative effects.

Combination functions [@Beliakov2007], [@Beliakov2015]

Recommendation of the topmost populater bidders ~ non-personalized recommendation.
-->
