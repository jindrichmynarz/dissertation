## Loading

The aim of loading is to expose data in a way matchmaking methods can operate on efficiently.
Our three approaches to matchmaking warrant three approaches to loading.

### SPARQL-based matchmakers

The SPARQL-based matchmakers requires data to be available via the SPARQL protocol [@Feigenbaum2013].
SPARQL protocol describes the communication between clients and SPARQL endpoints, which provide query interfaces to RDF stores.
Exposing data via the SPARQL protocol thus requires simply to load it in an RDF store equipped with a SPARQL endpoint.
We chose to use the open source version of Virtuoso^[<https://virtuoso.openlinksw.com>] from OpenLink as our RDF store.
Even though Virtuoso lacks in stability and adherence to the SPARQL standard, it redeems that by offering a performance unparalleled by other open source solutions.
We used Virtuoso's bulk loader^[<https://virtuoso.openlinksw.com/dataspace/doc/dav/wiki/Main/VirtBulkRDFLoader>] to ingest RDF data into the store.

### Elasticsearch-based matchmakers

The matchmakers based on full-text search require a search engine.
Full-text search engines typically require regular data structures to make indexing efficient.
Heterogeneity of public procurement data thus mandates pre-processing to make the data more regular.
Greater regularity of RDF data can be achieved by serializing it into JSON-LD [@Sporny2014] and coercing it to a tree layout via JSON-LD Framing [@Longley2016].

We developed a CLI tool to perform this task.
*sparql-to-jsonld*^[<https://github.com/jindrichmynarz/sparql-to-jsonld>] retrieves data from a SPARQL endpoint and converts it to JSON-LD.
It requires a SPARQL SELECT query to select IRIs of the RDF resources of interest, a SPARQL CONSTRUCT query to retrieve their descriptions, and a JSON-LD frame to coerce the obtained RDF graphs describing the resources into a regular JSON-LD tree layout.
The SPARQL CONSTRUCT query is used to select or construct relevant features of the described resource.
The provided JSON-LD frame is used twice: first as a frame with the JSON-LD Framing API and then as a context for the JSON-LD compaction [@Longley2014] to shorten IRIs and JSON-LD values.
The tool outputs Newline Delimited JSON^[<http://ndjson.org>] (NDJSON) that features each framed description on a separate line.

The resulting NDJSON is indexed in Elasticsearch using *jsonld-to-elasticsearch*,^[<https://github.com/jindrichmynarz/jsonld-to-elasticsearch>] another CLI tool we created.
The tool partitions its input data into batches and transforms NDJSON to Elasticsearch bulk load format.^[<https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-bulk.html>]
Each batch is then indexed in Elasticsearch using a provided mapping, which defines how to analyze and store the provided data.

<!--
TODO: Describe the concrete SPARQL CONSTRUCT query used, together with its Elasticsearch mapping, once we have a working Elasticsearch matchmaker.
--> 

### RESCAL-based matchmakers

The RESCAL-based matchmakers operate on tensors.
We developed *sparql-to-tensor*, described in the [@sec:sparql-to-tensor], to export RDF data from a SPARQL endpoint to the tensor form.
The transformation was defined by SPARQL SELECT queries given to *sparql-to-tensor*.
Each query retrieved data for one or more RDF properties that constituted the relations in the output tensor.
We created and tested many tensors, each combining different properties and ways of pre-processing.

In most cases the retrieved relations corresponded to explicit RDF properties found in the source data.
However, in few select cases we constructed new relations.
This was done either to avoid intermediate resources, such as those relating unqualified CPV concepts, or relate numeric values discretized to intervals.
Since the original RESCAL algorithm does not support continuous variables, we discretized such variables via *discretize-sparql*, described in the [@sec:discretize-sparql].
We applied discretization to the actual prices of contracts, which we split into 15 equifrequent intervals having approximately the same number of members.

By default, existing relations were encoded with ones as tensor entries $\mathcal{X}_{ijk}$, while missing or unknown relations were represented with zeros.
Apart from binary numbers we used float numbers $\mathcal{X}_{ijk} \in \mathbb{R} \colon 0 \leq \mathcal{X}_{ijk} \leq 1$ to capture the degrees of importance of relations.
Float entries were used to de-emphasize less descriptive RDF properties, such as `pc:additionalObject`, or to model information loss from ageing, so that older contract awards bear less relevance than newer ones.
We reused the ageing function from [@Kuchar2016, p. 212]:

$$\mathcal{A}(t_{0}) = \mathcal{A}(t_{x}) \cdot e^{-\lambda t}; t_{0} > t_{x}, t = t_{0} - t_{x}$$

In this function *"$\mathcal{A}(t_{0})$ is the amount of information at the time $t_{0}$. $\mathcal{A}(t_{x})$ is the amount of information at the time $t_{x}$ when the information was created, $\lambda$ is ageing/retention factor and $t$ is the age of the information."*
We assume $\mathcal{A}(t_{x})$ to be equal to 1, the same value used for relations encoded without ageing.
Since our dataset covers a period of 10 years, we use $\lambda = 0.005$ that provides a distribution of values spanning approximately over this period.
We used contract awards dates as values of $t_{x}$ and the latest award date as $t_{0}$.
Award dates were unknown for the 2.3 % of contracts, so we used the median value of the known award dates instead.
The calculation was implemented in a SPARQL SELECT query.
However, since natural exponential function is not natively supported in SPARQL, we used the extension function `exp()`^[<http://docs.openlinksw.com/virtuoso/fn_exp>] built in the Virtuoso RDF store to compute it.
