## Fusion

* Iterative fusion, interleaved with linking

Data fusion can be defined as *"the process of integrating multiple data items representing the same real-world object into a single, consistent, and clean representation"* ([Bizer, Heath and Berners-Lee, 2009](#Bizer2009)). 
In the course of data fusion *"duplicate representations are combined and fused into a single representation while inconsistencies in the data are resolved"* ([Bleiholder and Naumann, 2008](#Bleiholder2008), p. 1:3).
However, data fusion is not limited to mechanical application of equivalence links produced by entity reconciliation.
Its particular focus *"lies in resolving value-level contradictions among the different representations of a single real-world object"* ([Naumann et al., 2006](#Naumann2006), p. 22).

The data fusion step in the data integration workflows takes the equivalence links produced by entity reconciliation as its input.
Fusion starts with grouping the input links into clusters of equivalent IRIs.
For each cluster, fusion algorithm picks a preferred IRI based on pre-configured policy, typically depending on the computed quality of the IRI's entity description.
In each cluster, data fusion resolves conflicts in literal values and rewrites the non-preferred IRIs to the chosen preferred IRI.
Resolution of conflicts in literals is driven by an appropriate fusion policy, such as the selection of the most recent value or inclusion of all values.
This is where the previously mentioned cardinality constraints may be used to inform what fusion policy to adopt.
Rewriting of non-preferred IRIs is likely to disconnect resources that depend on them.
The final step of data fusion should thus delete these "orphaned" resources, which are no longer needed.

Fusion may be executed iteratively with entity reconciliation in case of large datasets, which are computationally demanding to process, in order to shrink the size of the processed data and thus decrease the number of comparisons that reconciliation needs to perform.
Moreover, in case of large datasets, the steps of entity reconciliation and data fusion may be limited to subsets of data in order to improve the performance of the whole workflow.

Separation of concerns: fusion expects equivalence links to be provided.
<!--
Are there any practical concerns warranting combination of linking with fusion?
For example, what are the downsides of modelling public notices pertaining to a contract as contracts related via `owl:sameAs`?
-->
<!--
Some form of equivalence links, not only `owl:sameAs`. May be compound or indirect link.
-->

Since many datasets overlap, not linking between them creates duplication.

Data from the Czech public procurement register shares many characteristics of user-generated content.
Uncoordinated civil servants are akin to the distributed user base of web applications. 
Lack of rules and constraints enforced on user input
Exchanging data in self-contained documents
<!--
However, unlike platforms leveraging user-generated content such as Wikidata or OpenStreetMap, there the register has no model for data curation in place.
// => Not really true.
-->
*"the default mode of authoring is copy and edit"* ([Guha, 2013](#Guha2013))

Fusion of user-generated content
Fusion policy for correction notices
Topological (dependency) sorting to establish order or rewriting blank nodes to IRIs

- Inverse sort may be used to delete orphaned resources

Dropping conflicting boolean properties: if there are both true and false assertions, then we know nothing.

- Null values do not exist in RDF, hence do not need to be removed. (Some data is better than no data.)

TODO: Add dataset size reduction before and after cleaning
TODO: Add percentage of conflict-free contracts before and after conflict resolution.

* Truth Discovery to Resolve Object Conflicts in Linked Data. <https://arxiv.org/abs/1509.00104>

We adopted a conventional directionality of the `owl:sameAs` links from a non-preferred IRI to the preferred IRI.
This convention allowed us to use a uniform SPARQL Update operation to resolve non-preferred IRIs to their preferred counterparts.
For example, if there is a triple `:a owl:sameAs :b`, `:a` as the non-preferred IRI will be rewritten to `:b`.
Note that this convention can be applied only if you can distinguish between non-preferred and preferred IRIs, such as by preferring IRIs from a reference dataset.

Fusing subset descriptions
Universal quantification implemented in SPARQL via double negation
Poor performance makes this approach unusable for larger data.

We implemented data fusion using SPARQL 1.1 Update operations.

* Resolution of notices

Resolution of conflicts in functional properties
([Mynarz, 2014](#Mynarz2014c))

Goals of data fusion:

* Remove invalid data
* Provide a consistent, up-to-date view of the data
* Simplify querying

Fusion is a counter-measure to the open world assumption (OWA).
Linked data combines the assumptions about entity names with the OWA, which can be explained as the following:
*"The truth of a statement is independent of whether it is known.
In other words, not knowing whether a statement is explicitly true does not imply that the statement is false."* ([Hebeler et al., 2009](#Hebeler2009), p. 103)
Adopting the OWA implies a recognition that data may be incomplete.
While the goal of public procurement registers is to achieve complete coverage of public contracts falling under the regime of mandatory disclosure, it is still possible that some required data escapes the registers. 
Missing data then impacts the quality of data analyses, since incomplete data can only provide approximate answers, and it undermines the reliability of absolute figures measured using the data. 
Being aware of nUNA and OWA helps to realize that integration of linked data, and any data in general, cannot accomplish perfect data quality.

#### Evaluation

If we decide to evaluate the quality of data fusion, there are several measures available. 
One of the broadest measures for assessing data fusion is data reduction ratio, which represents the decrease in the number of fused entities.
This figure corresponds to the measure of extensional conciseness defined by Bleiholder and Naumann ([2008](#Bleiholder2008), pp. 1:5-1:6) as the *"percentage of real-world objects covered by that dataset"*.
Many evaluation measures used for data fusion reflect the impact of this task on data quality. 
An example of those is completeness, which represents the ratio of instances having value for a specified property before and after fusion, and is sometimes rephrased as coverage and density ([Akoka, 2007](#Akoka2007)).
