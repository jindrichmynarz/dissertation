# Related work {#sec:related-work}

<!-- stav řešení problematiky v ČR a ve světě -->
<!-- TODO: This needs to be substantially shortened. -->

In order to help discern our progress beyond the state of the art, we briefly survey the research related to our work.
This overview includes matchmaking applications as well as related vocabularies and technologies. 

Early matchmaking in 1990s adopted reasoning with description logics (DL) and communication between software agents, such as in @Kuokka1995.
DL remained the basis of matchmaking at the onset of 2000s when the semantic web initiative arose.
Unlike the prior solutions, the newer matchmakers were built with ontological languages, such as the Web Ontology Language (OWL) [@DiNoia2004], that encoded explicit semantics.
Matchmaking queries were formulated as classes of matches, so that matches could be tested via subsumption or satisfiability of the class constraints by reasoning in DL.

Using reasoners for matchmaking turned out to be problematic due to the limited expressivity of DL constructs and poor performance for larger data.
SPARQL [@Prudhommeaux2008], released in 2008, spawned matchmaking implemented as database queries (e.g., @Salvadores2008 or @Radinger2013), improving both on expressivity and scalability.

Perhaps the first application of matchmaking in public procurement was conceived in the Spanish research project 10ders Information Services.^[<http://rd.10ders.net>]
A part of this project called Methods on Linked Data for E-procurement Applying Semantics (MOLDEAS) [@AlvarezRodriguez2012] explored the application of semantic web technologies in public procurement and included matchmaking via SPARQL enhanced with query expansion [@AlvarezRodriguez2011c] or spreading activation [@AlvarezRodriguez2013, p. 118].

SPARQL is optimized for exact matches in structured data.
However, a fundamental feature of matchmaking is ranking data by the degree it satifies a query, whereas exact matching produces either matches or non-matches, without any way to rank them.
In order to be able capture partial matches as well as leverage unstructured data, approaches to matchmaking based on machine learning and text search were introduced.

A forerunner of this research direction was iSPARQL [@Kiefer2007], which extended SPARQL with similarity functions.
It demonstrated that both combining logical deduction with statistical induction and exploiting textual information can improve matchmaking.
Machine learning and text search were also employed for matchmaking within the Web of Needs project [@Kleedorfer2014].
Here, real-time matchmaking is delivered by searching semi-structured data using Apache Solr^[<http://lucene.apache.org/solr>] and batch matchmaking is built on RESCAL [@Nickel2011] in a similar fashion to one of our approaches.
The matchmakers in the Web of Needs are generic, based on a common denominator of data about demands and offers, including the features such as title, description, tags, or price [@Friedrich2016].
On the contrary, our approach is specific to the public procurement domain, so that it can leverage more powerful, but domain-specific features in matchmaking.

Besides matchmaking applications, our work relates both to RDF vocabularies that describe demands or offers and generic technologies conducive to applications similar to matchmaking.
RDF vocabularies enable to bestow data with semantic features that matchmaking can leverage.
Call for Anything^[<http://vocab.deri.ie/c4n>] is one of the first vocabularies for formulating demands as data.
GoodRelations [@Hepp2008] is an ontology for e-commerce on the Web.
It focuses more on offers, but enables to express demands as ideal offers.
Apart from these generic vocabularies, vocabularies describing the public procurement market were designed, such as LOTED2 [@Distinto2016] or Public Procurement Ontology [@MunozSoro2016]. 

Our approaches to matchmaking are similar to those involved in LOD-enabled recommender systems [@DiNoia2014].
In particular, the overlap is apparent in enhancing data with semantic features extracted from LOD.
We also borrow many techniques from the fields like instance matching [@Bryl2014] and semantic search [@Davies2009], including similarity measures or query expansion.
