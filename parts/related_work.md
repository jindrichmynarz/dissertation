## Related work {#sec:related-work}

Before we present our approaches to matchmaking we survey the research related to our work.
This section summarizes the background to our research and helps to discern the progress beyond the state of the art in our contributions.
This overview of the related work is divided into matchmaking applications, vocabularies for matchmaking, and technologies related to matchmaking.

### Related applications

<!-- Description logics -->

Early matchmaking dates back to the 1990s.
Matchmakers proposed during that era often adopted reasoning with description logics (DL) and communication between software agents.
An example of such approach is the work of Kuokka and Harada [-@Kuokka1995], who used Knowledge Query and Manipulation Language (KQML) to describe messages exchanged between agents participating in matchmaking.
However, without a common vocabulary the semantics of the messages had to be hardwired in application code.

<!-- Semantic web -->

A new wave of matchmaking based on DL arose with the semantic web initiative in the 2000s.
These efforts employed then created ontological languages, such as the DARPA Agent Markup Language plus the Ontology Inference Layer (DAML+OIL) [@GonzalezCastillo2001], or the Web Ontology Language (OWL) [@DiNoia2004; @DiNoia2007], and approached matchmaking as a task for DL reasoning.
Viewed in this way, matchmaking queries can be formulated as classes of matches and matches may thus be tested via subsumption or satisfiability of the class constraints.
Such inferences can be produced by standard reasoners, such as RACER [@Haarslev2001].
During this time, typical application domains for matchmaking included web service discovery [@Trastour2001; @Ankolekar2002] or e-commerce [@Li2004].

<!-- SPARQL -->

