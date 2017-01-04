## Common Procurement Vocabulary

Common Procurement Vocabulary (CPV)^[<http://simap.ted.europa.eu/web/simap/cpv>] is a controlled vocabulary standardized by the EU for harmonizing the description of procured objects across the EU member states.
Each CPV concept is provided with labels in 23 languages of the EU.
<!-- The main and the supplementary vocabulary.
9454 concepts in the main vocabulary, 6 levels of hierarchical depth
903 concepts in the supplementary vocabulary, flat structure
The supplementary vocabulary provides qualifiers that can be used in combination with the concepts from the main vocabulary.
For example, the concept `MF09` means "Using hovercraft".
-->
The vocabulary has a mono-hierarchical structure in which the individual taxonomic links typically have the        flavour of either subsumption^[E.g., "Broccoli" has broader concept "Vegetables".] or part-whole^[E.g., "Vegetables" has broader concept "Vegetables, fruits and nuts".] relations between CPV concepts.
While the original CPV source expresses hierachical relations using the structure of numerical notations of the    vocabulary's concepts, we transformed the CPV to RDF^[<https://github.com/opendatacz/cpv2rdf>] that makes these relations explicit using the SKOS vocabulary.
The hierarchical structure allows to perform query expansion.
Using the terminology of case-based reasoning, CPV provides a "bridge attribute" that allows to derive the       similarity of contracts from the shared concepts in their descriptions.

<!--
Monohierarchical design may have cause conceptual duplication within distinct branches of the vocabulary.
Polyhierarchy may solve the duplication, by allowing concepts to have multiple parents.
Tree data formats, such as XML, may encourage monohierarchical design by making it simpler to implement.
On the other hand, polyhierarchies are graphs, so RDF is more suitable to represent them.
-->
We can derive a correspondence between the hierarchical structure and conceptual similarity?

The most recent version of CPV from the year 2008
[source data](http://simap.ted.europa.eu/web/simap/cpv)
XSL transformation
SPARQL CONSTRUCT queries for enriching data
Modelled with Simple Knowledge Organization System (SKOS) ([Isaac, Summers, 2009](#Isaac2009)), plus Dublin Core Terms for metadata
<!-- Discuss transitivity of hierarchical relations with `skos:broaderTransitive` vs. `skos:broader`? -->
The transformation was originally orchestrated by a Shell script, which was replaced later by a UnifiedViews pipeline.
[cpv2rdf](https://github.com/opendatacz/cpv2rdf)

Interlinking Common Procurement Vocabulary with associative links may contribute to shortening of graph distance between similar concepts within different branches of the vocabulary’s hierarchical structure.
In this way, graph distance within CPV may better approximate the semantic distance of the compared concepts, so that it can contribute to matchmaking in a more meaningful manner.

A fundamental problem that breaks the promise of controlled vocabularies is that of inter-indexer and intra-indexer consistency.
A shared vocabulary does not help if the way it is used is not shared too.
This is a to certain degree an unsolvable problem .
To a limited extent it can be alleviated by strict rules or shared practices.
<!-- Probably the most common inconsistency is assigning less specific concepts. -->
