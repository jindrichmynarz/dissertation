# Data preparation {#sec:data-preparation}

A fundamental part of the hereby presented work is preparation of the Czech public procurement dataset enriched with linked data.
The prepared dataset was used to evaluate the matchmakers we built as our main contribution. 
It served as a use case for applied research in the public procurement domain to explore whether the proposed matchmakers provide useful recommendations in a real-world setting.

<!-- Characteristics of ETL -->

In this chapter we will describe the data preparation using the framework of Extract-Transform-Load (ETL) [@Kimball2004].
ETL is a workflow for data preparation that is guided by the principle of the separation of concerns, as indicated by its compound name.
It conceptualizes a sequence of data processing steps endowed with a single main responsibility.
Each step is further subdivided into smaller steps endowed with a single responsibility.
The self-describing nature of RDF can further contribute to cleaner separation of concerns in the ETL workflow, so that coupling between the steps involved is reduced.

The structure of this chapter follows the steps of ETL.
We extend them to modelling, extraction, transformation, linking, fusion, and loading.
Modelling produces a target schema, onto which the data is mapped in the course of extraction and transformation.
In our setting, extraction refers to the process of converting non-RDF data to RDF.
Once data is available in RDF, its processing is described as transformation.
Linking discovers co-referent identities, while fusion resolves them to the preferred identities, along with resolving data conflicts that may arise.
Linking and fusion are interleaved and executed iteratively, each building on the results of the previous step.
Loading is concerned with making the data available in a way that the matchmaking methods can operate efficiently.
The adopted ETL workflow evolved from the workflow that was previously described by the thesis' author [-@Mynarz2014c].
The [@fig:etl] summarizes the overall workflow.