Using reasoners for matchmaking turned out to be problematic as their performance did not scale well for larger data.
In time with the initial release of SPARQL in 2008 [@Prudhommeaux2008] several efforts appeared that approached matchmaking via production rules implemented as database queries in SPARQL.
The turn to SPARQL provided matchmaking with better performance and expressivity. 
An example of this approach was used in the Market Blended Insight project [@Salvadores2008].
While this project was concerned mostly with data preparation and feature extraction, basic matchmaking was included as its part, using SPARQL to discover the matches satisfying `owl:onProperty` constraints.
Matchmaking was used as means of micro-segmentation to target specific agents exhibiting the propensity to buy.
An RDF version of the Standard Industry Classification 1992 was used to determine similarity of the matched entities.
A similar technique that combined SPARQL with RDFS entailment was explored in BauDataWeb [@Radinger2013].^[Example queries are available at <http://www.ebusiness-unibw.org/tools/baudataweb-queries>.]
BauDataWeb applied matchmaking to the European building and construction materials market.
Similarity of the matched entities was determined via the FreeClassOWL taxonomy.^[FreeClassOWL is an RDF version of <http://freeclass.eu>.]

<!-- 10ders Information Services -->

Perhaps the first application of matchmaking in public procurement was conceived in the Spanish research project 10ders Information Services.^[<http://rd.10ders.net>]
Overall, this project aimed to design an interoperable architecture of a pan-European platform for aggregating and mediating public procurement notices in the EU.
A part of the project that explored semantic web technologies in public procurement was called Methods on Linked Data for E-procurement Applying Semantics (MOLDEAS) [@AlvarezRodriguez2012].
MOLDEAS covered algorithms for enriching data about public procurement notices [@AlvarezRodriguez2011b], integration of diverse data sources via linked data [@AlvarezRodriguez2011a], and matchmaking via SPARQL enhanced with query expansion [@AlvarezRodriguez2011c] or spreading activation [@AlvarezRodriguez2013, p. 118].
Unfortunately, it is difficult to compare the results matchmaking in MOLDEAS with our approach, because neither implementation details nor evaluation were revealed in the papers describing this work.
The project emphasized product classification schemes and devoted extensive efforts to converting such classifications to RDF and linking them.
Product Types Ontology (PTO),^[<http://www.productontology.org>] a product ontology derived from Wikipedia, was selected as a linking hub to tie these classifications together.

<!-- MOLDEAS

Methods on Linked Data for E-procurement Applying Semantics (MOLDEAS): matchmaking via spreading activation [@AlvarezRodriguez2011a], [@AlvarezRodriguez2012], [@AlvarezRodriguez2013]
Used SPARQL for matchmaking organizations and public procurement notices along with several methods of query expansion [@AlvarezRodriguez2013, p. 118]

MOLDEAS explores a variety of semantic methods for processing public contracts data to offer rich services, such as advanced search.
Its overall architecture [@AlvarezRodriguez2011a] takes into account diverse sources, such as TED, BOE – the official bulletin of Spanish government, or BOPA – the official bulletin of the local government of the Spanish region of Asturias.
The data coming from disparate sources are combined using linked data technologies to allow for application of se- mantics methods, such as SPARQL query expansion and query performance optimization [@AlvarezRodriguez2011c] or spreading activation techniques used for information retrieval in graph data [@AlvarezRodriguez2011a]
Another research thread explored in MOLDEAS is constituted by the conversions of thesauri and product classifications to RDF [@Paredes2008]
Controlled vocabularies, such as public sector code lists or product classifications (for example, the Common Procurement Vocabulary or EUROVOC), are transformed to RDF, interlinked with external datasets, and used for indexing of public contracts data to enable intelligent services, such as complex subject-oriented queries.
Public Procurement Notices ontology was developed for the project, however it was not published.
-->

10ders Information Services also involved Euroalert.net [@Marin2013],^[<https://euroalert.net>] a commercial undertaking that alerts small and medium enterprises about relevant public sector information, including current public contracts.
Euroalert.net generates alerts by matching the profiles of its subscribers to an incoming stream of published calls for tenders from Tenders Electronic Daily (TED).^[<http://ted.europa.eu>]
TED is an EU-wide register of public procurement that aggregates data about public contracts from the EU member states.
According to the public description of Euroalert.net, its matchmaking is based on comparison of keywords and code lists and does not exploit semantics or linked open data. 

<!--
a commercial undertaking that aims to alert small and medium enterprises about relevant public tenders based on subscriber profile model
enhances the consumed open data to create information products and services with added value, such as customizable widgets.
Its approach is to use structured open data instead of relying on brittle techniques of screen-scraping.
Such decision results in a lower amount of data at first, however the service is made to be more reliable and sustainable in this way.
However, Euroalert.net currently does not expose any linked open data.
-->

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

<!--
(Actual matchmaking done (some of it in context of public procurement))

- IntelligentMatch
  - <http://www.intelligent-match.de>
  - German national project *IntelligentMatch* (2010 — 2012)^[<http://www.intelligent-match.de>] set as its goal to build up technological infrastructure for intelligent matchmaking.
  - Among the results of this project is *i-text*, a prototype of matchmaking engine targeted at the textile industry.
- Public procurement in Chile [@AravenaDiaz2016], matches potential bidders, uses natural language processing and latent semantic analysis, early stage
-->

### Related vocabularies

Semantic matchmaking operates on data described by vocabularies and ontologies.
Vocabularies enable to bestow data with semantic features that matchmaking can leverage.
Support for matchmaking was one of the design goals of the Public Contracts Ontology (PCO), described in [Section @sec:pco], which we developed to represent public procurement data.
Here we present a review of related vocabularies that too can provide support for matchmaking.

Call for Anything (C4N)^[<http://vocab.deri.ie/c4n>] is a simple vocabulary for describing demands, such as calls for tenders or calls for papers.
C4N can be regarded as one of the first to aim for explicit formulation of demands on the Web.
However, the vocabulary features only rudimentary means to express what is sought by demands, as it relies on unstructured literals to specify the objects in demand.

<!-- Call for Anything

a simple RDF vocabulary by the DERI's Linked Data Research Centre that is intended for expressing demand, such as calls for tenders or calls for papers
Call for Anything vocabulary can be considered as one of the first attempts towards a greater coverage of the side of demand, for which it provides means of expression.
However, the vocabulary does not provide guidance on the potentially complex modelling of call conditions and it features only a rudimentary functionality for expressing object of the call, relying on literals to convey the semantics of the demanded object.
-->

GoodRelations [@Hepp2008] is an ontology for e-commerce on the Web.
It focuses on describing offers, which it views as promises, emphasizing the importance of good and explicitly captured relationships between entities in the e-commerce domain.
While the ontology is oriented towards supplies, its cookbook remarks that it is possible to *"use the very same GoodRelations vocabulary for the buy and the sell side of commerce."*^[<http://wiki.goodrelations-vocabulary.org/Cookbook/Seeks>]
In order to do that, the ontology proposes a conceptual symmetry between demand and supply.
It suggests to model demands as ideal offers (i.e. instances of `gr:Offering`) satisfying what that entities seek (i.e. link via the `gr:seeks` property).
In this way, GoodRelations can take advantage of its comprehensive vocabulary for offers to describe demands, including specifications of the demanded products and services or the payment conditions. 

<!-- GoodRelations

GoodRelations is an ontology for the domain of e-commerce mainly focused at describing offerings on the Web.
GoodRelations, developed by Martin Hepp, takes a view of offerings as promises, emphasizing the importance of explicit capture of relationships (as hinted by the ontology’s name) between entities from the e-commerce domain, such as businesses, products, or services.
It provides a detailed conceptualization of the common resource types encountered within the e-commerce domain, such as business entities or terms and conditions under which products or services are offered, and the complex network of relationships linking these resource types together.

The difference in describing the sought product or service instead of the demanded one lies in linking the involved entity (`gr:BusinessEntity`) with the product or service (`gr:Offering`) via the `gr:seeks` property instead of `gr:offers`, which would be used for attaching offerings.
The offering (`gr:Offering`) is then described as the "ideal" offering satisfying the demand.
Leaving this difference aside, the way demands can be expressed follows the same guidelines as expression of offerings does.
-->

<!-- LOTED2 -->

LOTED2 [@Distinto2016] is a legal ontology for public procurement notices.
As a legal ontology, it closely follows the EU directives governing public procurement, which we described in [Section @sec:legal-context].
As such, the ontology enables to describe the tendering process for public contracts in legal terms.
It pays a special attention to qualification criteria, which matchmaking may interpret as hard constraints for filtering bidders who are allowed to compete for public contracts.
As the name indicates, LOTED2 evolved from Linked Open Tenders Electronic Daily (LOTED) [@Valle2010], an effort to convert TED to RDF using a simple vocabulary that mirrored the structure of the source data.
The account on LOTED2 [@Distinto2016, p. 21] proposes matchmaking as future work and suggests matching TED to OpenCorporates,^[<https://opencorporates.com>] an open database of companies, using reasoning and matching classifications.

<!-- LOTED -->

<!--
Tenders Electronic Daily (TED)^[<http://ted.europa.eu>]

primarily for data analytics applications (does not mention matchmaking)
delved into triplification of tenders in European Union coming from the Tenders Electronic Daily (TED) portal.
The project addressed conversion to RDF and interlinking of data from RSS feeds providing a timely access to the public contracts data from the EU member countries that are aggregated by TED.
By lifting the data by converting it to RDF and enriching it with well-defined structure and semantics, LOTED was able to apply novel data analysis methods in this field and showcase interactive visualizations.
The outcomes of the work dedicated to LOTED are available for reuse, since it is an open source project with its source code available online.

Source code: <https://sourceforge.net/projects/loted>

LOTED Ontology^[<http://loted.eu/ontology>]
closely matches the schema of the source data from TED
does not reuse other RDF vocabularies

LOTED data is linked to geographical entities in DBpedia and Geonames
-->

Public Procurement Ontology (PPROC) [@MunozSoro2016] is an ontology that covers the complete life-cycle of public contracts, ranging from their issue to termination.
As such, it supports both publication of public contracts as open data and management of public procurement processes in a transparent and accountable way.
Its stated underlying goal is to enable open access to procurement data to the public [@MunozSoro2015].
Although the publications about the ontology are agnostic of its intended use in applications, the ontology was already used in practice for integration of public procurement data from Spanish administrative bodies.
It was adopted for public contracts of several authorities from the autonomous community of Aragón.

### Related technologies

We conclude this section with a brief overview of related technologies.
To the best of our knowledge, these technologies have not yet found use in matchmaking, although they were adopted for related tasks, such as in recommender systems.

LOD-enabled recommender systems [@DiNoia2012a; @DiNoia2012b; @DiNoia2016; @Thalhammer2012] constitute a source from which many technologies applicable to semantic matchmaking can be drawn.
These systems typically employ established techniques for producing recommendations, such as matrix factorization [@Koren2009], but enhance them with semantic features extracted from LOD.
Since the graph data model of LOD is conducive to the use of graph algorithms, some of the LOD-enabled recommender systems found uses for such algorithms or proposed novel algorithms operating on graph data.
Examples of this sort include personalized PageRank [@Nguyen2015], spreading activation [@Heitmann2014; @Heitmann2016], or WeightedNIPaths [@Ristoski2015].

Matchmaking can also derive inspiration from technologies in two broader research areas.
Instance matching [@Christen2012; @Bryl2014] is usually limited to discovering equivalence relationships, although its similarity measures and combination functions to aggregate similarity scores are also applicable to discovering matches between demands and supplies.
Semantic search [@Davies2009] can be considered a research area to which semantic matchmaking belongs.
Matchmaking can borrow many techniques from this parent, such as query expansion or retrieval from semi-structured data.
A notable example of a semantic search engine for RDF is SIREn [@Delbru2012], which extends Apache Lucene^[<http://lucene.apache.org>] with capabilities to search deeply nested data without a fixed schema.
