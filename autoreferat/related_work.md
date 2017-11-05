# Related work {#sec:related-work}

<!-- stav řešení problematiky v ČR a ve světě -->
<!-- TODO: This needs to be substantially shortened. -->

In order to help discern the progress beyond the state of the art in our contributions, we briefly survey the research related to our work.
This overview includes matchmaking applications as well as related vocabularies and technologies. 

Early matchmaking in 1990s adopted reasoning with description logics (DL) and communication between software agents, such as in @Kuokka1995.
DL remained the basis of matchmaking at the onset of 2000s when the semantic web initiative arose.
Unlike the prior solutions, the newer matchmakers were built with ontological languages, such as the Web Ontology Language (OWL) [@DiNoia2004], that encoded explicit semantics.
Matchmaking queries were formulated as classes of matches, so that matches could be tested via subsumption or satisfiability of the class constraints by reasoning in DL.

Using reasoners for matchmaking turned out to be problematic due to limited expressivity of DL constructs and poor performance for larger data.
SPARQL [@Prudhommeaux2008], released in 2008, spawned approaches to matchmaking via production rules implemented as database queries (e.g., @Salvadores2008 or @Radinger2013), improving both on expressivity and scalability.

Perhaps the first application of matchmaking in public procurement was conceived in the Spanish research project 10ders Information Services.^[<http://rd.10ders.net>]
A part of this project called Methods on Linked Data for E-procurement Applying Semantics (MOLDEAS) [@AlvarezRodriguez2012] explored the application of semantic web technologies in public procurement.

## Related applications

<!-- 10ders Information Services -->

Overall, this project aimed to design an interoperable architecture of a pan-European platform for aggregating and mediating public procurement notices in the EU.
MOLDEAS covered algorithms for enriching data about public procurement notices [@AlvarezRodriguez2011b], integration of diverse data sources via linked data [@AlvarezRodriguez2011a], and matchmaking via SPARQL enhanced with query expansion [@AlvarezRodriguez2011c] or spreading activation [@AlvarezRodriguez2013, p. 118].
Unfortunately, it is difficult to compare the results matchmaking in MOLDEAS with our approach, because neither implementation details nor evaluation were revealed in the papers describing this work.
The project emphasized product classification schemes and devoted extensive efforts to converting such classifications to RDF and linking them.
Product Types Ontology (PTO),^[<http://www.productontology.org>] a product ontology derived from Wikipedia, was selected as a linking hub to tie these classifications together.

10ders Information Services also involved Euroalert.net [@Marin2013],^[<https://euroalert.net>] a commercial undertaking that alerts small and medium enterprises about relevant public sector information, including current public contracts.
Euroalert.net generates alerts by matching the profiles of its subscribers to an incoming stream of published calls for tenders from Tenders Electronic Daily (TED).^[<http://ted.europa.eu>]
TED is an EU-wide register of public procurement that aggregates data about public contracts from the EU member states.
According to the public description of Euroalert.net, its matchmaking is based on comparison of keywords and code lists and does not exploit semantics or linked open data. 

While SPARQL improves on reasoning-based matchmaking in terms of better expressivity and performance, queries need to be restricted to exact matches for the most part in order to maintain a good runtime.
A fundamental feature of matchmaking is ranking matches by the degree to which they satisfy a query.
Exact matching, to the contrary, produces only matches and non-matches, without any way to rank the matches.
Moreover, exact matches in SPARQL are optimized for structured data, so that performance degrades if SPARQL queries analyse semi-structured or unstructured data, such as literals, which may nevertheless supply valuable data to matchmaking.
Concerns such as these led to the development of approaches to matchmaking that involved full-text search or machine learning.

A forerunner of this research direction was iSPARQL [@Kiefer2007].
iSPARQL extends SPARQL with similarity measures implemented using Apache Jena^[<https://jena.apache.org>] with custom property functions.
In this way, it allows to combine graph pattern matching with similarity-based retrieval within a single query.
While conceived as a general approach, it was also applied to matchmaking of web services [@Kiefer2008].
This application coupled iSPARQL with machine learning in order to improve the detection of approximate matches. 
This use case demonstrated that the hybrid *"combination of logical deduction and statistical induction produces superior performance over logical inference only"* [@Kiefer2008, p. 473].
Moreover, the similarity-based queries *"that exploit textual information of the services turned out to be very effective"* [@Kiefer2008, p. 475].
Both these findings greatly influenced our approaches to matchmaking.
For example, we leverage machine learning in the RESCAL-based matchmaking.

Another attempt to go beyond SPARQL was the initial matchmaker developed for the PC Filing App [@Snoha2013] in the context of the LOD2 project.^[<http://lod2.eu>]
PC Filing App was a content management system for administering public contracts by contracting authorities. 
The matchmaker integrated in this application combined SPARQL, which retrieved the matches satisfying the declared hard constraints, with a custom Java implementation of similarity measures between the pre-filtered matches.
While its second step enabled the matchmaker to leverage literals more effectively, the footprint of its in-memory implementation based on Java objects led to its poor performance.
Our SPARQL-based matchmaker later replaced this matchmaker in the LOD2 project.

A related research effort that closely matches the objectives pursued by our work is the Web of Needs project [@Kleedorfer2014].
Its *"overall goal is to create a decentralized infrastructure that allows people to publish documents on the Web which make it possible to contact each other"* [@Kleedorfer2013].
Web of Needs thus covers the entire distributed infrastructure for marketplaces on the Web with matchmaking being just one of its components.
The infrastructure supports three principal tasks: describing supply or demand, identifying trading partners, and conducting a transaction [@Kleedorfer2014].
The proposed process overview involving these tasks, described in detail in @Kleedorfer2016, includes online and offline matchmaking.
The online matchmaking, which is capable of serving queries in real time, is implemented via full-text search in semi-structured data using Apache Solr.^[<http://lucene.apache.org/solr>]
The offline matchmaking, which delivers results periodically as it processes queries in batches, is implemented using machine learning via RESCAL [@Nickel2011].
It thus closely resembles our matchmaker based on the same technology.
Detailed evaluation of the offline matchmaker is available in @Friedrich2015. 
While our approaches to matchmaking mirror the ones in the Web of Needs to a large extent, their fundamental difference is the application to the public procurement domain.
Matchmakers in the Web of Needs are generic, since they are not tuned for any specific use case.
Instead, they support common matchmaking scenarios shared in many domains, so they are based on a common denominator of data about demands and offers, including features such as title, description, tags, or price [@Friedrich2016].
However, the architecture of the Web of Needs allows extensions to particular vertical marketplaces, such as the public procurement, so that more powerful domain-specific features can be leveraged in matchmaking.

An alternative tensor-based approach to matchmaking semantic web services is described in [@Szwabe2015].
This proposal combines tuple-based probabilistic tensor modeling with covariance-based multilinear filtering.
Extensive evaluation shows the presented approach as superior to other matchmaking methods for the evaluated task.

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
