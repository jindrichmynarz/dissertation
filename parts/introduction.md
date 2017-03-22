# Introduction

<!--
For the first time in history we have data on past experiences in making public contracts, from which we can learn how to make better contracts.
Matchmaking is one way to use these experiences.
By learning from history we can agree on better deals.

Public contracts exist in a network of relationships between companies or people and so does the data about public contracts.
The relationships in data mirror the relationships in real world.
This is why it is important to combine data from multiple domain to learn about the context in which public contracts are made.
Here, semantics is a way to agree on meaning of things in data.
Semantic web is a way to agree on what things are, so that we can combine our data about the things.
-->

<!-- What is the problem? -->

In order for demand and supply to meet, they must learn about each other.
Data on demands and supplies thus needs to be accessible, discoverable, and usable.
In case of large data, it must also be machine readable, so that machines can make it usable for humans.
Relevant data may be fragmented across diverse data sources, which need to be integrated to enable effective use.
Manual data collection and integration takes a lot of effort.

Some manual effort involved in gathering and evaluation of data about demands and supplies can be automated by matchmaking.
Matchmakers are tools that retrieve data matching a query.
In the matchmaking setting, either demands or supplies are casted as queries while the other side is treated as the queried data.
The queries produce matches from the queried data ranked by their degree to which they satisfy a given query.

<!-- Goal: efficiency -->

Our work concerns matchmaking of bidders and public contracts. 
The primary motivation for our research is to improve the efficiency of resource allocation in public procurement by providing better information to the participants of the public procurement market.
We employ matchmaking as a way to find information that is useful for the market participants.
In the context of public procurement, matchmaking can suggest relevant business opportunities to bidders or recommend contracting authorities which bidders are suitable to be approached with a given public contract.

Our approach to matchmaking is based on two components: good data and good technologies.
We employ linked open data as a method to defragment and integrate public procurement data and enable to combine it with other data.
A key challenge in using linked open data is to reuse or develop appropriate techniques for data preparation.

We demonstrate how two generic approaches can be applied to the matchmaking task, namely case-based reasoning and statistical relational learning.
In the context of case-based reasoning, we casted matchmaking as top-$k$ recommendation.
We compared two technologies on this task: SPARQL and full-text search.
In the case of statistical relational learning, we approached matchmaking as link prediction.
We used tensor factorization with RESCAL [@Nickel2011] for this task.
Key challenges with these technologies involve feature selection, feature construction, and ranking via feature weights and combination functions for aggregating similarity scores of matches.

In order to explore the outlined approaches we prepared a Czech public procurement dataset that links several related open government data sources together, such as the business register or the postal addresses.
Our work can be therefore considered a concrete use case in the Czech public procurement.
Viewed as a use case, our task is to select, combine, and apply the state-of-the-art techniques to a real-world scenario.
Our key stakeholders in this use case are the participants in the public procurement market: contracting authorities, who represent the side of demand, and bidders, who represent the side of supply.
<!-- Different motivations: contracting authorities (public sector) vs. bidders (private sector) 
Both stakeholder groups represent different interests: contracting authorities those of the public sector and bidders those of the private sector.
This gives rise to an sophisticated interplay.
-->

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

<!-- Research goals -->

<!-- Scientific methods -->

We adopt the methods of the design science [@Hevner2004] in our research.
We design artefacts, including the Czech public procurement dataset and the matchmakers, and experiment with them during evaluation to tell which of their variants perform better.

<!-- Evaluation -->

Our key question to evaluate is whether we can develop a matchmaker that can produce results deemed acceptable by domain experts.
We evaluate the developed matchmakers both via offline experiments on retrospective data and via interviews with representatives of contracting authorities.
In terms of our target metrics, the recommended matches should exhibit both high accuracy and diversity.
In order to discover the key factors that improve matchmaking we compare the evaluation results produced by the developed matchmakers in their different configurations.

<!-- Designing an artefact is a way of "constructive proof". -->

<!-- Contributions -->

The principal contributions of our work are the implemented matchmaking methods and the reusable datasets for testing these methods.
Using experimental evaluation of these methods we derive general findings about the factors that have the largest impact on the quality of matchmaking of bidders to public contracts.

<!-- General note at the end of the introduction -->

The remaining parts of this introduction provide the preliminaries that the subsequent chapters build on.
We explain the fundamentals of linked open data, remark on the characteristics of the public procurement domain, define the matchmaking task and outline the broader approaches we adopted for this task, and finally we survey the related work.

The contributions presented in this thesis including methods and software were authored or co-authored by the thesis' author, unless stated otherwise.
Both reused and developed software is listed in [appendix @sec:software].
The abbreviations used throughout the text are gathered in [@sec:abbreviations].
All vocabulary prefixes used in the text can be resolved to their corresponding namespace IRIs via <http://prefix.cc>.

<!-- Out-takes -->

<!--
## Core hypotheses
FIXME Feedback: De-emphasize hypotheses.

* Additional features obtained from linked open data can improve matchmaking.
* Matchmaking methods that are able to leverage textual data effectively surpass the methods that cannot.
  * Feedback: Too vague.
* Improving data quality has an larger impact on matchmaking than the sophistication of matchmaking algorithms.
* Combination of semantic and statistical features of data has a synergic effect that can produce better matchmaking results than when only semantic or statistical features are used.
-->

<!-- Le old

A key obstacle to achieving the stated goal is fragmentation of data on the Web.
Data about demands and offers is dispersed across a multitude of web sites, including electronic marketplaces or public sector registries. 
To get a broader picture about the market one must scan through the relevant yet heterogenous sources of data, each of which may expose a different access interface, most of which will be suitable only for humans to process.
Therefore, *"search and matchmaking between two business parties over the current Web are still very time-consuming if [...] information from multiple sources needs to be combined to assess the relevance or execute the query"* [@Radinger2013].
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
In effect, the ambition of the developed system is mainly to reduce passive waste with public funds [@Bandiera2009], which, unlike active waste, does not benefit the decision-making civil servant, but instead is caused rather by lack of information, skills, and motivation.
-->

<!--
Side goals:

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
-->
