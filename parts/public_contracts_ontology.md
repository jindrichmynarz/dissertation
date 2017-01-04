#### Public Contracts Ontology

<!-- Use the material from Nečaský, 2014. -->

[Public Contracts Ontology](https://github.com/opendatacz/public-contracts-ontology) (PCO) is a lightweight RDF vocabulary for describing data about public contracts.
<!-- *"The prime aim of vocabulary is communication instead of representation"* ([Mynarz, 2014](#Mynarz2014a)). -->
It follows a data-driven design guided by what data is available, mostly in the Czech and EU-level public procurement.
<!-- In a sense, the data reflects the law mandating disclosure, so PCO is indirectly driven by law. -->
*"Data-driven approach implies that vocabularies should not use conceptualizations that do not match well to common database schemas in their target domains"* ([Mynarz, 2014](#Mynarz2014a)).
It establishes a reusable conceptual vocabulary to provide a consistent way of describing public contracts.
<!-- Reusability corresponds with the principle of minimal ontological commitment. -->
Reasoning with data was its explicit non-goal.
As a result, the vocabulary does not feature sufficient ontological constructs to allow reasoning.
It follows a simple snowflake structure where contract is the central concept.
It extensively reuses and links other vocabularies, such as [Dublin Core Terms](http://dublincore.org/documents/dcmi-terms) or [GoodRelations](http://www.heppnetz.de/ontologies/goodrelations/v1.html).
The vocabulary was used extensively in the [LOD2 project](http://aksw.org/Projects/LOD2.html).
For example, it was applied to Czech, British, EU, or Polish public procurement data.
In this way, we validated the reusability of the vocabulary. 
The vocabulary was developed by the Czech OpenData.cz initiative since 2011.
This thesis' author is one of the PCO's editors.

Modelling data using the Public Contracts Ontology mixed with terms cherry-picked from other linked open vocabularies, such as Public Procurement Ontology (PPROC).

The vocabulary is atemporal.
Since the concern with time is a general one, we relegated it to the lower level data storage methods. <!-- Really? -->
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

Several properties in PCO have their range restricted to values enumerated in code lists.
For example, there is a code list for procedure types, including open or restricted procedures.
Code lists provide a common reference points for data integration.
Data integration attempts to reconcile values from source data with the reference concepts from code lists.

PCO strives for conceptual parsimony.
This feature is missing in some source data models that needlessly replicate isomorphic data structures.
For example, the Czech public procurement register numbers XML elements for award criteria (as `Kriterium1`, `Kriterium2` etc.) instead of using one element connected with a relation of higher arity.
([Mynarz, 2014](#Mynarz2014a))

<!--
*Anti-SEO* coined by Jiří Skuhrovec
<http://blog.aktualne.cz/blogy/jiri-skuhrovec.php?itemid=13827>
-->
