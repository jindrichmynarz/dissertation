### Concrete data model {#sec:concrete-data-model}

The concrete data model of the Czech public procurement data uses the PCO mixed with terms cherry-picked from other linked open vocabularies, such as Public Procurement Ontology (PPROC) [@MunozSoro2016], which directly builds upon PCO.
The data model's class diagram is shown in [@fig:vvz].

![Class diagram of the Czech public procurement data](img/vvz.png){#fig:vvz}

The data model of the extracted data departs from PCO in several ways.
There are ad hoc terms in the `<http://linked.opendata.cz/ontology/isvz.cz/>` namespace to represent dataset-specific features of the Czech public procurement register.
Some of these terms are intermediate and are subsequently replaced during data transformation.

Contract objects expressed via the properties `pc:mainObject` and `pc:additionalObject` are qualified instead of linking CPV directly.
A proxy concept that links a CPV concept via `skos:closeMatch` is created for each contract object to allow qualification by concepts from the CPV's supplementary vocabulary.
The proxy concepts link their qualifier via `skos:related`.
For example, a contract may have *Electrical machinery, apparatus, equipment and consumables; lighting* (code `31600000`) assigned as the main object, which can be qualified by the supplementary concept *For the energy industry* (code `KA16`).
This custom modelling pattern was adopted, since SKOS does not recommend any way to represent pre-coordination of concepts.^[<https://www.w3.org/TR/skos-primer/#secconceptcoordination>]

Data in the Czech public procurement register is represented using notices, such as prior information notices or contract award notices.
Notices are documents that inform about changes in the life-cycle of public contracts.
Using the terminology of Jacobs and Walsh [-@Jacobs2004], notices can be considered information resources describing contracts as non-information resources. 
Information resource is *"a resource which has the property that all of its essential characteristics can be conveyed in a message"* [@Jacobs2004], so that it can be transferred via HTTP.
On the contrary, non-information resources, such as physical objects or abstract notions, cannot be transferred via HTTP.

<!--
TODO: Add a (simplified) diagram of public contract life-cycle in terms of public notices.
-->

We represent contract notices as instances of the subclasses of `pproc:Notice` from PPROC, since PCO does not include the concept of a contract notice.
PCO treats notices as mere artefacts of the document-based communication in public procurement.
Each notice pertains to a single contract, while a contract may link several notices informing about its life-cycle.
Notices thus provide a way to represent the temporal dimension of contracts.
They serve as time-indexed snapshots tracking the evolution of contracts, based on the notice type and its timestamp.
To a large extent, we treat notices as intermediate resources, the data of which are combined to form a unified view of contracts during data fusion.
Nevertheless, in focusing on the central concept of the public contract, this modelling approach glances over the temporal dimension of other data.
For example, it does not accommodate expressing that a contracting authority was renamed.
Neither is it supported by PCO, which was designed as atemporal, since modelling temporal data remains an open research topic.

Apart from reusing the code lists incorporated in PCO, we employed a few others.
We extracted the code list standardizing categories of procured services as defined in the EU directive 2004/18/EC [@EU2004].
This code list links CPV to the Central Product Classification (CPC).^[<http://unstats.un.org/unsd/cr/registry/cpc-2.asp>]
We also extracted several code lists enumerating the types of contract notices.
The EU-wide standard types of notices, including the prior information notice or the design contest notice, were published in 2004 and updated in 2014, with a few types removed, such as the public works concession, or added, such as the modification notice.^[<http://simap.ted.europa.eu/standard-forms-for-public-procurement>]
All these code lists were represented in RDF using SKOS.

The diagram of the concrete data model in the [@fig:vvz] shows the Czech public procurement register data after the steps described in this chapter were applied.
As is apparent from the cardinalities of many properties, the dataset's quality is hardly optimal.
Maximum cardinalities of several properties are higher than expected due to several reasons.
Some entities were inadvertently merged due to their unreliable identifiers.
For example, there are few public contracts that share the placeholder identifier `1`.
We adopted several heuristic counter-measures to avoid fusing distinct entities, such as in case of the previous example, but we could not ensure the reliability of all identifiers in general.
Another cause of the high cardinalities is the incomplete data fusion due to insufficient information needed to decide on which values to drop and which ones to keep.
Once the hints for data fusion, such as the semantics or temporal order of contract notices, had been used up, there was no more guidance for preferring particular values.
When this happened, we either resorted to random sampling or left the data as it was.
Ultimately, further improvements in data quality can be made in line with the pay-as-you-go approach if the invested effort is offset by the gains obtained in matchmaking.

<!--
The temporal nature of the public procurement domain is important because much of the value of this data is transient and decreases as the data ages.
Due to the transient nature of public procurement data, the data that starts as a business opportunity ends up as a historic record.
-->
