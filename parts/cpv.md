### Common Procurement Vocabulary

Common Procurement Vocabulary (CPV)^[<http://simap.ted.europa.eu/web/simap/cpv>] is a controlled vocabulary standardized by the EU for harmonizing the description of procured objects across the EU member states.
Within the EU, CPV has been mandatory to use for public procurement since 2006. <!-- FIXME: Add citation? -->
The most recent version of CPV is from 2008.
Each CPV concept is provided with labels in 23 languages of the EU.
The multilingual nature of CPV allows to localize public procurement data to support cross-country procurement.
CPV consists of the main and the supplementary vocabulary.
The main vocabulary provides primary concepts to describe public contracts, such as `90521400` that stands for *"Transport of radioactive waste"*.
There are 9454 concepts in the main vocabulary, structured in 6 levels of hierarchy.
The supplementary vocabulary can be used to qualify concepts from the main vocabulary.
An example supplementary concept is `MF09`, meaning *"Using hovercraft"*.
There are 903 concepts in the supplementary vocabulary, which is organized as a flat list.
However, the supplementary vocabulary is rarely used.
Only 3.25 % of objects in our Czech public procurement dataset are qualified with a supplementary concept. 
The vocabulary has a monohierarchical structure in which the individual taxonomic links typically have the        flavour of either subsumption^[E.g., *"Broccoli"* has broader concept *"Vegetables"*.] or part-whole^[E.g., *"Vegetables"* has broader concept *"Vegetables, fruits and nuts"*.] relations between CPV concepts.
The hierarchical structure allows to derive a correspondence between the concept's location in the structure and its conceptual similarity to its neighbouring concepts, which makes it possible to perform basic reasoning and query expansion.

The monohierarchical design may have caused conceptual duplication within distinct branches of the vocabulary.
For instance, there are two concepts labelled as *"Transport equipment and auxiliary products to transportation"*.
One is `34000000`, which constitutes its own branch in the vocabulary, and the other is `33952000`, which is nested in the branch *"Medical equipments, pharmaceuticals and personal care products"*.
Apart from the sharing same label, there is no explicit link between these concepts.
Moreover, CPV is published in tree (XML) or tabular (XLS) data formats, which may have encouraged the vocabulary's monohierarchical design by making it simpler to implement.
Polyhierarchy may solve the duplication by allowing concepts to have multiple parents.
However, polyhierarchies are graphs, so RDF is more suitable to represent them.

We may sidestep polyhierachy by creating associative links between similar concepts within different branches of the vocabulary’s hierarchical structure.
In this way, graph distance within CPV can better approximate the semantic distance of the compared concepts and allow similarity-based retrieval.
In order to achieve this goal, we experimented with link discovery tools to construct associative links within the vocabulary.
In the absence of better features to anchor the sense of the concepts, we compared the concepts' multilingual labels to determine their similarity.
Even with the modest size of the vocabulary this exercise turned to be computationally expensive, since it would require over a trillion of pair-wise comparisons due to the number of languages involved.
This naïve approach could be improved by using techniques, such as blocking [@Isele2011], however, given the tenuous benefits, we decided to abandon this effort.

In order to integrate CPV with the public procurement data, we converted it from XML to RDF.
The transformation^[<https://github.com/opendatacz/cpv2rdf>] was done using an XSL transformation and SPARQL CONSTRUCT queries for enriching data.
Its result is described using SKOS plus Dublin Core Terms^[<http://dublincore.org/documents/dcmi-terms>] for metadata.
While the original CPV source expresses hierachical relations using the structure of numerical notations of the    vocabulary's concepts, its RDF version makes these relations explicit using hierarchical relations from SKOS, such as `skos:broaderTransitive`.
The transformation was originally orchestrated by a shell script, which was later replaced by a UnifiedViews^[<https://unifiedviews.eu>] [@Knap2017] pipeline.
UnifiedViews is an ETL tool for producing RDF data, which can be considered a predecessor of LP-ETL.

The Czech public procurement register mandates the use of the 2008 version of CPV since September 15, 2008.
Since the data we processed goes back to 2006, we had to account for public contracts described with the previous version of CPV from 2003.
In order to harmonize the description of the older contracts we used the correspondence table mapping CPV 2003 to CPV 2008 published by the EU Publications Office.^[<http://simap.ted.europa.eu/web/simap/cpv>]
We developed a LP-ETL pipeline to convert the correspondence table from Excel to CSV and map it to RDF using SKOS mapping relations, such as `skos:closeMatch`.
The following part of the transformation turned out to be problematic.
Cells that would duplicate the values of the cells above them were left empty in the source spreadsheet.
Therefore, we had to create a "fill down blanks" functionality to duplicate cell values in following directly adjacent empty cells.
The SPARQL Update operation implementing this functionality came off as taxing, notwithstanding the modest size of the processed data.
LP-ETL had to be abandoned as it could not run it to completion.
Instead, we adopted Apache Jena's *arq*^[<https://jena.apache.org/documentation/query/cmds.html>] that was able to execute it.
Provided the RDF version of the correspondence table, concepts from CPV 2003 were resolved to their CPV 2008 counterparts using a SPARQL Update operation that exploited the mappings.

<!-- 
A fundamental problem that breaks the promise of controlled vocabularies is that of inter-indexer and intra-indexer consistency.
A shared vocabulary does not help if the way it is used is not shared too.
This is a to certain degree an unsolvable problem.
To a limited extent it can be alleviated by strict rules or shared practices.
Probably the most common inconsistency is assigning less specific concepts.

A partial solution to inter-indexer consistency (assuming intra-indexer consistency): consider CPV as local tags. I.e. they are comparable only with respect to the contracting authority that assigned them. (This approach also ignores that several civil servants are likely assigning CPV for most contracting authorities, hence the intra-indexer consistency may be broken.)
-->

<!--
RDF version of CPV is also available at <http://cpv.data.ac.uk>.
There is also the version from MOLDEAS.
-->
<!-- Discuss transitivity of hierarchical relations with `skos:broaderTransitive` vs. `skos:broader`? -->
