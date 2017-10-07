## Summary {#sec:data-summary}

Data preparation constituted a fundamental part of our research, since linked data offloads many concerns typically resolves on the application level to the data level.
As a result of our data preparation effort a collection of interlinked datasets was created, as depicted in [Fig. @fig:cloud].
The Czech public procurement dataset is central to this collection, including the primary data we used for matchmaking.
The remaining datasets enrich the public procurement data with contextual information that can be turned into additional features for matchmaking.
These datasets include the Common Procurement Vocabulary, three business registers mediated via the ARES system, Czech addresses dataset, NACE classification, and zIndex fairness scores.
We encountered many challenges during the preparation of these datasets.

Since it is collectively created by thousands of officials representing contracting authorities over time, the Czech public procurement dataset suffers from the same problems as user-generated data, resulting in inconsistency and heterogeneity.
Standardization can counteract these problems, but the standardization of public procurement data is imperfect at best.
Moreover, as discussed in the [@sec:public-procurement], public procurement is laden with disincentives to publishing good data.
A key data quality problem we encountered was missing data.
In particular, shared identifiers of entities involved in public procurement were non-existent, missing, or unreliable.
In other cases there were conflicting values in the data, without enough annotations to discern the correct values and resolve their conflicts.
A more detailed description of the quality of the Czech public procurement data is available in @Soudek2016a.

<!--
Problems:
- Reductive use of XML
- Violations of the allegedly validated rules
-->

In order to combat the afore-mentioned data quality problems, we invested a lot of effort into linking ([@sec:linking]) and fusion ([@sec:fusion]) of the data.
The primary task we addressed was to reduce the variety of the data by conforming values, fusing aliases, or resolving value conflicts.
Our approach to ETL adopted the separation of concerns as its basic design principle.
In this way, we reduced the complexity of the data preparation and avoided bugs that could be caused by needless coupling.
Moreover, the ETL procedures were specified in a declarative fashion, mostly by using XSLT and SPARQL Update operations, so that we could abstract from low-level implementation details that an imperative solution would need take into account.
We made defensive data transformations with few assumptions about the processed data.
The transformations usually checked if their input satisfied their assumptions and were able to cope with violations of the assumptions via fallback solutions.
We designed a way of partitioning the transformations to allow scaling to larger data.
We adopted the principles of content-based addressing for deduplication.
Finally, when we could not remedy the problems of the data, we explicitly acknowledged the limitations of data, such as in case of the systemic biases manifest in public procurement data.
