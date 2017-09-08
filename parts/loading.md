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

### RESCAL-based matchmakers {#sec:rescal-loading}

The RESCAL-based matchmakers operate on tensors.
Tensors are multidimensional arrays typically used to represent multi-relational data.
The number of dimensions of a tensor, also known as ways or modes [@Kolda2009], is referred to as its order.
Tensors usually denote the higher-order arrays: first-order tensors are vectors and second-order tensors are matrices.

<!--
Further formalization of tensors (add if needed for the further explanations):

- Don't use "rank", since it is also used for the number of rows of the latent factor matrix $A$ (and the dimensions of the latent factor tensor $\mathcal{R}$).

$\mathcal{X}_{k}$ is a $k$-th frontal slice of tensor $\mathcal{X}$

Third-order tensor $\mathcal{X} \in \mathbb{R}^{I \times J \times K}$.

Adjacency tensors
Slices: two-dimensional subarrays/sections of tensors (i.e. matrices)
- Frontal slices of tensors correspond to adjacency matrices of given predicates.
  - $\mathcal{X}_{::k}$
  - There are horizontal, lateral, and frontal slices.
Fibers: one-dimensional subarrays of tensors (i.e. vectors)
- Fibers fix all tensor indices but one.
-->

<!-- Tensor representation of RDF -->

Higher-order tensors provide a simple way to model multi-relational data, such as RDF.
Since RDF predicates are binary relations, RDF data can be represented as a third-order tensor $\mathcal{X}$, in which two modes represent RDF resources in a domain and the third mode represents relation types; i.e. RDF predicates [@Tresp2014].
The two modes are formed by concatenating the subjects and objects in RDF data.
The mode-3 slices of such tensors, also referred to as frontal slices, are square adjacency matrices that encode the existence of relation $R_{k}$ between RDF resources $E_{i}$ and $E_{j}$, as depicted in the [@fig:third-order-tensor]. <!-- _b -->
Consequently, RDF can be modelled as $n \times n \times m$ tensor $\mathcal{X}$, where $n$ is the number of entities and $m$ is the number of relations.
If $i$^th^ entity is related by the $k$^th^ predicate to $j$^th^ entity, then the tensor entry $\mathcal{X}_{ijk} = 1$.
Otherwise, if such relation is missing or unknown, the tensor entry is zero.

![Frontal slices of a third-order tensor, adopted from @Nickel2011](img/third_order_tensor.png){#fig:third-order-tensor width=50%}

There are a couple of things to note about tensors representing RDF data.
Entities in these tensors are not assumed to be homogeneous.
Instead, they may instantiate different classes.
Moreover, no distinction between ontological and instance relations is maintained, so that both classes and instances are modelled as entities.
In this way, *"ontologies are handled like soft constraints, meaning that the additional information present in an ontology guides the factorization to semantically more reasonable results"* [@Nickel2012, p. 273].
Tensors representing RDF are usually very sparse due to high dimensionality and incompleteness, calling in for algorithms that leverage the sparsity for efficient execution, in particular for large data.
Scalable processing of large RDF datasets in the tensor form is thus a challenge for optimization techniques.
Interestingly, unlike RDF, tensors can represent n-ary relations without decomposing them into binary relations.
What would in RDF require reification or named graphs can be captured by increasing the tensor order.
This presents an opportunity for more expressive modelling outside of the boundaries of RDF.

We developed *sparql-to-tensor*, described in the [@sec:sparql-to-tensor], to export RDF data from a SPARQL endpoint to the tensor form.
The transformation is defined by SPARQL SELECT queries given to *sparql-to-tensor*.
Each query retrieves data for one or more RDF properties that constitute the relations in the output tensor.
We created and tested many tensors, each combining different properties and ways of pre-processing.

In most cases the retrieved relations corresponded to explicit RDF properties found in the source data.
However, in few select cases we constructed new relations.
This was done either to avoid intermediate resources, such as tenders relating awarded bidders or proxy concepts relating unqualified CPV concepts, or relate numeric values discretized to intervals.
Since the original RESCAL algorithm does not support continuous variables, we discretized such variables via *discretize-sparql*, described in the [@sec:discretize-sparql].
We applied discretization to the actual prices of contracts, which we split into 15 equifrequent intervals having approximately the same number of members.

Apart from binary numbers as tensor entries we used float numbers $\mathcal{X}_{ijk} \in \mathbb{R} \colon 0 \leq \mathcal{X}_{ijk} \leq 1$ to capture the degrees of importance of relations.
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

<!-- Feature selection

`:awardedBidder` (i.e. pc:awardedTender/pc:bidder, weighted by pc:awardDate)
`pc:mainObject`
`pc:additionalObject`
`skos:closeMatch`
`skos:related`
`skos:broaderTransitive`
`rov:orgActivity`
-->

Instead of exporting all RDF data to the tensor format, we selected few features from it that we deemed to be the most informative.
There are 76 different relations in the Czech public procurement dataset.
Even more relations are available if we add the linked data.
We experimented with selecting individual relations as well as their combinations to find which ones produce the best results.
We guided this search by an assumption that contributions of the individual relations do not cancel themselves.
