## Full-text search

<!--
### Implementation notes

* Start a new Clojure project `matchmaker-elasticsearch`.
* Only command-line interface (~ minimum viable product)
* Copy and paste code from the previous matchmaker.
* Custom benchmark manipulating data in the Elasticsearch endpoint.
* Matchmaker is provided as a component (e.g., mount) 
* Elasticsearch interactions are done via the `elastisch` library.
* Extensive configuration in EDN.
* Produces results in EDN.

* Use an asymmetric similarity metric for prices. Lower-priced contracts are preferred.
-->

We chose Elasticsearch^[<https://www.elastic.co/products/elasticsearch>] because of its expressive query DSL that allows us to formulate complex matchmaking queries.

Elasticsearch Query DSL

The use of full-text search engines was motivated by the substantial share of textual data in public procurement data.
For example, the temporal or the spatial dimensions of public contracts is described by literals in dates and postal addresses.
Analysis of literals in SPARQL is limited and inefficient without the use of additional full-text indices.
The value of such data is thus not harnessed in SPARQL-based matchmaking.
More suitable tools for exploitation of textual data are full-text search engines in document-oriented databases, such as Elasticsearch or Apache Solr.^[<http://lucene.apache.org/solr>]
This approach also opens doors for linguistic analysis of textual data, such as normalization via a lemmatizer or query expansion via synonym sets from a WordNet.

<!--
Try the SIREn extension for Elasticsearch or stick with vanilla Elasticsearch?
SIREn allows to index deeply nested data.
-->

* Term frequency-inverse document frequency (TF-IDF): Use to weight only CPV or everything?
* Stop-words: generated from the most frequent words in the contract descriptions?
* Stemming: is there a Czech stemmer for Elasticsearch?

<!--
Comparison of CBR systems with information retrieval systems is in [@Richter2013, p. 525].
-->

### Benefits and drawbacks

### Matchmaking

### Implementation

<!--
Implementation note:
If bidder was not awarded any tender, find similar bidders via their description in ARES.
If bidder's description is not found in ARES, an ad hoc request is issued to the ARES API to fetch its description and run it through ETL.

Use a learning to rank plugin? <https://github.com/o19s/elasticsearch-learning-to-rank>
Use boosting by recency via scripting?
Custom similarity based on overlaps in description. <http://stefansavev.com/blog/custom-similarity-for-elasticsearch>
It is possible to implement ES plugins in Clojure. <https://github.com/dakrone/elasticsearch-clojure-plugin>
-->
