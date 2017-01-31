### Concrete data model

The concrete data model of the Czech public procurement data uses the PCO mixed with terms cherry-picked from other linked open vocabularies, such as Public Procurement Ontology (PPROC) ([Muñoz-Soro et al., 2016a](#MunozSoro2016a)), which directly builds upon PCO.
The data model's class diagram is shown in the following figure.

![Class diagram of the Czech public procurement data](img/vvz.png)

<!-- FIXME: Temporary placeholder. -->

The data model of the extracted data departs from PCO in several ways.
There are ad hoc terms in the `<http://linked.opendata.cz/ontology/isvz.cz/>` namespace to represent dataset-specific features of the Czech public procurement register.
Some of these terms are intermediate and are subsequently replaced during data transformation.

Contract objects expressed via the properties `pc:mainObject` and `pc:additionalObject` are qualified instead of linking CPV directly.
A proxy concept that links a CPV concept via `skos:closeMatch` is created for each contract object to allow qualification by concepts from the CPV's supplementary vocabulary.
The proxy concepts link their qualifier via `skos:related`.
For example, a contract may have *Electrical machinery, apparatus, equipment and consumables; lighting* (code `31600000`) as the main object, which can be qualified by the supplementary concept *For the energy industry* (code `KA16`).
This custom modelling pattern was adopted, since SKOS does not recommend any way to represent pre-coordination of concepts.^[<https://www.w3.org/TR/skos-primer/#secconceptcoordination>]

Data in the Czech public procurement register is represented using notices, such as prior information notices or contract award notices.
Notices are documents that inform about changes in the life-cycle of public contracts.
Using the terminology of the Jacobs and Walsh ([2004](#Jacobs2004)), notices are information resources describing contracts as non-information resources. 
Information resource is *"a resource which has the property that all of its essential characteristics can be conveyed in a message"* ([ibid.](#Jacobs2004)), so that it can be transferred via HTTP, which cannot be done with non-information resources, such as physical objects or abstract notions.

<!--
TODO: Add a (simplified) diagram of public contract lifecycle in terms of public notices.
-->

We represent contract notices as instances of subclasses of `pproc:Notice` from PPROC, since PCO does not include the concept of a contract notice.
Each notice pertains to a single contract, while a contract may link several notices informing about its life-cycle.
Notices provide a way to represent temporal dimension of contracts.
They serve as time-indexed snapshots tracking the evolution of contracts, based on the notice type and timestamp.
To a large extent we treat notices as intermediate resources, the data of which are combined to form a unified view of contracts during data fusion.
Nevertheless, in focusing on the central concept of the public contract, this modelling approach glances over the temporal dimension of other data.
For example, it does not accommodate expressing that a contracting authority was renamed.
Neither is it supported by PCO, which was designed as atemporal, since modelling temporal data remains an open research topic.

Apart from reusing the code lists incorporated in PCO, we employed a few others.
We extracted the code list standardizing categories of procured services as defined in the EU directive 2004/18/EC ([EU, 2004](#EU2004)).
This code list links CPV to the Central Product Classification (CPC).^[<http://unstats.un.org/unsd/cr/registry/cpc-2.asp>]
We also extracted several code lists enumerating the types of contract notices.
The EU-wide standard types of notices, including the prior information notice or the design contest notice, were published in 2004 and updated in 2014, with a few types removed, such as the public works concession, or added, such as the modification notice.^[<http://simap.ted.europa.eu/standard-forms-for-public-procurement>]
All code lists were represented in RDF using SKOS.

<!--
The temporal nature of the public procurement domain is important because much of the value of this data is transient and decreases as the data ages.
Due to the transient nature of public procurement data, the data that starts as a business opportunity ends up as a historic record.
-->
