## Loading

Loading in OpenLink Virtuoso
We used Virtuoso's [bulk loader](https://virtuoso.openlinksw.com/dataspace/doc/dav/wiki/Main/VirtBulkRDFLoader).

Full-text search engines typically require regular data structures to make indexing efficient.
Heterogeneity of public procurement data thus mandates pre-processing to make the data more regular.
Greater regularity of RDF data can be achieved by serializing it into JSON-LD ([Sporny et al., 2014](#Sporny2014)) and coercing it to a tree layout via JSON-LD Framing ([Longley et al., 2016](#Longley2016)).

Conversion to JSON-LD
[sparql-to-jsonld](https://github.com/jindrichmynarz/sparql-to-jsonld) retrieves data from a SPARQL endpoint and converts it to JSON-LD.
It requires a SPARQL SELECT query to select the RDF resources of interest, a SPARQL CONSTRUCT query to define their descriptions, and a JSON-LD frame to coerce the obtained RDF graphs describing the resources into a JSON-LD tree layout.
The provided JSON-LD frame is used twice: first as a frame with the JSON-LD Framing API and then as a context with the JSON-LD compaction.
It outputs [Newline Delimited JSON](http://ndjson.org) (NDJSON).

Indexing in Elasticsearch
[jsonld-to-elasticsearch](https://github.com/jindrichmynarz/jsonld-to-elasticsearch)
Input in NDJSON. NDJSON is similar to the Elasticsearch bulk load format.
Elasticsearch mapping

<!--
TODO: What storage mechanism is used for RESCAL?
-->

[sparql-to-csv](https://github.com/jindrichmynarz/sparql-to-csv) is a tool for loading RDF data from a SPARQL endpoint to CSV in order to support data analyses requiring tabular data.

We performed several analyses of the data.
The primary purpose of these analyses was to provide feedback regarding the quality of the processed data.
We discovered several problems either in the source data or in its transformation.
For example, the source data features contracts in which the contracting authority and the awarded bidder are the same.
Such unexpected referential integrity problems typically surface only when data is used.
An example problem in data transformation was caused by constructing IRI of contract lots using non-unique keys.
IRI collisions led to inadvertent fusion of distinct resources.

The secondary purpose of these analyses was to test if the data can yield interesting findings.
We managed to find several insights that were previously covered by the media.
For example, if we looked for businesses that received most money via public contracts per day of their existence, Kratolia Trade emerged as a clear outlier, with income over 8 million CZK per day.
A search in the media revealed that the company dealing in biodiesel business was previously sued for tax evasion and later declared insolvency.
