# Data preparation

<!--
... A tale of gruelling detail ...

Describe data preparation of the public procurement data split into ETL phases.
Following that, describe ETL of other datasets not necessarily split by ETL phase.
-->

Data preparation served two fundamental goals.
1. Dataset to evaluate matchmaking
2. Use case for applied research
<!-- "Because applied research resides in the messy real world, strict research protocols may need to be relaxed."
<https://en.wikipedia.org/wiki/Applied_research>
Application of pristine methods of basic research to the messy world. -->

Unlike more established research areas, matchmaking lacks available datasets for evaluation.
A large part of work undertaken as a part of this effort thus needed to be invested in data preparation. 

The source code used for data preparation is openly available in a [repository](https://github.com/jindrichmynarz/vvz-to-rdf).
This allows to replicate and scrutinize the way we prepared data.

We will describe the preparation of data for matchmaking using the framework of Extract-Transform-Load (ETL).

- Do we use ETL or ELT (Extract-Load-Transform)?
In fact, we first load the data into Virtuoso to make transformation via SPARQL updates feasible.
Subsequently, the data is loaded from Virtuoso to Elasticsearch.
This can be probably termer incremental ETL.
- Using RDF allows to load data first and integrate it later, while in the traditional context of relational databases, data integration must precede loading.

We used a batch ETL approach, since our source data is published in batches partitioned per year.
Realtime ETL would be feasible if the source data is be provided at a finer granularity.
This is the case with the profiles of contracting authorities.

For the purposes of discussion in this thesis, extraction refers to the process of converting non-RDF data to RDF.
Once data is available in RDF, its processing is described as transformation.
Loading is concerned with making the data available in a way that the matchmaking methods can operate efficiently. (FIXME: Rephrase, vague as hell.)

Data preparation constitutes a fundamental part of the work presented in this thesis.

Pay-as-you-go integration
At many stages of data preparation we needed to compromise data quality due to the effort required to achieve it.
We are explicit about the involved trade-offs, because it helps understand the complexity of the data preparation endeavour, which is mostly misrepresented as a straightforward affair.

Partially integrated data is unsuitable for analysis in public media.
Probabilistic hypotheses don't fit journalism: cannot make possibly untrue claims.

We practice separation of concerns.
Data processing is split into smaller steps endowed with a single responsibility.

[zIndex's wiki](#Soudek2016a) documents many of the data quality problems with the Czech public procurement register.

Sources:

* Czech public procurement register: public procurement journal
* Common Procurement Vocabulary 2008 (CPV): along with a bridge mapping CPV 2003 to CPV 2008
* Czech address data: all recognized addresses in the Czech Republic
* ARES (Czech organization register): officially registered business entities
* zIndex: index of fairness of contracting authorities

Selection of each of the datasets had a motive justifying the effort spent preparing its data.
The Czech public procurement register is our primary dataset that provides historical data on public contracts from the past 10 years.
CPV organizes the objects of public contracts in a hierarchical structure that allows to draw inferences about the similarity of the objects from their distance in the structure.
Czech address data offers geo-coordinates for the recognized postal addresses in the Czech Republic.
By matching postal addresses to their canocanical form from this dataset, postal addresses can be geocoded.
ARES serves as a reference dataset for business entities.
It is used to reconcile identities of business entities in the Czech public procurement data that lack registration numbers.
Our case-based reasoning approach to matchmaking works under the assumption that the awarded bidders constitute cases of successful solutions to public contracts.
This assumption may not be universally valid, considering that bidders may be awarded for reasons other than providing the best offer.
zIndex gives us a counter-measure to balance this assumption by weighting each award by the fairness of its contracting authority.

Since there is no fixed schema in RDF, any RDF data can be merged and stored along with any other RDF data.
Merge as union applies to schemas as well, because they too are formalized in RDF.
Potentially overlapping schemas of the integrated sources can be merged to create a superset schema, which can then be pruned and aligned in the course of data integration.
Flexible data model of RDF and the expressive power of RDF vocabularies and ontologies enables to handle variation in the integrated data sources.
Vocabularies and ontologies make RDF into a self-describing data format.
Explicit, machine-readable description of RDF data enables to automate many data processing tasks.
In the context of data integration, this feature of RDF reduces the need for manual intervention in the integration process, which contributes to decrease of its cost and increases its consistency by avoiding human-introduced errors.
However, *"providing a coherent and integrated view of data from [linked data] resources retains classical challenges for data integration (e.g., identification and resolution of format inconsistencies in value representation, handling of inconsistent structural representations for related concepts, entity resolution)"* ([Paton et al., 2012](#Paton2012)).

Linked data can further contribute to cleaner separation of concerns in data integration workflow, so that coupling between the workflow's steps is reduced.
Each step of data integration workflow can have a single, clearly defined responsibility.
Such separation of concerns improves testability and traceability of errors in the data integration pipeline.

Data analyses are often based on aggregation queries, which can be significantly skewed by incomplete or duplicate data.
ncompleteness introduces involuntary influence of sampling bias to analyses based on incomplete data.
Aggregated counts of duplicated entities are unreliable, as they count distinct identifiers instead of counting distinct real-world entities, which may be associated with multiple identifiers.
Data integration promises to improve both completeness and deduplication by the means of entity reconciliation.

While the goals pursued by public disclosure and aggregation of procurement data are often undermined by insufficient data integration caused by heterogeneity of data provided by diverse contracting authorities, data integration can remedy some of the adverse effects of heterogeneity and fragmentation of procurement data.

Substantial effort must be spent to extract structured data out of poorly structured Czech public procurement data.
