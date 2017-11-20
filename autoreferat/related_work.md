# Related work {#sec:related-work}

<!-- stav řešení problematiky v ČR a ve světě -->
<!-- TODO: This needs to be substantially shortened. -->

In order to help discern the progress beyond the state of the art in our contributions, we briefly survey the research related to our work.
This overview includes matchmaking applications as well as related vocabularies and technologies. 

Early matchmaking in 1990s adopted reasoning with description logics (DL) and communication between software agents, such as in @Kuokka1995.
DL remained the basis of matchmaking at the onset of 2000s when the semantic web initiative arose.
Unlike the prior solutions, the newer matchmakers were built with ontological languages, such as the Web Ontology Language (OWL) [@DiNoia2004], that encoded explicit semantics.
Matchmaking queries were formulated as classes of matches, so that matches could be tested via subsumption or satisfiability of the class constraints by reasoning in DL.

Using reasoners for matchmaking turned out to be problematic due to the limited expressivity of DL constructs and poor performance for larger data.
SPARQL [@Prudhommeaux2008], released in 2008, spawned approaches to matchmaking via production rules implemented as database queries (e.g., @Salvadores2008 or @Radinger2013), improving both on expressivity and scalability.

Perhaps the first application of matchmaking in public procurement was conceived in the Spanish research project 10ders Information Services.^[<http://rd.10ders.net>]
A part of this project called Methods on Linked Data for E-procurement Applying Semantics (MOLDEAS) [@AlvarezRodriguez2012] explored the application of semantic web technologies in public procurement and included matchmaking via SPARQL enhanced with query expansion [@AlvarezRodriguez2011c] or spreading activation [@AlvarezRodriguez2013, p. 118].

SPARQL is optimized for exact matches in structured data.
A fundamental feature of matchmaking is ranking data by the degree it satifies a query, whereas exact matching produce either matches or non-matches, without any way to rank the matches.
In order to be able capture partial matches as well as leverage unstructured data, approaches to matchmaking based on machine learning and text search were introduced.

A forerunner of this research direction was iSPARQL [@Kiefer2007], which extended SPARQL with similarity functions.
It demonstrated that both combining logical deduction with statistical induction and exploiting textual information can improve matchmaking.
Machine learning and text search are also employed for matchmaking within the Web of Needs project [@Kleedorfer2014].
Here, real-time matchmaking is delivered by searching semi-structured data using Apache Solr^[<http://lucene.apache.org/solr>] and batch matchmaking built on RESCAL [@Nickel2011] in a similar fashion to one of our approaches.
The matchmakers in the Web of Needs are generic, based on a common denominator of data about demands and offers, including the features such as title, description, tags, or price [@Friedrich2016].
On the contrary, our approach is specific to the public procurement domain, so that it can leverage more powerful, but domain-specific features in matchmaking.

Besides matchmaking applications, our work relates to RDF vocabularies that describe demands or offers and generic technologies conducive to applications similar to matchmaking.
RDF vocabularies enable to bestow data with semantic features that matchmaking can leverage.
Call for Anything^[<http://vocab.deri.ie/c4n>] is one of the first vocabularies for formulating demands as data.
GoodRelations [@Hepp2008] is an ontology for e-commerce on the Web.
It focuses more on offers, but enables to express demands as ideal offers.
Apart from these generic vocabularies, vocabularies describing the public procurement market were designed, such as LOTED2 [@Distinto2016] or Public Procurement Ontology [@MunozSoro2016]. 

LOD-enabled recommender systems
Instance matching
Semantic search

## Related vocabularies

Semantic matchmaking operates on data described by vocabularies and ontologies.
Vocabularies enable to bestow data with semantic features that matchmaking can leverage.
Support for matchmaking was one of the design goals of the Public Contracts Ontology (PCO), described in [Section @sec:pco], which we developed to represent public procurement data.
Here we present a review of related vocabularies that too can provide support for matchmaking.

Call for Anything (C4N)^[<http://vocab.deri.ie/c4n>] is a simple vocabulary for describing demands, such as calls for tenders or calls for papers.
C4N can be regarded as one of the first to aim for explicit formulation of demands on the Web.
However, the vocabulary features only rudimentary means to express what is sought by demands, as it relies on unstructured literals to specify the objects in demand.

GoodRelations [@Hepp2008] is an ontology for e-commerce on the Web.
It focuses on describing offers, which it views as promises, emphasizing the importance of good and explicitly captured relationships between entities in the e-commerce domain.
While the ontology is oriented towards supplies, its cookbook remarks that it is possible to *"use the very same GoodRelations vocabulary for the buy and the sell side of commerce."*^[<http://wiki.goodrelations-vocabulary.org/Cookbook/Seeks>]
In order to do that, the ontology proposes a conceptual symmetry between demand and supply.
It suggests to model demands as ideal offers (i.e. instances of `gr:Offering`) satisfying what that entities seek (i.e. link via the `gr:seeks` property).
In this way, GoodRelations can take advantage of its comprehensive vocabulary for offers to describe demands, including specifications of the demanded products and services or the payment conditions. 

<!-- LOTED2 -->

LOTED2 [@Distinto2016] is a legal ontology for public procurement notices.
As a legal ontology, it closely follows the EU directives governing public procurement, which we described in [Section @sec:legal-context].
As such, the ontology enables to describe the tendering process for public contracts in legal terms.
It pays a special attention to qualification criteria, which matchmaking may interpret as hard constraints for filtering bidders who are allowed to compete for public contracts.
As the name indicates, LOTED2 evolved from Linked Open Tenders Electronic Daily (LOTED) [@Valle2010], an effort to convert TED to RDF using a simple vocabulary that mirrored the structure of the source data.
The account on LOTED2 [@Distinto2016, p. 21] proposes matchmaking as future work and suggests matching TED to OpenCorporates,^[<https://opencorporates.com>] an open database of companies, using reasoning and matching classifications.

<!-- PPROC -->

Public Procurement Ontology (PPROC) [@MunozSoro2016] is an ontology that covers the complete life-cycle of public contracts, ranging from their issue to termination.
As such, it supports both publication of public contracts as open data and management of public procurement processes in a transparent and accountable way.
Its stated underlying goal is to enable open access to procurement data to the public [@MunozSoro2015].
Although the publications about the ontology are agnostic of its intended use in applications, the ontology was already used in practice for integration of public procurement data from Spanish administrative bodies.
It was adopted for public contracts of several authorities from the autonomous community of Aragón.

## Related technologies

We conclude this section with a brief overview of related technologies.
To the best of our knowledge, these technologies have not yet found use in matchmaking, although they were adopted for related tasks, such as in recommender systems.

LOD-enabled recommender systems [@DiNoia2012a; @DiNoia2012b; @DiNoia2016; @Thalhammer2012] constitute a source from which many technologies applicable to semantic matchmaking can be drawn.
These systems typically employ established techniques for producing recommendations, such as matrix factorization [@Koren2009], but enhance them with semantic features extracted from LOD.
Since the graph data model of LOD is conducive to the use of graph algorithms, some of the LOD-enabled recommender systems found uses for such algorithms or proposed novel algorithms operating on graph data.
Examples of this sort include personalized PageRank [@Nguyen2015], spreading activation [@Heitmann2014; @Heitmann2016], or WeightedNIPaths [@Ristoski2015].

Matchmaking can also derive inspiration from technologies in two broader research areas.
Instance matching [@Christen2012; @Bryl2014] is usually limited to discovering identity links, although its similarity measures and combination functions to aggregate similarity scores are also applicable to discovering matches between demands and supplies.
Semantic search [@Davies2009] can be considered a research area to which semantic matchmaking belongs.
Matchmaking can borrow many techniques from this parent, such as query expansion or retrieval from semi-structured data.
A notable example of a semantic search engine for RDF is SIREn [@Delbru2012], which extends Apache Lucene^[<http://lucene.apache.org>] with capabilities to search deeply nested data without a fixed schema.
