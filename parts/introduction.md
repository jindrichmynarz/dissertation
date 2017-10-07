# Introduction

<!-- What is the problem? -->

In order for demand and supply to meet, they must learn about each other.
Data on demands and supplies thus needs to be accessible, discoverable, and usable.
As data grows to larger volumes, its machine-readability becomes paramount, so that machines can make it usable for people, for whom dealing with large data is impractical.
Moreover, relevant data may be fragmented across diverse data sources, which need to be integrated to enable their effective use.
Nevertheless, when data collection and integration is done manually, it takes a lot of effort.

Some manual effort involved in gathering and evaluation of data about demands and supplies can be automated by matchmaking.
Simply put, matchmakers are tools that retrieve data matching a query.
In the matchmaking setting, either demands or supplies are cast as queries while the other side is treated as the queried data.
The queries produce matches from the queried data ranked by their degree to which they satisfy a given query.

<!-- Motivation: efficiency -->

Our work concerns matchmaking of bidders and public contracts.
The primary motivation for our research is to improve the efficiency of resource allocation in public procurement by providing better information to the participants of the public procurement market.
We employ matchmaking as a way to find information that is useful for the market participants.
In the context of public procurement, matchmaking can suggest relevant business opportunities to bidders or recommend to contracting authorities which bidders are suitable to be approached for a given public contract.

<!--
For the first time in history we have open data on past experiences in making public contracts.
Using this data we can learn how to make better contracts.
Contracting authorities and bidders can learn from the history of public procurement to be able to agree on better deals.
Matchmaking is one way to learn from these experiences.

Public contracts exist in a network of relationships between organizations.
This network manifests in the data about public contracts.
The relationships in the data mirror the relationships in the real world.
This is why it is important to combine data from multiple domains to learn about the context in which public contracts are made.
Here, semantics is a way to agree on meaning of things in the data.
Semantic web is a way to agree on what things are, so that we can combine the data about the things.

## Matchmaking vs. advertising

Matchmaking substitutes advertising.
Business models based on advertising distort the design of web services.
=> Motivation
Personalization makes matchmaking approach many-to-1 advertising.
-->

## Research topic

Our approach to matchmaking is based on two components: good data and good technologies.
We employ linked open data as a method to defragment and integrate public procurement data and enable to combine it with other data.
A key challenge in using linked open data is to reuse or develop appropriate techniques for data preparation.

We demonstrate how two generic approaches can be applied to the matchmaking task, namely case-based reasoning and statistical relational learning.
In the context of case-based reasoning, we treated matchmaking as top-$k$ recommendation.
We used the SPARQL [@Harris2013] query language to implement this task.
In the case of statistical relational learning, we approached matchmaking as link prediction.
We used tensor factorization with RESCAL [@Nickel2011] for this task.
The key challenges of matchmaking by these technologies involve feature selection or feature construction, ranking by feature weights, and combination functions for aggregating similarity scores of matches.
Our work discusses these challenges and proposes novel ways of addressing them.

In order to explore the outlined approaches we prepared a Czech public procurement dataset that links several related open government data sources together, such as the Czech business register or the postal addresses from the Czech Republic.
Our work can be therefore considered a concrete use case in the Czech public procurement.
Viewed as a use case, our task is to select, combine, and apply the state-of-the-art techniques to a real-world scenario.
Our key stakeholders in this use case are the participants in the public procurement market: contracting authorities, who represent the side of demand, and bidders, who represent the side of supply.
The stakeholder groups are driven by different interests; contracting authorities represent the public sector while bidders represent the private sector, which gives rise to a sophisticated interplay of the legal framework of public procurement and the commercial interests.

<!-- Problem statement

Specific problems:

* Data integration
* Feature construction for matchmaking
* How to engineer matchmaking methods to achieve high accuracy and diversity of recommendations?
-->

<!-- Problem context 

* Selection of a matching object; specifically for tenders
* Social context: Better matchmaking helps avoid passive waste with public resources.
-->

<!-- Research domain

The domain of this research is an intersection of matchmaking and semantic web knowledge engineering.
-->

## Goals and methods

<!-- Research goals -->

Our research goal is to explore matchmaking of public contracts to bidders operating on linked open data.
In particular, we want to explore what methods can be adopted for this task and discover the most salient factors influencing the quality of matchmaking, with a specific focus on what linked open data enables.
In order to pursue this goal we prepare public procurement linked open data and develop software for matchmaking.
Our secondary target implied by our research direction is to test the available implementations of the semantic web technologies for handling linked open data and, if these tools are found lacking, to develop auxiliary tools to support data preparation and matchmaking.
These secondary goals were not formulated upfront; we only specified them explicitly as we progressed the pursuit of our primary goal.

<!-- Prerequisites -->

In order to be able to deliver on the stated goals, their prerequisites must be fulfilled.
Applied research depends on the availability of its building blocks.
Our research is built on open data and open-source software.
We need public procurement data to be available as open data, as described in the [@sec:open-data].
The data must be structured in a way from which a semantic description of the data can be created, implying that the data is machine-readable and consistent.
Consistency of the data arises from standardization, including the adherence to fixed schemas and code lists.
We conceive matchmaking as a high-level task based on many layers of technology.
Both our data preparation tools and matchmakers build on open-source components.
In the pursuit of our goals we reused and orchestrated a large set of existing open-source software.

<!-- Scientific methods -->

We adopt the methods of the design science [@Hevner2004] in our research.
We design artefacts, including the Czech public procurement dataset and the matchmakers, and experiment with them to tell which of their variants perform better.
Viewed this way, our task is to explore what kinds of artefacts for matchmaking of public contracts to bidders makes linked open data feasible to build.

<!-- Evaluation -->

