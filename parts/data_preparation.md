# Data preparation

<!--
... A tale of gruelling detail ...

Describe data preparation of the public procurement data split into ETL phases.
Following that, describe ETL of other datasets not necessarily split by ETL phase. 
-->

- [repository](https://github.com/jindrichmynarz/vvz-to-rdf)

We will describe the preparation of data for matchmaking using the framework of Extract-Transform-Load (ETL).

- Do we use ETL or ELT (Extract-Load-Transform)? In fact, we first load the data into Virtuoso to make transformation via SPARQL updates feasible. Subsequently, the data is loaded from Virtuoso to Elasticsearch. This can be probably termer incremental ETL.

For the purposes of discussion in this thesis, extraction refers to the process of converting non-RDF data to RDF.
Once data is available in RDF, its processing is described as transformation.
Loading is concerned with making the data available in a way that the matchmaking methods can operate efficiently. (FIXME: Rephrase, vague as hell.)

Data preparation constitutes a fundamental part of the work presented in this thesis.

Pay-as-you-go integration
Partially integrated data is unsuitable for analysis in public media. Probabilistic hypotheses don't fit journalism: cannot make possibly untrue claims.

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
Czech address data offers geo-coordinates for the recognized postal addresses in the Czech Republic. By matching postal addresses to their canocanical form from this dataset, postal addresses can be geocoded.
ARES serves as a reference dataset for business entities. It is used to reconcile identities of business entities in the Czech public procurement data that lack registration numbers.
Our case-based reasoning approach to matchmaking works under the assumption that the awarded bidders constitute cases of successful solutions to public contracts. This assumption may not be universally valid, considering that bidders may be awarded for reasons other than providing the best offer. zIndex gives us a counter-measure to balance this assumption by weighting each award by the fairness of its contracting authority.
