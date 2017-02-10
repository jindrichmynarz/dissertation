## Linked open data

<!--
The open definition
Linked data principles
Semantic web technologies
-->

### Open data

Open data is data that can be accessed equally by people and machines.

While releasing open data is frequently framed as a means to improve transparency of the public sector, it can also have a positive effect on its efficiency ([Access Info Europe, Open Knowledge Foundation, p. 69](#AccessInfoEurope2011)), since the public sector itself is often the primary user of open data.
Using open data can help streamline public sector processes ([Parycek, Höchtl, Ginner, 2014, p. 90](#Parycek2014)) and curb unnecessary expenditures ([Prešern, Žejn, 2014, p. 4](#Presern2014)).
The publication of public procurement data is claimed to improve *"the quality of government investment decision-making"* ([Kenny, Karver, 2012, p. 2](#Kenny2012)), as supervision enabled by access to data puts a pressure on contracting authorities to follow fair and budget-wise contracting procedures.
Matchmaking public contracts to relevant suppliers is an example of such application that can contribute to better informed decisions that lead to more economically advantageous contracts.

Context withing the [OpenData.cz](http://opendata.cz) initiative
OpenData.cz is an initiative for transparent data infrastructure of the Czech public sector.
It advocates adopting open data and linked data principles for publishing data on the Web.

### Linked data

Linked data is a way of structuring data that identifies entities with Internationalized Resource Identifiers (IRI) and materializes their relationships as a network of machine-processable data ([Ayers, 2007, p. 94](#Ayers2007)).
IRIs are universal, thus any entity can be identified with a IRI, and have global scope, therefore IRI can only identify one entity ([Berners-Lee, 1996](#BernersLee1996)).

Resource Description Framework (RDF) is a graph data format for exchanging data on the Web.
The formal data model of RDF is a directed labelled graph.
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

Plus:

* Both content and preferences (i.e. contract awards) are expressed in an uniform way.
* Features that link other datasets can be used to automatically retrieve more features.
