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

[Mynarz, Svátek, Di Noia, 2015](#Mynarz2015)

Since SPARQL-based matchmaking operates directly on database indices and there is no need to build a model, it can be used for real-time recommendations on streaming data.

<!--
TODO: Describe aggregation functions used to compute match score.
-->
