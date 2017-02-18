## Linking

Linking is a process of discovering co-referent identifiers.
Co-referent identifiers share the same referent, i.e. they refer to the same entity.
The existence of co-referent identifiers is possible, because linked data operates under the non-unique name assumption (non-UNA).
This assumption allows to publish distributed data without coordination required for agreeing on names.
However, queries and data analyses usually operate under the unique name assumption, and therefore they require a unified dataset without aliases for entities.
Consequently, the aim of linking is to make explicit links between non-unique names of entities, so that these entities can be unified in data fusion.
In this way, linking addresses the accidental variety of data published on the Web.

### Content-based addressing

In the absence of agreed upon identifiers, entities are referred to by their description.
Moreover, unlike RDF, some data formats, such as CSV, do not enable linking.
Lack of agreed upon identifiers established by a reliable authority leads to proliferation of aliases for equivalent entities.
Missing consensual identifiers are one of the key challenges in integration of public procurement data ([Alvarez-Rodríguez, Labra-Gayo, Ordoñez de Pablos, 2014](#AlvarezRodriguez2014)).

If descriptions with which entities are referred to are reliable, we can use content-based addressing to discover descriptions referring to the same entity.
Content-based addressing is a general approach for identifying entities by using their content.
In case of RDF entities, we assume that triples containing an entity's identifer to make up the entity's description.
We typically restrict such triples to those in which an entity's identifier is in the subject position.
Various content signatures may be derived from such descriptions of entities.

Simple keys of entities can be derived from values of specific properties.
In case of subjects, keys can be objects of outbound properties that may be interpreted as inverse functional properties (i.e. instances of `owl:InverseFunctionalProperty`).
For example, the property `foaf:homepage`, which describes an entity's home page, is defined as an inverse functional property and as such it is usable as a simple key of an entity.
In case of objects, keys can be subjects of inbound properties that may be interpreted as functional object properties (i.e. instances of both `owl:FunctionalProperty` and `owl:ObjectProperty`).
For example, the property `pc:contractingAuthority`, which links a contract to its contracting authority, is defined as a functional object property, so that its subject can function as a simple key of the contracting authority.
Both kinds of simple key properties may be chained in property paths and followed to obtain keys that are not directly describing the entities they identify.
For example, the property path `pc:awardedTender/pc:bidder` can be treated as a functional object property, the subject of which may be used as a bidder's key if we accept the assumption that a contract can be awarded to a single organization only.
Simple keys are typically used directly as part of entity IRIs, which prevents creating multiple aliases for the entities in the first place.
A caution must be given if schema axioms related to functional and inverse functional properties are unreliable or if instance data is diverging from them.
In such case, it is be better to skip inferring equivalence links via the described methods in order to avoid false results.

Compound keys are more complex content signatures that can be derived from combinations of values of specific properties.
In order to be eligible as keys, these combinations must be unique.
For example, a contract and a lot number can serve as a compound key for a contract lot. 
Similarly to simple keys, such compound keys are commonly used as part of IRIs of the entities they identify.
We also employed this approach to merge bidders sharing the same name and awarded with the same contract.
Nevertheless, compound keys are perhaps used more often in a probabilistic setting, in which the degree of their match implies a probability of equivalence of the keyed entities.
Fuzzy matches of combinations of values can approximate exact matches of simple keys.
However, unlike identifying simple keys, identification of suitable compound keys and approaches for their matching usually requires expert insight into the domain in question.
A common scenario of probabilistic matching of compound keys uses combinations of simple keys that are unreliable identifiers on their own.
In the context of our dataset, even when RNs are available, they may be misleading as identifiers.
For example, there are several public contracts each year that a contracting authority awards to itself according to the supplied RNs of the authority and the awarded bidder.
Moreover, many RNs in the data are syntactically invalid and cannot be automatically coerced to the correct syntax.
So for example, an organization's name may be combined with its syntactically invalid RN to produce a compound key. 

Further extending the size of keys, we can use complete descriptions of the keyed entities.
Since such keys may be unwieldy, they can be substituted by their hashes to make them more manageable.
Using hashes as keys is standard in content-based addressing.
Hash functions map variable length content to fixed length, while preserving its uniqueness.
Unlike the previously described approaches for deriving keys, hashes do not require background knowledge to select key properties, so their production can be fully automated.
However, on the one hand, hash keys tend to be more brittle, since any change in the hashes descriptions produces a different hash, which may lead to many false negatives when comparing hashes.
On the other hand, hashes can also produce false positives if they are used for underspecified entities.
For example, postal addresses, for which we only know that they are located in the Czech Republic, are unlikely to be the same.
The risk of false positives may be reduced by requiring a minimum description to be present, similarly to a compound key.
For instance, we can hash only the postal addresses that feature at least a street address and an address locality.

We also experimented with linking entities by discovering entities that are described with a subset of another entity's description.
Given some minimum description of entities to avoid false positives, we assumed that if a set of property-object pairs of a subject is a subset of such set of another subject, the subjects are co-referent.
However, detecting subsets in SPARQL is problematic, because the quantified definition of subset requires universal quantification.
Since SPARQL is based on existential quantification instead, universally qualified predicates need to be reimplemented as double negation via nested `FILTER NOT EXISTS` clause.
Ultimately, we abandoned this linking method because of its poor performance, which makes it unusable for larger data.

In case of entities for which no key can be used directly in the construction of IRIs during data extraction via XSLT, we employed blank nodes as identifiers.
Subsequently, we converted these blank nodes to hash-based IRIs via SPARQL Update operations.
The hashes were computed by concatenating properties and objects of the identified subject and deriving an SHA1 hash from the concatenated string.
We used this approach primarily for entities that can be interpreted as structured values, such as price specifications.
The entities identified by blank nodes were processed in their inverse topological order.
If a blank node linked another blank node, the linked blank node was rewritten first.
This was done to ensure that the hashed descriptions of blank nodes do not contain blank nodes, which would cause different hashes to be computed from otherwise equivalent descriptions.
Since no two blank nodes are the same, this procedure led to a significant reduction of aliases.

### Technologies

We employed four kinds of linking technologies.
Simple keys and some compound keys were used directly to construct IRIs in XSLT.
Linking based on hashes was done using SPARQL Update operations ([Gearon, Passant, Polleres, 2013](#Gearon2013)).
Update operations were also used when creating links required a join via a key, for example when reconciling code list values.
Most linking tasks based on fuzzy matches of compound keys were done using the Silk link discovery framework ([Bryl et al., 2014](#Bryl2014)).
Silk was used when links could not be established via exact matches.
For example, we used it to compare syntactically invalid RNs via string distance metrics.
We used Silk Workbench, a graphical user interface for Silk, to develop linkage rules iteratively.
Silk Workbench displays linking results in a way the interlinked entities can be compared manually.
This enables to examine a sample of links for false positives and false negatives and adjust the linkage rules accordingly, tuning weights and thresholds to avoid undesired results.
An example linkage rule in Silk Workbench is shown in the in [@fig:silk].
[Elasticsearch](https://www.elastic.co/products/elasticsearch) was employed for matching postal addresses to reference addresses from the Czech addresses dataset.

![Example linkage rule in Silk Workbench](img/silk_workbench_linkage_rule.png){#fig:silk}

In general, linking was done iteratively, interposed with data fusion.
Fusion reduced the size of the data, in turn reducing the search space for linking.
Additionally, linking following fusion could build on previously created links.

### Tasks

We worked on three main linking tasks.
We reconciled values in our dataset with standard code lists.
Code lists provide common reference concepts with which values from source data can be reconciled.
For instance, we mapped different wordings of procedure types to the PCO's code list for procedures recognized by the Czech public procurement law.

We linked organizations in the Czech public procurement register to ARES.
Instead of deduplicating organizations directly in the register, we decided to reconcile them with ARES, which provided reference identities for organizations.
We developed Silk linkage rules using combinations of several properties as compound keys.
Syntactically invalid RNs were matched with valid RNs using the Levenshtein string distance metric to find RNs containing typos.
Normalized legal names of organizations were compared via the Jaro-Winkler distance metric with high required similarity threshold.
This metric was selected because it penalizes mismatches near the start of the name more than mismatches at the end.
It also takes the lengths of the compared names into account, so that more mismatches are tolerated in longer names.
Thanks to these features this distance metric is widely used when comparing names.
Legal names were first normalized by converting to lowercase and removing both non-alphanumeric characters and stop-words (e.g., "Czech"), which were generated from the most frequent words in the legal names.
Exact matches via postal codes or normalized URLs of organizations were used to disambiguate homonymous organization names.
URLs were discovered to be unreliable as simple keys, because they can be assigned incorrectly, so they were used only in combination.
Geo-coordinates of organizations obtained via geocoding postal addresses were used to filter matches by maximum allowed geographic distance.
The resulting equivalence links generated by Silk were serialized using the `owl:sameAs` property, loaded in a separate named graph, and resolved during data fusion.
In total, we generated 6842 links for the 14177 business entities unlinked to reference entities from ARES.
Resolution of these links reduced the share of unlinked business entities from 33.38 % to 15.9 %.

We geocoded postal addresses in ARES and the Czech public procurement register by linking them to the Czech addresses dataset.
Geocoding is the described in greater detail further in this section.

### Evaluation

Evaluation of the quality of linking typically involves clerical review of a sample of the resulting equivalence links ([Christen, 2012](#Christen2012), p. 174).
By using manual assessment, a randomly selected sample of links can be split into correct and incorrect matches.
This allows to compute quality metrics, such as precision, which is defined as the ratio of correct links (true positives) to all links (positives).
Results of the metrics computed on a sample may then be extrapolated to approximate the quality of the complete output of linking.

We manually evaluated a randomly selected sample of 200 links to ARES generated by approximate matching in Silk.
To a limited extent, the evaluation of this subset of links can approximate the evaluation of all links, which was not feasible due to the manual effort involved in assessing link validity.
Validity of each link was confirmed or rejected based on data published in the PR, including changes over time, or on web sites of the linked organizations.
9 links were determined to be false positives, while the rest was confirmed to be valid. 
This ratio of false positives produces the precision of 0.955.
We consider such precision to be reasonable, given the low quality of the linked data.
Some false positives were caused by ambiguous descriptions of business entities.
For example, there are two distinct entities named *COMIMPEX spol. s r.o.* that also share the same organization type.

There are also few automated measures that may indicate linking quality.
An example of such measure is reduction ratio, which is defined as the number of generated equivalence links compared to all possible equivalence links.
Effectiveness of linking measured in total task's runtime compared to the number of processed entities can also be determined without human input.
A more detailed review of the evaluation methods for linking is presented by Christen ([ibid.](#Christen2012), pp. 163-184).

<!--
TODO:
* Add the number of generated links.

Findings:
* A lot of missing addresses in ARES.
* Some links are between the same IRIs even though this is prohibited in the source dataset. (Unsure why this happens.) This skews the link counts.
* An example of two distinct business entities with the same name: <https://or.justice.cz/ias/ui/rejstrik-firma.vysledky?subjektId=312038&typ=UPLNY> and <https://or.justice.cz/ias/ui/rejstrik-firma.vysledky?subjektId=722550&typ=UPLNY>.

## Manual evaluation

Sample size: 200
False positives: 9
Precision: 0.955
-->

<!--
Out-takes:

Linking can exploit both semantics (i.e. schema axioms) and statistics of data ([Hogan et al., 2012](#Hogan2012), p. 78).

Appropriately enough, this process is also referred to by multiple terms, including instance matching, deduplication, or record linkage.

Defragmentation of data

Due to the transient nature of public procurement data it is necessary to integrate it in a timely manner, before the data loses relevance [Harth et al., 2013](#Harth2013).

While the title suggests the blog post is about data fusion, it is more about linking.
<http://blog.mynarz.net/2016/10/basic-fusion-of-rdf-data-in-sparql.html>
Perhaps the confusion arises from fusion and linking being merged when dealing with blank nodes.
-->
