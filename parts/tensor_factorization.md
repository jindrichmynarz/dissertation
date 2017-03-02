## Tensor factorization

<!--
### Implementation notes:

* Start a new Python project `matchmaker-rescal`.
* Only command-line interface (~ minimum viable product)
* Produce results in EDN (<https://github.com/swaroopch/edn_format>).
* Consider also <https://github.com/nzhiltsov/Ext-RESCAL>?
* Learning to rank with <http://fa.bianp.net/blog/2012/learning-to-rank-with-scikit-learn-the-pairwise-transform/>?
-->

@Nickel2011, @Nickel2012

Web of Needs

<!--
Tensors are multidimensional arrays. A natural way to represent multi-graphs is to use adjacency tensors.
Tensor order
RDF data can be represented as a third-order tensor.
Adjacency tensors
Slices
Fibers
Tensor factorization
Latent factors

Dealing with the noise in the data
Perspective of probabilistic databases

Hybrid approaches combining multiple methods
- E.g., re-ranking

Tensor factorization ~ tensor completion

TODO: Introduce modelling RDF data with three-way tensors. (With diagrams!)

Link prediction ranks entries in the reconstructed tensor by their values.

Can we say that tensors are a representational formalism for statistical relational learning?
-->

<!--
RESCAL does not require strict feature modelling.
RESCAL is a supervised machine learning method.
Unlike RDF, tensors can represent higher-order relations.
-->

Time-aware link prediction [@Kuchar2016].
Weighting by time from award date to model decay of usefulness of older contract awards.

<!--
Comparison of CBR systems with machine learning is in [@Richter2013, p. 531].
CBR and ML have many things in common.
Both learn from past data to produce predictions, which are not guaranteed to be correct.
-->

<!--
### Features

:awardedBidder (i.e. pc:awardedTender/pc:bidder, weighted by pc:awardDate)
pc:mainObject
pc:additionalObject
skos:closeMatch
skos:related
skos:broaderTransitive
rov:orgActivity
-->
