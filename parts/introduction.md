# Introduction

<!--
Explain why a more precise title would be "Matchmaking public procurement linked open data".
Explain why such a significant share of the dissertation is devoted to data preparation.
-->

The goal of this thesis is to increase the efficiency of the market process of demand meeting supply during its information phase.
In particular, this work focuses on the public procurement market in the Web environment. 

A key obstacle to achieving the stated goal is fragmentation of data on the Web.
Data about demands and offers is dispersed across a multitude of web sites, including e-shops or public sector registries. 
To get a broader picture about the market one must scan through the relevant yet heterogenous sources of data, each of which may expose a different access interface, most of which will be suitable only for humans to process.
Therefore, *"search and matchmaking between two business parties over the current Web are still very time-consuming if [...] information from multiple sources needs to be combined to assess the relevance or execute the query"* ([Radinger et al., 2013](#Radinger2013)).
To improve this situation, the broad goal of this thesis is to contribute to defragmentation of online markets by linking the data communicated between them.
Having links in between datasets on the Web that are traversable by machines may enable to query the distributed markets as a single virtual market.
Such virtual market may facilitate for supply and demand to meet in a distributed linked open data infrastructure.

A fundamental prerequisite to making this happen is to have the data in question openly available in a machine readable format.
Open access to the data is needed to remove the information asymmetries between the actors in online marketplaces, which introduce unnecessary friction to the process of supply meeting demand.
Nonetheless, data describing demands or offers on the current Web is exposed predominantly in documents, such as public procurement notices or calls for papers.
Such documents are typically produced not with machine readability in mind, and thus their automated processing is difficult.
Therefore, it is necessary to make this implicit data explicit by expressing it in structured way.
Structuring data about both demands and offers in a granular fashion is especially crucial for complex multidimensional descriptions that cannot be simply reduced, such as to a single comparable number (e.g., a price tag).
Having access to structured data enables automated processing and granular descriptions provide a basis for novel functionalities.

Open data can balance information asymmetries between the members of the market caused by fragmentation of data distributed on the Web.
Better informedness can then lead to better decisions of the market's participants.
A key step in this direction is better integration of data on the Web.

In the public procurement domain, better information can improve the quality of government's decision making and thus make the allocation of public resources more efficient.
Matchmaking can help public bodies to find a more suitable supplier, while companies can benefit from finding business opportunities in relevent calls for tenders.
In effect, the ambition of the developed system is mainly to reduce passive waste with public funds ([Bandiera et al., 2009](#Bandiera2009)), which, unlike active waste, does not benefits the decision-making civil servant, but instead is caused rather by lack of information, skills, and motivation.

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

To frame matchmaking within the process of demand meeting supply, it occurs during the information phase, in which *"participants to the market seek potential partners"* ([Di Noia et al., 2004](#DiNoia2004)).
In this sense, demands for products and services correspond to information needs and the aim of matchmaking is to retrieve the information that will satisfy them.

Contributions: <!-- They are also in the conclusions. -->

Domains of research:

* Knowledge engineering
* Recommender systems

* Methods
* Tools implementing the methods (also auxiliary tools if no suitable ones are available)

The contributions presented in this thesis including methods and software were authored or co-authored by the thesis author, unless specified otherwise.

## Core hypotheses

* Additional features obtained from linked open data can improve matchmaking.
* Matchmaking methods that are able to leverage textual data effectively surpass the methods that cannot.
* Improving data quality has an larger impact on matchmaking than the sophistication of matchmaking algorithms.
* Combination of semantic and statistical features of data has a synergic effect that can produce better matchmaking results than when only semantic or statistical features are used.

Preliminaries
- Minimal introductions to the topics covered in this thesis to enable comprehension of the further text.

## Matchmaking

We used data from the Czech public procurement register to evaluate the proposed matchmaking methods.