The key question to evaluate is whether we can develop a matchmaker that can produce results deemed useful by domain experts representing the stakeholders.
We evaluate the developed matchmakers via offline experiments on retrospective data. <!-- and via interviews with representatives of contracting authorities. -->
In terms of our target metrics, we aim to recommend matches exhibiting both high accuracy and diversity.
In order to discover the key factors that improve matchmaking we compare the evaluation results produced by the developed matchmakers in their different configurations.

<!--
Designing an artefact is a way of "constructive proof".
Designing the matchmakers can be considered a constructive proof to answer our question.
-->

<!-- Contributions -->

The principal contributions of our work are the implemented matchmaking methods, the reusable datasets for testing these methods, and generic software for processing linked open data.
By using experimental evaluation of these methods we derive general findings about the factors that have the largest impact on the quality of matchmaking of bidders to public contracts.

<!-- Limitations -->

We need to acknowledge the limitations of our contributions.
Our work covers only a narrow fraction of matchmaking that is feasible.
The two methods we applied to matchmaking are evaluated on a single dataset.
Narrowing down the data we experimented with to one dataset implies a limited generalization ability of our findings.
Consequently, we cannot guarantee that the findings would translate to other public procurement datasets.
We used only quantitative evaluation with retrospective data, which gives us a limited insight into the evaluated matchmaking methods.
A richer understanding of the methods could have been obtained via qualitative evaluation or online evaluation involving users of the matchmakers.

## Outline

We follow a simple structure in this dissertation.
This chapter introduces our research and explains both the preliminaries and context in which our work is built as well as surveying the related research ([@sec:related-work]) to position our contributions.
The dissertation continues with a substantial chapter on data preparation ([@sec:data-preparation]) that describes the extensive effort we invested in pre-processing data for the purposes of matchmaking.
In line with the characteristics of linked open data, the key parts of this chapter deal with linking ([@sec:linking]) and data fusion ([@sec:fusion]).
We follow up with a principal chapter that describes the matchmaking methods we designed and implemented ([@sec:methods]), which includes matchmaking based on SPARQL ([@sec:method-sparql]) and on tensor factorization by RESCAL ([@sec:method-rescal]).
The subsequent chapter discusses the evaluation ([@sec:evaluation]) of the devised matchmaking methods by using the datasets we prepared.
We experimented with many configurations of the matchmaking methods in the evaluation.
In this chapter, we present the results of selected quantitative evaluation metrics and provide interpretations of the obtained results.
Finally, the concluding chapter ([@sec:conclusions]) closes the dissertation, summarizing its principal contributions as well as remarking on its limitations that may be addresses in future research. 

The contributions presented in this dissertation including the methods and software were authored or co-authored by the dissertation's author, unless stated otherwise.
Both the reused and the developed software is listed in the [appendix @sec:software].
The abbreviations used throughout the text are collected at the end of the dissertation.
All vocabulary prefixes used in the text can be resolved to their corresponding namespace IRIs via <http://prefix.cc>.

<!-- Out-takes -->

<!--
## Core hypotheses

* Additional features obtained from linked open data can improve matchmaking.
* Matchmaking methods that are able to leverage textual data effectively surpass the methods that cannot.
  * Feedback: Too vague.
* Improving data quality has an larger impact on matchmaking than the sophistication of matchmaking algorithms.
* Combination of semantic and statistical features of data has a synergic effect that can produce better matchmaking results than when only semantic or statistical features are used.
-->

<!-- Le old

A key obstacle to achieving the stated goal is fragmentation of data on the Web.
Data about demands and offers is dispersed across a multitude of web sites, including electronic marketplaces or public sector registries. 
To get a broader picture about the market one must scan through the relevant yet heterogeneous sources of data, each of which may expose a different access interface, most of which will be suitable only for humans to process.
Therefore, *"search and matchmaking between two business parties over the current Web are still very time-consuming if [...] information from multiple sources needs to be combined to assess the relevance or execute the query"* [@Radinger2013].
To improve this situation, the broad goal of this dissertation is to contribute to defragmentation of online markets by linking the data communicated between them.
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
Matchmaking can help public bodies to find a more suitable supplier, while companies can benefit from finding business opportunities in relevant calls for tenders.
In effect, the ambition of the developed system is mainly to reduce passive waste with public funds [@Bandiera2009], which, unlike active waste, does not benefit the decision-making civil servant, but instead is caused rather by lack of information, skills, and motivation.
-->

<!--
Side goals:

* Transparency through data integration: Prior to data integration the meaning of data is lost in the noise of user-generated data. Data integration cleans the view and provides greater overview over public procurement.
* Democratization of public procurement data analysis: Enables the rise of the armchair auditors.

The proposed solution to address the dissertation's goal uses linked open data as a method for integrating data on the Web.
The means towards approaching the depicted vision consist of application of semantic web technologies for matching data about offers and demands on the Web.
To achieve the goal of machine readable data the semantic web stack offers a strong basis.
Resource Description Framework (RDF) may be used as a common formalism, while RDF vocabularies and ontologies may serve as shared conceptualizations for modelling data.
Data integration with linked data is based on explicit typed hyperlinks between datasets.

Matchmaking linked open data can use both statistical and semantic inference.
It can leverage both machine learning due to the volume of the data and semantic reasoning thanks to the formal representation of the data.

A key part of this research are the similarity metrics for multidimensional and heterogeneous data described using RDF.
-->

<!--
## Design science framing

### Design problems

Develop matchmakers

### Knowledge questions

Do the developed matchmakers provide value to bidders and contracting authorities?
(Are the matchmakers "good enough" (= accurate enough and diverse enough)?)
(Would users continue to use the matchmakers if they are provided with a demo?)
-->
