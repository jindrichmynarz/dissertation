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
