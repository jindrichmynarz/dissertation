#### Public Contracts Ontology

[Public Contracts Ontology](https://github.com/opendatacz/public-contracts-ontology) (PCO) is a lightweight RDF vocabulary for describing data about public contracts.
The vocabulary was developed by the Czech OpenData.cz initiative since 2011, while this thesis' author has been one of its editors.
Its design is driven by what data is available, mostly in the Czech and EU-level public procurement.
This approach *"implies that vocabularies should not use conceptualizations that do not match well to common database schemas in their target domains"* ([Mynarz, 2014](#Mynarz2014a)).
Yet in fact, since the disclosure of public procurement data is mandated by law, PCO is indirectly a legal ontology.

PCO establishes a reusable conceptual vocabulary to provide a consistent way of describing public contracts.
It follows a simple snowflake structure oriented around contract as the central concept.
It extensively reuses and links other vocabularies, such as [Dublin Core Terms](http://dublincore.org/documents/dcmi-terms) or [GoodRelations](http://www.heppnetz.de/ontologies/goodrelations/v1.html).
Several properties in PCO have their range restricted to values enumerated in code lists.
For example, there is a code list for procedure types, including open or restricted procedures.
These core code lists are represented using SKOS and are a part of the vocabulary.
The design of PCO is described in more detail in Nečaský et al. ([2014](#Necasky2014)).

The vocabulary was used to a large extent in the [LOD2 project](http://aksw.org/Projects/LOD2.html).
For example, it was applied to Czech, British, EU, or Polish public procurement data.
In this way, we validated the reusability of the vocabulary across various legal environments.

<!--
*Anti-SEO* coined by Jiří Skuhrovec
<http://blog.aktualne.cz/blogy/jiri-skuhrovec.php?itemid=13827>
-->

#### Concrete data model

Modelling data using the Public Contracts Ontology mixed with terms cherry-picked from other linked open vocabularies, such as Public Procurement Ontology (PPROC).

While PCO strives for conceptual parsimony, this feature is missing in some source data models that needlessly replicate isomorphic data structures.
For example, the Czech public procurement register numbers XML elements for award criteria (as `Kriterium1`, `Kriterium2` etc.) instead of using one element connected with a relation of higher arity.
([Mynarz, 2014](#Mynarz2014a))

PCO is atemporal.
([Mynarz, 2013](#Mynarz2013))
In practice, we used time-indexed information resources (public notices) that refer to the non-information resource of a public contract.
This is convenient because it matches the way public procurement data is typically published.
However, in focusing on the central concept of a public contract, it glances over other data from the public procurement domain that has temporal dimension too.
<!-- In fact, no data can be marked as atemporal. -->
For example, this approach does not accommodate expressing that a contracting authority was renamed.
The succession of date-indexed public notices provides a simplified model of time.
The temporal nature of the public procurement domain is important because much of the value of this data is transient and decreases as the data ages.
Due to the transient nature of public procurement data, the data that starts as a business opportunity ends up as a historic record.
Modelling temporal data is an open research topic, which is outside of the scope of this thesis.

The data in the Czech public procurement register is represented using forms.
Forms are documents that inform about public contracts.
For example, these forms include prior information notices or contract award notices.
Using the terminology of the semantic web, the forms are information resources.

<!--
Several deviations from the Public Contracts Ontology:
- For example, qualified CPV codes.
- Ad hoc terms (some intermediate ones).
  - Intermediate terms in the `<http://linked.opendata.cz/ontology/isvz.cz/>` namespace.
-->

<!--
TODO: Add a UML class diagram of the data model.
Also display computed cardinalities.
This can be used for visual validation of the ETL's results.
-->

<!-- 
# Out-takes:

The aim for reusability corresponds with the principle of minimal ontological commitment ([Gruber, 1993](#Gruber1993)).
Reasoning with data was its explicit non-goal.
As a result, the vocabulary does not feature sufficient ontological constructs to allow reasoning.
*"The prime aim of vocabulary is communication instead of representation"* ([Mynarz, 2014](#Mynarz2014a)).
-->
