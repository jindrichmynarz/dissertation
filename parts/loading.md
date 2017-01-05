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
<!--
SPARQL CONSTRUCT query does "feature construction".
-->

Indexing in Elasticsearch
[jsonld-to-elasticsearch](https://github.com/jindrichmynarz/jsonld-to-elasticsearch)
Input in NDJSON. NDJSON is similar to the Elasticsearch bulk load format.
Elasticsearch mapping

<!--
TODO: What storage mechanism is used for RESCAL?
-->

[sparql-to-csv](https://github.com/jindrichmynarz/sparql-to-csv) is a tool for loading RDF data from a SPARQL endpoint to CSV in order to support data analyses requiring tabular data.
