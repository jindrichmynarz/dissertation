### Linked data

<!--
Linked data principles
Semantic web technologies
-->

Linked data is a way of structuring data that identifies entities with Internationalized Resource Identifiers (IRIs) and materializes their relationships as a network of machine-processable data ([Ayers, 2007, p. 94](#Ayers2007)).
IRIs are universal, thus any entity can be identified with a IRI, and have global scope, therefore IRI can only identify one entity ([Berners-Lee, 1996](#BernersLee1996)).

Resource Description Framework (RDF) is a graph data format for exchanging data on the Web.
The formal data model of RDF is a directed labelled multi-graph. <!-- not necessarily bipartite -->
RDF statements: triples, subjects, predicates, objects
IRIs, blank nodes, literals, data types
Quads, named graphs
RDF serializations, e.g., Turtle, JSON-LD, N-Quads

(Argument for RDF, why we chose it)
RDF makes combining data straightforward.
Explicit links across datasets, for example public contracts link suppliers from a business register

Linked open data offers interoperability without centralization.

* Non-unique name assumption (non-UNA)
* Open world assumption (OWA)
  * A problem for machine learning is that linked data rarely contains negative examples.
  * Due to OWA, you cannot infer that missing statements are false.
* Anyone can say anything about anything (AAA)

<!-- ### Preliminaries
Minimal introductions to the topics covered in this thesis to enable comprehension of the further text.
* SPARQL
SPARQL is a query language for RDF data.
The syntax of SPARQL combines the syntax of Turtle with the syntax of SQL. (Even though it was only inspired by SQL.)
The syntax of graph patterns extends Turtle with variables. (Names prefixed either by `?` or `$`.)
-->

The benefits of using linked open data are demonstrated mostly in the data preparation.
Linked open data makes it simpler to combine multiple datasets.
It also provides a way to define "semantic" features for matchmaking.
Semantic features can alleviate the problem of "shallow content analysis" that exists in some content-based recommender systems, typically those based on text.

Recommender systems are typically unaware of the semantics of item features.

LOD-based recommender systems
LOD-enabled Recommender Systems Challenge on Book Recommendation ([Di Noia, Cantador, Ostuni, 2014](#DiNoia2014)).

Benefits of LOD (according to [Di Noia et al., 2016](#DiNoia2016)):

* Availability of free data
* Since the data is structured, there is no need for structuring it via content analysis. (Although data preparation is definitely necessary.)
* Data is described in a semantic way

Plus inspired by [Di Noia, Ostuni, 2015, p. 102](#DiNoia2015):

* Enriching data with additional features
* Avoiding the problem of cold start
* Avoiding data sparsity

Plus:

* Both content and preferences (i.e. contract awards) are expressed in an uniform way.
* Features that link other datasets can be used to automatically retrieve more features.
* Easy representation of multilingual data
* Defragmentation of procurement data sources via links and reuse of data 
* Links to contextual data
* no black-box features like keywords (e.g., features with expandable semantics)
