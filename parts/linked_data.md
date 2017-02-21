### Linked data

Linked data is a set of practices for publishing structured data on the Web.
It is a way of structuring data that identifies entities with Internationalized Resource Identifiers (IRIs) and materializes their relationships as a network of machine-processable data [@Ayers2007, p. 94].
IRIs are universal, so that any entity can be identified with a IRI, and have global scope, therefore an IRI can only identify one entity [@BernersLee1996].
In this section we provide a basic introduction to key aspects of linked data used in this thesis.
A more detailed introduction in available in Heath and Bizer [-@Heath2011].

Linked data may be seen as a pragmatic implementation of the so-called semantic web vision.
It is based on semantic web technologies.
This technology stack is largely built upon W3C standards.^[<https://www.w3.org/standards/semanticweb>]
The fundamental standards of the semantic web technology stack, which are used throughout our work, are the Resource Description Framework (RDF), RDF Schema (RDFS), and SPARQL.

<!-- RDF -->

RDF [@Cyganiak2014b] is a graph data format for exchanging data on the Web.
The formal data model of RDF is a directed labelled multi-graph.
Nodes and edges in RDF graphs are called resources.
Resources can be either IRIs, blank nodes, or literals.
IRIs from the set $I$ refer to resources, blank nodes from the set $B$ reference resources without intrinsic names, and literals from the set $L$ represent textual values.
$I$, $B$, and $L$ are pairwise disjoint sets.
An RDF graph can be decomposed into a set of statements called RDF triples.
An RDF triple can be defined as $(s, p, o) \in (I \cup B) \times I \times (I \cup B \cup L)$.
In such triple, $s$ is called *subject*, $p$ is *predicate*, and $o$ is *object*.
As the definition indicates, subjects can be either IRIs or blank nodes, predicates can be only IRIs, and objects can be both IRIs, blank nodes, and literals.
Predicates are also often referred to as properties.
RDF graphs can be grouped into RDF datasets.
Each graph in an RDF dataset can be associated with a name $g \in (I \cup B)$.
RDF datasets can be thus decomposed into quads $(s, p, o, g)$, where $g$ is called *named graph*.

What we described above is the abstract syntax of RDF.
In order to be able to exchange RDF graphs and datasets a serialization is needed.
RDF can be serialized into several concrete syntaxes, including Turtle [@Beckett2014], JSON-LD [@Sporny2014], or N-Quads [@Carothers2014].
An example of data describing a public contract serialized in Turtle is shown in [@lst:example-turtle].

```{#lst:example-turtle caption="Example data in Turtle"}
@prefix contract: <http://linked.opendata.cz/resource/isvz.cz/contract> .
@prefix dcterms:  <http://purl.org/dc/terms/> .
@prefix pc:       <http://purl.org/procurement/public-contracts#> .

contract:60019151 a pc:Contract ;
  dcterms:title "Poskytnutí finančního úvěru"@cs ;
  pc:contractingAuthority business-entity:CZ00275492 .
```

<!-- RDF Schema -->

RDFS [@Brickley2014] is an ontological language for describing semantics of data.
It provides a way to group resources as instances of classes and describe relationships among the resources.
RDFS terms are endowed with inference rules that can be used to materialize data implied by the rules.
Relationships between RDF resources are represented as properties.
Properties are defined in RDFS in terms of their domain and range.
For each RDF triple with a given property, its subject may be inferred to be an instance of the property's domain, while its object is treated as an instance of the property's range.
Moreover, RDFS can express subsumption hierarchies between classes or properties.
If more sophisticated ontological constraints are required, they can be defined by the Web Ontology Language (OWL) [@W3C2012].
RDFS and OWL can be used in tandem to create vocabularies that provide classes and properties to describe data.
Vocabularies enable tools to operate on datasets sharing the same vocabulary without dataset-specific adaptations.
The explicit semantics provided by RDF vocabularies makes datasets described by such vocabularies machine-understandable to a limited extent.
For example, one shared vocabulary used in our work is the Public Contracts Ontology, which is described in [@sec:pco].

<!-- SPARQL -->

SPARQL [@Harris2013] is a query language for RDF data.
The syntax of SPARQL was inspired by SQL.
The `WHERE` clauses in SPARQL specify graph patterns to match in the queried data.
The syntax of graph patterns extends the Turtle RDF serialization with variables, which are names prefixed either by `?` or `$`.
Solutions to SPARQL queries are subgraphs that match the specified graph patterns.
The solutions are subsequently processed by modifiers, such as by deduplication or ordering.
Solutions are output based on the query type.
ASK queries output boolean values, SELECT queries output tabular data, and CONSTRUCT or DESCRIBE queries output RDF graphs.
An example SPARQL query that retrieves all classes instantiated in a dataset is shown in [@lst:sparql-example].

```{#lst:sparql-example caption="Example SPARQL query"}
SELECT DISTINCT ?class
WHERE {
  [] a ?class .
}
ORDER BY ?class
```

<!-- Linked data principles -->

Use of the above-mentioned semantic web technologies for publishing linked data is guided by four principles [@BernersLee2009]:

1. Use IRIs as names for things.
2. Use HTTP IRIs so that people can look up those names.
3. When someone looks up a IRI, provide useful information, using the standards (RDF, SPARQL).
4. Include links to other IRIs, so that they can discover more things.

Besides prescribing the way to identify resources the principles describe how to navigate linked data.
The principles invoke the mechanism of dereferencing, by which an HTTP request to a resource's IRI should return the resource's description in RDF.

Linked data invokes several assumptions that have implications for its users.
*Non-unique name assumption* (non-UNA) posits that two names (identifiers) may refer to the same entity unless explicitly stated otherwise.
This assumption implies that deduplication may be needed if identifiers are required to be unique.
*Open world assumption* (OWA) supposes that *"the truth of a statement is independent of whether it is known.
In other words, not knowing whether a statement is explicitly true does not imply that the statement is false"* [@Hebeler2009, p. 103].
Due to OWA we cannot infer that missing statements are false.
OWA poses a potential problem for classification tasks in machine learning, because linked data rarely contains explicit negative examples.
The principle of *Anyone can say anything about anything* (AAA) assumes that the open world of linked data provides no guarantees that the assertions published as linked data are consistent or uncontradictory.
Given this assumption, quality assessment followed by data pre-processing is typically required when using linked data.

<!-- Benefits of linked data -->

Having considered the characteristics of linked data we may highlight its advantages. 
Many of these advantages are related to data preparation, which we point out in [@sec:data-preparation], however, linked data can also benefit matchmaking in several ways.
This overview draws upon the benefits of linked data for recommender systems identified in related research (e.g., [@DiNoia2014], [@DiNoia2016]), since these benefits apply to matchmaking too.

Unlike textual content, linked data is structured, so there is less need for structuring it via content analysis.
RDF gives linked data not only structure but also flexibility to model varied data. 
Both content and preferences in recommender systems or matchmaking, such as contract awards in our case, can be expressed in RDF in an uniform way in the same feature space, which simplifies operations on the data.
Moreover, the common data model enables combining linked data with external linked datasets that can provide valuable additional features.
The mechanism of tagging literal with language identifiers also makes for an easy representation of multilingual data, such as in the case of cross-country procurement in the EU.

The features in RDF are endowed with semantics thanks to RDF vocabularies.
The explicit semantics makes features more operative, as opposed to features produced by shallow content analysis [@Jannach2010, p. 75], such as keywords.
While traditional recommender systems are mostly unaware of the semantics of the features they use, linked data features do not have to be treated like black boxes, since their expected interpretations can be looked up in the corresponding RDF vocabularies that define the features. 

If the values of features are resources compliant with the linked data principles, their IRIs can be dereferenced to obtain more features from the descriptions of the resources.
In this way linked data allows to automate the retrieval of additional features.
IRIs of linked resources can be automatically crawled to harvest contextual data.
Furthemore, crawlers may recursively follow links in the obtained data.
The links between datasets can be used to provide cross-domain recommendations.
In such scenario preferences from one domain are be used to predict preferences in another domain.
For example, if in our case we combine data from business and public procurement registers, we may leverage links between business entities described with concepts from an economic classification to predict their associations to concepts from a procurement classification.
If there is no overlap between the resources from the combined datasets, there may be at least an overlap in RDF vocabularies describing the resources [@Heitmann2016], which provide broader conceptual associations.
