# Matchmaking methods

*"Matchmaking is generally defined as the ranking of a set of offers according to a request"* ([Agarwal, Lamparter, 2005](#Agarwal2005)).

In matchmaking *"the choice of which is the data, and which is the query depends just on the point of view"* ([Di Noia et al., 2004](#DiNoia2004)).
Both data describing supply and data about demand can be turned either into queries or into queried data.
To illustrate the inverse direction, matchmaking can provide, for example, alerts to companies about relevant business opportunities in public procurement. 

Viewed as an information retrieval problem, the process of matchmaking can be thus considered as rewriting demands or offers to executable queries.

Limitation: Our approach works as a one-shot recommendation
Is there a way to provide user feedback?

## Case-based reasoning

Case-based recommended systems

Using the terminology of case-based reasoning, CPV provides a "bridge attribute" that allows to derive the       similarity of contracts from the shared concepts in their descriptions.

Similarity-based retrieval
Limitation: favours larger and longer-established suppliers. <!-- An opportunity to normalize by the bidder's age from ARES? -->
Schema-aware vs. schema-agnostic matchmaking

Reinterpretation of contract award as a positive rating (in the context of the awarded contract)
Limitation: We have only positive ratings.

<!--
Formalization of the methods should be provided.
We can start with a definition of the key entities involved in the matchmaking task.
-->

<!--
Implementation note:
If bidder was not awarded any tender, find similar bidders via their description in ARES.
If bidder's description is not found in ARES, an ad hoc request is issued to the ARES API to fetch its description and run it through ETL.

Describe aggregation functions used to compute match score.
-->

Contributions of linked open data to recommender systems (inspired by [Di Noia, Ostuni, 2015, p. 102](#DiNoia2015)):

* Enriching data with additional features
* Avoiding the problem of cold start
* Avoiding data sparsity

Related work:

* WeightedNIPaths ([Ristoski et al., 2015](#Ristoski2015))
* Spreading activation ([Heitmann, Hayes, 2014](#Heitmann2014))

## SPARQL

[Mynarz, Svátek, Di Noia, 2015](#Mynarz2015)

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

## Tensor factorization

Web of Needs

<!--
Hybrid approaches combining multiple methods
- E.g., re-ranking
-->

## Matchmaking factors

* Data quality: deduplication of bidders
* Volume of data: larger volume of data
* Score aggregation and weighting
* Additional features from linked open data

<!--
TODO: Try to run matchmaking over data in <http://pproc.unizar.es:8890/sparql>.
-->

<!--
* Now-defunct bidders should be filtered out.
* Match score can be normalized by the bidders age (now() - dcterms:issued).
* Contracts with more tenders (`pc:numberOfTenders`) can be scored as more telling, since the bidder won in greater competition.
* Contracts with open procedures can be also scored as more telling.
-->

<!--
Try hybrid methods?
-->

Further problems:

* Explaining recommendations <!-- To achieve transparency of matchmaking results. -->
* Constraint relaxation: When no results are returned, use more generic features or leave most discriminating features out.
* Ranking and the primacy effect (= users look at the first results)
  * Primacy effect = Items at the beginning of a recommendation list are analyzed more frequently.
* Determine the weights of features based on their perceived utility
* Reformulate award criteria using <https://en.wikipedia.org/wiki/Conjoint_analysis>?

<!-- TODO: Add a diagram showing the technology stack involved in the matchmaker. -->