![ETL workflow](img/etl_workflow.png){#fig:etl}

We employed materialized data integration.
Unlike virtual integration, materialized integration persists the integrated data.
This allowed us to achieve the query performance required by data transformations and SPARQL-based matchmaking.
Our approach to ETL can be regarded as Extract-Load-Transform (ELT). 
We first loaded the extracted data into an RDF store to make transformation, linking, and fusion via SPARQL Update operations feasible.
Using RDF allows to load data first and integrate it later, while in the traditional context of relational databases, data integration typically precedes loading.
We used a batch ETL approach, since our source data is published in subsets partitioned per year.
Real-time ETL would be feasible if the source data was provided at a finer granularity.
This is the case of the profiles of contracting authorities, which publish XML feeds informing about current public contracts.

<!-- ## Benefits of linked data for data preparation -->

Using RDF provides several advantages to data preparation. 
Since there is no fixed schema in RDF, any RDF data can be merged and stored along with any other RDF data.
Merge as union applies to schemas as well, because they too are formalized in RDF.
Flexible data model of RDF and the expressive power of RDF vocabularies and ontologies enable to handle variation in the processed data sources.
Vocabularies and ontologies make RDF into a self-describing data format.
Producing RDF as the output of data extraction provides a leverage for the subsequent parts of the ETL process, since the RDF structure allows to express complex operations transforming the data.
Moreover, the homogeneous structure of RDF *"obsoletes the structural heterogeneity problem and makes integration from multiple data sources possible even if their schemas differ or are unknown"* [@Mihindukulasooriya2013].
Explicit, machine-readable description of RDF data enables to automate many data processing tasks.
In the context of data preparation, this feature of RDF reduces the need for manual intervention in the data preparation process, which decreases its cost and increases its consistency by avoiding human-introduced errors.
However, *"providing a coherent and integrated view of data from [linked data] resources retains classical challenges for data integration (e.g., identification and resolution of format inconsistencies in value representation, handling of inconsistent structural representations for related concepts, entity resolution)"* [@Paton2012].

Linked data provides a way to practice pay-as-you-go data integration [@Paton2012].
The pay-as-you-go principle suggests to reduce costs invested up-front into data preparation, recognize opportunities for incremental refinement of the prepared data, and revise which opportunities to invest in based on user feedback [@Paton2016].
The required investment in data preparation is inversely proportional to the willingness of users to tolerate imperfections in data.
In our case, we use feedback from evaluation of matchmaking as an indirect indication of the parts of data preparation that need to be improved.

The principal goal of ETL is to add value to data.
A key way to do so is to improve data quality.
Since data quality is typically defined as fitness for use, we focus on the fitness of the prepared data for matchmaking in particular.
Fitness for this use is affected by several data quality dimensions [@Batini2006].
The key relevant dimensions are duplication and completeness.
Lack of duplicate entities reduces the search space matchmaking has to explore.
On the contrary, duplicates break links that can be leveraged by matchmaking.
For instance, if there are unknown aliases for a bidder, then data linked from these aliases is not reachable.
Incompleteness causes features potentially valuable for matchmaking to be missing.
It makes data less descriptive and increases its sparsity, which makes matchmaking less effective.
Measuring both dimensions is difficult.
In case of duplication, we can only measure relative improvement of the deduplicated dataset compared to the input dataset.
Measuring duplication of the output dataset is unfeasible, since it may contain unknown entity aliases.
Evaluation of completeness requires either a reference dataset to compare to or reliable cardinalities to expect in the target dataset's schema.
Unfortunately, reference datasets are typically unavailable.
Cardinalities of properties either cannot be relied upon or their computation is undermined by unknown duplicates.

While the goals pursued by public disclosure and aggregation of procurement data are often undermined by insufficient data integration caused by heterogeneity of data provided by diverse contracting authorities, ETL can remedy some of the adverse effects of heterogeneity and fragmentation of procurement data.
However, at many stages of data preparation we needed to compromise data quality due to the effort required to achieve it.
We are explicit about the involved trade-offs, because it helps to understand the complexity of the data preparation endeavour.
Moreover, for some issues of the data its source does not provide enough to be able to resolve them at all.

<!-- Impact on data analyses -->

Data analyses are often based on aggregation queries, which can be significantly skewed by incomplete or duplicate data.
Incompleteness of data introduces involuntary influence of sampling bias to analyses such data.
For instance, aggregated counts of duplicated entities are unreliable, as they count distinct identifiers instead of counting distinct real-world entities, which may be associated with multiple identifiers.
Uncertain quality disqualifies the data from being used scenarios where publishing false positives is not an option.
For example, probabilistic hypotheses are of no use for serious journalism, which cannot afford to make possibly untrue claims.
Instead, such findings need to be considered as hinting where further exploration producing more reliable outcomes could be done.
Nevertheless, in the probabilistic setting of matchmaking even imperfect data can be useful.
Moreover, we assume that the errors in data can be partially smoothed by its volume. 
Finally, since we follow the pay-as-you-go approach, there is an opportunity to invest in improving data quality if required.

<!-- Prepared datasets -->

Preparation of the dataset for matchmaking involved several sources.
Selection of each of the data sources had a motive justifying the effort spent preparing the data.
We selected the Czech public procurement register as our primary dataset, to which we linked Common Procurement Vocabulary (CPV), Czech addresses data, Access to Registers of Economic Subjects/Entities (ARES), and zIndex. 
The Czech public procurement register provides historical data on Czech public contracts since 2006.
CPV organizes objects of public contracts in a hierarchical structure that allows to draw inferences about the similarity of the objects from their distance in the structure.
Czech address data offers geo-coordinates for the reference postal addresses in the Czech Republic.
By matching postal addresses to their canonical forms from this dataset, postal addresses can be geocoded.
ARES serves as a reference dataset for business entities.
We used it to reconcile the identities of business entities in the Czech public procurement data.
zIndex provides fairness score to contracting authorities in the Czech public procurement.
ETL of each of these datasets is described in more detail in the following sections.

<!-- Data and source code -->

The Czech public procurement dataset is available at <https://linked.opendata.cz/dataset/isvz>.
The source code used for data preparation is openly available in a code repository.^[<https://github.com/jindrichmynarz/vvz-to-rdf>]
This allows others to replicate and scrutinize the way we prepared data.
The data preparation tasks were implemented via declarative programming using XSLT, SPARQL Update operations, and XML specifications of linkage rules.
The high-level nature of declarative programming made the implementation concise and helped us to avoid bugs by abstracting from lower-level data manipulation.
The work on data preparation started already in 2011, which may explain diverse choices of the employed tools.
Throughout the data preparation, as more suitable and mature tools appeared, we adopted them.
A reference for the involved software is provided in [appendix @sec:software].
