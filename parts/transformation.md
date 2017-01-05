## Transformation

Cleaning, enrichment

Due to the messiness of the public procurement data:

* It is unfit for logical reasoning, e.g., applying an OWL reasoner.
* We have to assume we have only a sample instead of complete data.
* However, the distribution from which the sample is taken may be uneven. There may be systemic biases, such as particular kinds of contracting authorities not reporting public contracts properly. Therefore, the findings from the sample cannot be extrapolated to generally valid findings (without ruling out the biases).

Key challenges of the integration were:

* Dealing with high heterogeneity of the data.
* Performance of transformations of RDF data: resolved by chunked execution of SPARQL updates.

Methods used:

* Reduce data early. Reducing the volume of data early avoids needless processing in subsequent transformation steps.
* Order of transformations is determined by the dependencies of RDF resources.
  * At the moment, this is done manually. 
* Iterative fusion
* We have not used LinkedPipes-ETL for the transformation of the Czech public procurement register due to the volume of data to be processed and due to the complexity of the transformations. LinkedPipes-ETL loads data into an in-memory RDF store and materializes output of each processing step. This leads to performance problems when processing larger volumes of data. LP-ETL allows to execute SPARQL updates on data partitioned into chunks of smaller size, which can significantly speed up processing of larger datasets. However, this technique can be used only for transformations that require solely the data present in the chunk, which prevents it from being used in cases the whole dataset is required by a transformation; e.g., for joins across many resources. A example case for which this technique is applicable is sequential processing of tabular data. Data from each row can be processed separately in most cases.

Virtuoso, the RDF store we used, has an upredicatable runtime, which may be due to unresolved previous transactions.
Therefore, we did not automate the execution of the SPARQL update operations used for data transformation.
Instead, they were executed manually, allowing to fine-tune their configuration for each run depending on the perceived response from Virtuoso.

A good practice in ETL is to make checkpoints continuously during the data processing.
Checkpoints consist of persisting the intermediate data output by the individual processing steps, usually to disk.
However, due to the large numbers of transformations large disk space would be required, if checkpoints were done for every transformation.
To reduce disk consumption we persisted only the outputs of the major sub-parts of the data processing pipeline.

TODO: Describe the SPARQL 1.1 Update operations used. Structure them in categories.

* Remove data
  * Delete orphans
* Clean malformed literals
* Reconcile code lists
* Add default values

* Structure street addresses

* Move properties
  * For example, invert properties.

* Deduplicate resources

* Resolve notices

Findings:

* There can be lots with no tenders if they are part of contracts that were successfully awarded.
* Most findings are either caused by errors in source data or examples of corruption already covered by the media in the past.

[sparql-unlimited](https://github.com/jindrichmynarz/sparql-unlimited) allows to execute SPARQL Update operations split into pages.

### Cleaning

*"Errors in the published data may be caused by either negligence when filling out Journal forms or by deliberate obfuscation of sensitive information in order to reduce a contract's traceability."* ([Soudek](#Soudek2016), 2016)
