# Introduction

<!-- What is the problem? -->

<!-- Goal: efficiency -->

The goal of this thesis is to increase the efficiency of the market process of demand meeting supply during its information phase.
In particular, this work focuses on the public procurement market in the Web environment. 

A key obstacle to achieving the stated goal is fragmentation of data on the Web.
Data about demands and offers is dispersed across a multitude of web sites, including electronic marketplaces or public sector registries. 
To get a broader picture about the market one must scan through the relevant yet heterogenous sources of data, each of which may expose a different access interface, most of which will be suitable only for humans to process.
Therefore, *"search and matchmaking between two business parties over the current Web are still very time-consuming if [...] information from multiple sources needs to be combined to assess the relevance or execute the query"* ([Radinger et al., 2013](#Radinger2013)).
To improve this situation, the broad goal of this thesis is to contribute to defragmentation of online markets by linking the data communicated between them.
Having links in between datasets on the Web that are traversable by machines may enable to query the distributed markets as a single virtual market.
Such virtual market may facilitate supply and demand to meet in a distributed linked open data infrastructure.

A fundamental prerequisite to making this happen is to have the data in question openly available in a machine readable format.
Open access to the data is needed to remove the information asymmetries between the actors in online marketplaces, which introduce unnecessary friction to the process of supply meeting demand.
Nonetheless, data describing demands or offers on the current Web is exposed predominantly in documents, such as public procurement notices or calls for papers.
Such documents are typically produced not with machine readability in mind, and thus their automated processing is difficult.
Therefore, it is necessary to make this implicit data explicit by expressing it in structured way.
Structuring data about both demands and offers in a granular fashion is especially crucial for complex multidimensional descriptions that cannot be simply reduced, such as to a single comparable number (e.g., a price tag).
Having access to structured data enables automated processing and granular descriptions provide a basis for novel functionalities.

In the public procurement domain, better information can improve the quality of government's decision making and thus make the allocation of public resources more efficient.
Matchmaking can help public bodies to find a more suitable supplier, while companies can benefit from finding business opportunities in relevent calls for tenders.
In effect, the ambition of the developed system is mainly to reduce passive waste with public funds ([Bandiera, Prat, Valletti, 2009](#Bandiera2009)), which, unlike active waste, does not benefit the decision-making civil servant, but instead is caused rather by lack of information, skills, and motivation.

Additional goals:

* Transparency through data integration: Prior to data integration the meaning of data is lost in the noise of user-generated data. Data integration cleans the view and provides greater overview over public procurement.
* Democratization of public procurement data analysis: Enables the rise of the armchair auditors.

The proposed solution to address the thesis' goal uses linked open data as a method for integrating data on the Web.
The means towards approaching the depicted vision consist of application of semantic web technologies for matching data about offers and demands on the Web.
To achieve the goal of machine readable data the semantic web stack offers a strong basis.
Resource Description Framework (RDF) may be used as a common formalism, while RDF vocabularies and ontologies may serve as shared conceptualizations for modelling data.
Data integration with linked data is based on explicit typed hyperlinks between datasets.

Matchmaking linked open data can use both statistical and semantic inference.
It can leverage both machine learning due to the volume of the data and semantic reasoning thanks to the formal representation of the data.

A key part of this research are the similarity metrics for multidimensional and heterogeneous data described using RDF.

<!-- Problem statement -->

General problems:

* Fragmentation of demand on the Web
* Passive waste in public procurement 

Specific problems:

* Data integration
* Feature construction for matchmaking
* How to engineer matchmaking methods to achieve high accuracy and diversity of recommendations?
* Can the proposed method achieve accuracy and diversity acceptable by domain experts?

<!-- Problem context -->

* Selection of a matching object; specifically for tenders
* Social context: Better matchmaking helps avoid passive waste with public resources.

<!-- Research domain -->

The domain of this research is an intersection of case-based recommender systems and semantic web knowledge engineering.

Stakeholders: Contracting authorities, bidders

<!-- Research goals -->

<!-- Scientific methods -->

* Design of software artefacts
* Experimentation

Evaluation:

* Offline experiments on retrospective data
* Online experiments - clickthrough rates
* Interviews with domain experts

<!-- Contributions -->

* Implemented matchmaking methods
* Tools implementing the methods (also auxiliary tools if no suitable ones are available)
* Reusable training/testing datasets

<!-- How do the chapters depend on each other? -->

<!--
As a use case, the challenge is to select, combine, and apply state-of-the-art techniques to a real-world scenario.
-->

<!--
## Core hypotheses
FIXME Feedback: De-emphasize hypotheses.

* Additional features obtained from linked open data can improve matchmaking.
* Matchmaking methods that are able to leverage textual data effectively surpass the methods that cannot.
  * Feedback: Too vague.
* Improving data quality has an larger impact on matchmaking than the sophistication of matchmaking algorithms.
* Combination of semantic and statistical features of data has a synergic effect that can produce better matchmaking results than when only semantic or statistical features are used.
-->

The following parts of this chapter provide preliminaries upon which the subsequent chapters extensively build.

The contributions presented in this thesis including methods and software were authored or co-authored by the thesis author, unless stated otherwise.

Both reused and developed software is listed in [appendix @sec:software].
