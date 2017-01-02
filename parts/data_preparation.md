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
