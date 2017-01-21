## Linking

Linking is a process of discovering co-referent identifiers.
Co-referent identifiers share the same referent, i.e. refer to the same real-world entity.
Linked data operates under the non-unique name assumption (non-UNA), which posits that two names (identifiers) may refer to the same entity unless explicitly stated otherwise.
The aim of linking is to create explicit links between non-unique names of entities.

<!-- FIXME: However, queries usually operate under the unique name assumption. -->

Linked data employs a materialized data integration.

Addressing the accidental variety of data.
Defragmentation of data

Finding co-referent identifiers
Same things, different identifiers
In the absence of agreed upon identifiers, things are referred to by their description.
Unlike RDF, some data formats, such as CSV, do not enable linking.
Lack of agreed upon identifiers established by a reliable authority leads to proliferation of aliases for equivalent things.

Blank nodes are local identifiers.
No two blank nodes are the same.

In addition, linking can exploit both semantics (i.e. schema axioms) and statistics of data ([Hogan et al., 2012](#Hogan2012), p. 78).
It yields links between IRIs that are interpreted as co-referent, which can be materialized as additional data using the `owl:sameAs` property relating the co-referent IRIs. 

Three main linking tasks:
1. Reconciliation with code lists
2. Linking the Czech public procurement register to ARES
  - Instead of deduplicating organizations in the Czech public procurement register we decided to link them to ARES as the reference dataset.
3. Linking ARES to the Czech addresses dataset via geocoding

### Content-based addressing

Simple keys: inverse functional properties (linking subjects, `owl:InverseFunctionalProperty`), functional properties (linking objects, `owl:FunctionalProperty`, only instances of `owl:ObjectProperty`)
Compound keys: combination of properties
Hashes: complete description (with a configuration minimum) 

Construction of IRIs from shared identifiers

Even when legal entity identifiers are available, they may be misleading.
For example, there are several public contracts each year that a contracting authority awards to itself.
Many RNs in the data are syntactically invalid and cannot be automatically coerced to the correct syntax.

A caution must be given in this step if schema axioms are unreliable or instance data is diverging from the schemas.
In such case, it may be better to avoid inferring equivalence links using the described methods in order to avoid false results.

In general, reconciliations of the duplicated sets should be performed iteratively, building on results of prior reconciliations.
Each reconciled set may provide new data from which additional equivalence links may be inferred using the afore-mentioned entailment rules or by incorporating the data in the linkage rules developed for entity reconciliation.
<!-- Is it also non-monotonic? I.e. reconciling resources may produce more conflicts to reconcile. -->

Hash-based linking and fusion of blank nodes (instead of linking multiple blank nodes to an IRI, they are directly replaced by the IRI)
Requiring minimum description of the fused resources to avoid merging underspecified resources.

<!--
While the title suggests the blog post is about data fusion, it is more about linking.
<http://blog.mynarz.net/2016/10/basic-fusion-of-rdf-data-in-sparql.html>
Perhaps the confusion arises from fusion and linking being merged when dealing with blank nodes.
-->

Due to the transient nature of public procurement data it is necessary to integrate it in a timely manner, before the data loses relevance [Harth et al., 2013](#Harth2013).

The remaining case occurs when there is no identifier scheme for the duplicated entities.
To illustrate that this is a common case in public procurement, Alvarez-Rodríguez quotes the lack of consensual identifiers as one of the challenges of public procurement data ([2014](#AlvarezRodriguez2014)).
If there are no identifiers to which entities can be reconciled, reconciliation begins to resemble clustering that interconnects similar entities.

### Linking technologies

* SPARQL 1.1 Update operations
* Silk link discovery framework

SPARQL 1.1 Update operations were used when links required a join via key (typically more than one key).
Silk was used when links cannot be established via exact matches.
Fuzzy similarity
string distance metrics of business entity identifiers (IČO)

### Reconciliation with code lists

Map different wordings of award criteria to code list concepts
Code lists provide a common reference points for data integration.
Data integration attempts to reconcile values from source data with the reference concepts from code lists.

### Linking organizations from the Czech public procurement register to the Czech business register

Properties used:

* Business entity identifier (RN): syntactically invalid identifiers were used in string distance metrics to find typos
* Postal codes
* URLs
* Legal names: stop-words (e.g., "Czech") were removed
* Geo-coordinates

### Evaluation

Evaluation of the quality of entity reconciliation typically involves clerical review of a sample of the resulting equivalence links. <!-- ([Christen, 2012](#Christen2012), p. 174) -->
In this way, a randomly selected sample of equivalence links can be split into correct and incorrect matches.
Manual assessment of each link allows to compute quality metrics, such as precision, which is defined as the ratio of correct equivalences (true positives) to incorrect equivalences (false positives).
Results of the metrics computed on a sample may then be extrapolated to the complete linkset produced by the reconciliation.
There are also few automated measures that can indicate reconciliation quality.
An example of such measure is reduction ratio, which is defined as the number of generated equivalence links compared to all possible equivalence links.
Effectiveness of reconciliation measured in total task's run-time compared to the number of processed entities can also be determined without human input.
A more detailed review of the evaluation methods for entity reconciliation is presented by Christen ([2012](#Christen2012), pp. 163-184).

<!--
Out-takes:

Appropriately enough, this process is also referred to by multiple terms, including instance matching, deduplication, or record linkage.
-->
