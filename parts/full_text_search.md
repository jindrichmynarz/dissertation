## Full-text search

The use of full-text search engines was motivated by the substantial share of textual data in public procurement data.
For example, the temporal or the spatial dimensions of public contracts is described by literals in dates and postal addresses.
Analysis of literals in SPARQL is limited and inefficient without the use of additional full-text indices.
The value of such data is thus not harnessed in SPARQL-based matchmaking.
More suitable tools for exploitation of textual data are full-text search engines in document-oriented databases, such as [Elasticsearch](https://www.elastic.co/products/elasticsearch) or [Apache Solr](http://lucene.apache.org/solr).
This approach also opens doors for linguistic analysis of textual data, such as normalization via a lemmatizer or query expansion via synonym sets from a WordNet.

<!--
Try the SIREn extension for Elasticsearch or stick with vanilla Elasticsearch?
SIREn allows to index deeply nested data.
-->

* Term frequency-inverse document frequency (TF-IDF): Use to weight only CPV or everything?
* Stop-words: generated from the most frequent words in the contract descriptions?
* Stemming: is there a Czech stemmer for Elasticsearch?

<!--
Implementation note:
If bidder was not awarded any tender, find similar bidders via their description in ARES.
If bidder's description is not found in ARES, an ad hoc request is issued to the ARES API to fetch its description and run it through ETL.
-->
