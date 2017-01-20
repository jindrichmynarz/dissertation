## Transformation

Due to the separation of concerns, extraction produces only intermediate data.
This data needs to be transformed in order to reach a better quality and conform with our target data model.
Producing RDF as the output of data extraction provides a leverage for the subsequent parts of the ETL process, since the RDF structure allows to express complex operations transforming the data.
Moreover, the homogeneous structure of RDF *"obsoletes the structural heterogeneity problem and makes integration from multiple data sources possible even if their schemas differ or are unknown"* ([Mihindukulasooriya, García-Castro, Esteban-Gutiérrez, 2013](#Mihindukulasooriya2013)).

Even though the current documentation of the Czech public procurement register states that the collected data is validated by several rules, we found errors in the data that should have been prevented by the rules.
A possible explanation for this issue is that the extracted dataset contains historical data as well, some of which might date to the past when the register did not yet employ as comprehensive validation as it does now. 
Alternatively, the *"errors in the published data may be caused by either negligence when filling out Journal forms or by deliberate obfuscation of sensitive information in order to reduce a contract's traceability"* ([Soudek, 2016](#Soudek2016)).
Due to the messiness of the data, we had to make data transformations defensive.
The transformations needed to rely on fewer assumptions about the data and had to be able to deal with violations of these assumptions. 
For example, the identifiers of the entities involved in public procurement had to be treated as inherently unrealiable.

Moreover, since not all data is disclosed, we have only a sample instead of complete data.
Given the incentives not to publish data, we cannot assume the sample is random.
There may be systemic biases, such as particular kinds of contracting authorities not reporting public contracts properly.
Therefore, the findings from the sample cannot be extrapolated to generally valid findings without considering the biases.

The key challenges of the data transformation were dealing with high heterogeneity of the data and achieving a workable performance of complex transformations affecting large subsets of data.

Due to the volume of processed data and the complexity of the applied transformations, we have not used LP-ETL to orchestrate the data transformations.
LP-ETL loads data into an in-memory RDF store and materializes output of each processing step, which leads to performance problems when working with higher volumes of data.
LP-ETL allows to execute SPARQL updates on data partitioned into chunks of smaller size, which can significantly speed up processing of larger datasets.
However, this technique can be used only for transformations that require solely the data present in the chunk, which prevents it from being used in cases the whole dataset is needed by a transformation; e.g., for joins across many resources.
Instead, an example where this technique is applicable is sequential processing of tabular data, in which data from each row can be processed separately in most cases.
Because of its relational nature, our dataset cannot be effectively split to allow executing transformations on smaller chunks of data.

Instead of partitioning data, we partitioned intermediate query bindings in SPARQL 1.1 Update operations.
Transformations using this technique follow the same structure.
They contain a sub-query that selects unprocessed bindings, either by requiring the bindings to match a pattern that is only present in those not yet processed, e.g., using `FILTER NOT EXISTS` to eliminate bindings that feature data added by the transformation, or by selecting subsequent subsets from sorted bindings.
For instance, a transformation of instances of `schema:PostalAddress` can be divided into transformations of subsets of these instances.
The latter option for filtering uprocessed bindings cannot be used when the set of sorted bindings is modified during the transformation.
For example, when a transformation deletes some bindings, the offsets of subsets in the ordered set cease to be valid.
Additionally, since sorting a large set is a computationally expensive operation, this option may require the sub-query projecting ordered bindings to be wrapped in another sub-query to be able to cache the sorted set, such as with Virtuoso's scrollable cursors.
The selected unprocessed bindings from the sub-query are split into subsets by setting a `LIMIT`.
The outer query then operates on this subset and transforms it.

We developed [sparql-unlimited](https://github.com/jindrichmynarz/sparql-unlimited) that allows to run SPARQL update operations following the described structure using Virtuoso.
This tool executes transformations rendered from [Mustache](https://mustache.github.io) templates that feature placeholders for `LIMIT`, and optionally `OFFSET`.
Limit determines the size of a subset to be transformed in one update operation.
In this way, the processed subset's size can be adjusted based on the complexity of the transformation.
Updates are executed repeatedly, the offset being incremented by the limit in each iteration, until their response reports zero modifications.
Additionally, the tool provides conveniences including configurable retries of failed updates or the ability to restart transformations from a specified offset.

While sparql-unlimited was used to automate individual transformations, each transformation was launched manually.
Virtuoso, the RDF store in which we executed the transformations, has an upredictable runtime, which may be due unresolved previous transactions or generally faulty implementation.
Therefore, we started each transformation manually to allow to fine-tune configuration for each run depending on the perceived response from Virtuoso.

A good practice in ETL is to make checkpoints continuously during data processing.
Checkpoints consist of persisting the intermediate data output by the individual processing steps, usually to disk.
However, due to the large numbers of transformations large disk space would be required, if checkpoints were done for every transformation.
To reduce disk consumption we persisted only the outputs of the major sub-parts of the data processing pipeline.

Overall, we developed tens of SPARQL 1.1 Update operations for data transformation.
One of the principles we followed was to reduce data early in order to avoid needless processing in subsequent transformation steps.
For example, we deleted empty contract lots and resources orphaned^[We consider subordinate resources without inbound links as orphaned.] in other transformations.
Several transformations were use to clean malformed literals, for example to regularize common abbreviations for organizations types or convert `\/` into `V`.
We added default values into the data.
Since the dataset is of Czech origin, we used Czech koruna (CZK) as default value in case currency was missing and addresses without an explicitly stated country were assumed to be in the Czech Republic.
Nevertheless, adding default values was a trade-off favouring coverage over accuracy.

We paid particular attention to structuring postal addresses in order to improve the results of subsequent [geocoding](#geocoding).
The prime aim of the transformation of postal addresses was to minimize their variety to increase their chance for match with a reference postal address.
Unfortunately, this effort was hindered by a Virtuoso's bug in support for non-ASCII characters,^[<https://github.com/openlink/virtuoso-opensource/issues/415>] which prevented us from using SPARQL Update operations with diacritical characters, for example when expanding Czech abbreviations in street names. 

We made several transformations to move data of select properties, which was difficult to achieve in extraction via XSLT.
Since RDF/XML lacks a way to express inverse properties, we minted provisional properties during data extraction, which were reversed during data transformation.
For example, a temporary property `:isLotOf` linking lots to contracts was reversed to `pc:lot` from PCO.
We also corrected domains of some properties, because moving them in XSLT would require joins based on extra key indices.
For instance, we moved `pc:awardDate` to `pc:Tender`.

Some data transformations required additional data.
Some data transformations leveraged background knowledge from vocabularies.
For example, we used `rdfs:subClassOf` axioms from PPROC to distinguish subclasses of `pproc:Notice`, when we merged data from notices to contracts.
We loaded the required vocabularies into separate named graphs via the SPARQL 1.1 Update `LOAD` operation.

In order to make prices comparable we converted non-CZK currencies to CZK via exchange rates data from the European Central Bank (ECB).^[<https://www.ecb.europa.eu/stats/exchange/eurofxref/html/index.en.html>]
This dataset contains daily exchange rates of several currencies to EUR. 
We used an [RDF version of the dataset](https://github.com/openbudgets/datasets/tree/master/ecb-exchange-rates) prepared for the OpenBudgets.eu project.
This derivative covers rates from November 30, 1999 to April 7, 2016, so it allowed to convert most prices in our dataset.
Prices in non-CZK currencies were converted using the exchange rates valid at their notice's publication date.
This was done as a two-step process, first converting the prices EUR followed by the conversion to CZK.

The normalized prices were winsorized^[<https://en.wikipedia.org/wiki/Winsorizing>] at 99.5^th^ percentile to remove likely incorrect extreme prices.
Due to limited expressivity of SPARQL this task needed to be split into two SPARQL queries followed by a SPARQL update operation.
The first query retrieved the count of 0.5 % prices, the second query chose the minimum price in the 0.5 % of highest prices using the count as a limit, and the final update capped 0.5 % of highest prices at this minimum.
In order to automate the this task's execution we employed [sparql-to-csv](https://github.com/jindrichmynarz/sparql-to-csv), a tool that we developed, which also allows to pipe query results into another query.

<!--
Out-takes:

In the context of procurement and financial data it was reported that *"data conversion aspects of the integration project are estimated to take up to 50 % of the project team's time"* ([Best practices in integration of procurement and financial data management, 2005](#BestPractices2005), p. 19).
We argue that a considerable share of this effort can be avoided if the integrated datasets are available in RDF. 
In that case, data translation can skip the resolution of syntactical inconsistencies and instead focus on resolving semantic mismatches between the integrated sources.

* Due to the messiness of the data it is unfit for logical reasoning, e.g., applying an OWL reasoner.

* Order of transformations is determined by the dependencies of RDF resources.
  * At the moment, this is done manually. 

Findings of data analyses:

* There can be lots with no tenders if they are part of contracts that were successfully awarded.
* Most findings are either caused by errors in source data or examples of corruption already covered by the media in the past.
-->
