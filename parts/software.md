\normalsize
\appendix

# Software {#sec:software} 

The work described in this dissertation involved much software.
In order to provide a single reference point for the tools used, this appendix lists their brief descriptions.
Here we describe both the software used for data preparation as well as the software for matchmaking.
The descriptions are divided into two categories: software that we reused and software that we developed.
The descriptions in each category are sorted in alphabetic order.

## Reused software

Several tools were directly reused or integrated with other tools.
The software listed in this category comprises mostly database systems and data processing tools.
<!-- TODO: Should we add Mustache and Graphviz as the reused software? -->

### Elasticsearch

Elasticsearch (ES)^[<https://www.elastic.co/products/elasticsearch>] is an open source full-text search engine based on Apache Lucene.^[<http://lucene.apache.org>]
ES indexes JSON documents that can be searched via ES query DSL exposed through an HTTP API.
The query DSL is an expressive query language based on JSON.
The DSL allows to search for terms in full texts and match patterns in the indexed data structures.
Simple queries can be combined into complex ones using boolean operators.
Besides the basic search operations, ES features high-level query types, such as the More Like This query, which supports similarity-based retrieval.
Since ES queries are represented as structured data in JSON, they can be generated easily, lending itself to integration in other tools.

### GeoTools

GeoTools^[<http://www.geotools.org>] is an open source Java library for working with geospatial data.
Its implementation complies with standards of the Open Geospatial Consortium (OGC).
For example, it supports reprojection of coordinate data between standard coordinate reference systems.

### LinkedPipes-ETL

LinkedPipes-ETL (LP-ETL) [@Klimek2016]^[<http://etl.linkedpipes.com>] is an open source data processing tool for converting diverse data sources to RDF and performing various transformations of RDF data.
LP-ETL follows the Extract-Transform-Load (ETL) workflow.
For each ETL phase it offers components dedicated to specific data processing tasks.
For example, an extraction component can download data from a given URL, a transformation component can decompress a ZIP archive, and a load component can write data to a file.
The components can be composed into pipelines that automate potentially complex data processing workflows.
The design of LP-ETL evolved from UnifiedViews and in many respects it can be considered a successor to this project.

### OpenLink Virtuoso

OpenLink Virtuoso^[<https://virtuoso.openlinksw.com>] is an RDF store that implements SPARQL and a plethora of additional functionality for working with RDF data.
A notable characteristic of Virtuoso is its column-wise storage enabling vectored query execution [@Erling2012], which gives Virtuoso a good query performance that scales well to large RDF datasets.
Virtuoso offers an open source version that lacks some of the features available in the commercial version.

### RESCAL {#sec:rescal-software}

RESCAL [@Nickel2011] is a tensor factorization technique for relational data modelled as three-way tensors.
It has an open source implementation written in Python using the NumPy^[<http://www.numpy.org>] and SciPy^[<https://www.scipy.org>] modules for low-level array operations.
RESCAL achieves superior performance on factorization of large sparse tensors, while having a fundamentally simpler implementation than other tensor factorization techniques.

### Saxon XSLT and XQuery Processor

Saxon XSLT and XQuery Processor^[<http://www.saxonica.com/products/products.xml>] is an implementation of several W3C standards for processing XML data, including XSLT, XQuery, and XPath.
Saxon can transform XML data via XSLT stylesheets or query it via XQuery and XPath.
The limited Saxon-HE version is available as open source.

### Silk Link Discovery Framework

Silk [@Bryl2014]^[<http://silkframework.org>] is an open source link discovery framework for instance matching.
It offers an extensive arsenal of similarity measures and combination functions for aggregating similarity scores.
Silk generates links by executing declarative linkage specifications that describe how to compare resources in the source and target datasets to discover matches.
As an alternative to explicit linkage specifications, Silk supports active learning from examples of valid links [@Isele2013].
Data to be interlinked can be retrieved from SPARQL endpoints and RDF or CSV files.
Silk thus supports integration of heterogeneous data by materializing explicit links across the integrated data sources.

### Tarql

Tarql^[<http://tarql.github.io>] is an open source CLI tool for converting CSV to RDF via SPARQL CONSTRUCT queries.
It extends the query engine of Apache Jena^[<https://jena.apache.org>] such that values in each CSV row are made available as inline data to the SPARQL query provided by the user.
Queries can thus refer to tabular data via query variables based on column names from the source CSV.
Instead of resorting to custom-coded conversion scripts, such setup enables to harness the expressivity of SPARQL as a native RDF data manipulation language.

### UnifiedViews

UnifiedViews [@Knap2017]^[<https://unifiedviews.eu>] is an open source ETL framework with native support for RDF.
It allows to execute data processing tasks, monitor progress of their execution, debug failed executions, and schedule periodic tasks.
Concrete data processing workflows can be implemented as pipelines that combine pre-made data processing units.
Each unit is responsible for a data processing step, such as applying an XSL transformation or loading metadata into a data catalogue.
UnifiedViews has been in development since 2013 and it can be considered relatively stable, as it has been already deployed to address many use cases.

## Developed software

In order to cover the needs that were not sufficiently addressed by existing software we developed new software tools.
Most of these tools were implemented in Clojure, with the exception of *matchmaker-rescal* that was written in Python due to its dependency on RESCAL.
All the developed tools expose simple command-line interfaces and are released as open source under the terms of the Eclipse Public License 1.0.

### discretize-sparql {#sec:discretize-sparql}

*discretize-sparql*^[<https://github.com/jindrichmynarz/discretize-sparql>] allows to discretize numeric literals in RDF data exposed via a SPARQL Update [@Gearon2013] endpoint.
Discretization groups continuous numeric values into discrete intervals.
It is typically used for pre-processing continuous data for machine learning tools that support only categorical variables.
A discretization task in *discretize-sparql* is formulated as a SPARQL Update operation that uses pre-defined variable names endowed with specific interpretation.
The WHERE clause of the operation must contain the variable `?value` that selects the values to discretize.
The variable `?interval` will be bound to the intervals generated by the tool.
Consequently, the update operation can be formulated as if it contained a mapping from the values to discretize to intervals in which they belong.
For instance, `?interval` can be used in the INSERT clause and `?value` in the DELETE clause in order to replace the values to discretize with intervals.
The tools first rewrites the provided update operation to a SELECT query to retrieve the values to discretize and then it is rewritten to an update operation including the actual mapping from numeric literals to intervals.

### elasticsearch-geocoding

*elasticsearch-geocoding*^[<https://github.com/jindrichmynarz/elasticsearch-geocoding>] is a tool for geocoding postal addresses by ES.
It uses an ES index seeded with reference addresses to which it matches the addresses to geocode.
Such an index can be prepared by using *sparql-to-jsonld* to convert RDF data into JSON, followed by *jsonld-to-elasticsearch* to upload the JSON data into ES.
The tool loads the addresses to geocode from a SPARQL endpoint using a given SPARQL SELECT query that produces tabular data with specific column names recognized for components of addresses, such as postal codes or house numbers.
For each address an ES query is generated to find matching reference addresses.
Geo-coordinates of the best ranking result for each query are output as RDF serialized in the N-Triples syntax.

### jsonld-to-elasticsearch

*jsonld-to-elasticsearch*^[<https://github.com/jindrichmynarz/jsonld-to-elasticsearch>] indexes Newline Delimited JSON (NDJSON) in ES.
Each input line represents a JSON document that is analysed and bulk-indexed in ES using a provided mapping.
The mapping specifies a schema that instructs ES how to store and index the individual attributes in the input documents.
If the input JSON-LD contains the `@context` attribute, it is removed due to being redundant.
Each JSON-LD document must contain the `@id` attribute, which used as the document identifier in ES.
RDF data can be prepared into this expected format using *sparql-to-jsonld*.

### matchmaker-sparql {#sec:matchmaker-sparql}

*matchmaker-sparql*^[<https://github.com/jindrichmynarz/matchmaker-sparql>] is a CLI application for evaluation of matchmaking based on SPARQL.
The evaluation setup is guided by a configuration file provided to the application.
The configuration describes the data to use, connection to a SPARQL endpoint to query and update the data, parameters of the matchmaker, and the evaluation protocol for the n-fold cross-validation.

### matchmaker-rescal {#sec:matchmaker-rescal}

*matchmaker-rescal*^[<https://github.com/jindrichmynarz/matchmaker-rescal>] is a command-line application that wraps the original implementation of RESCAL in Python.
It serves as an exploratory tool for experimentation with RESCAL-based matchmaking.
The sole purpose of the tool is to evaluate link prediction for a given relation using cross-validation and the metrics defined in [Section @sec:evaluated-metrics].
Its input consists of the ground truth matrix encoding the relation to predict, additional matrices encoding other relations, and configuration with hyper-parameters for RESCAL.
The matrices required as input by this tool can be prepared by *sparql-to-tensor*.

### sparql-to-csv

*sparql-to-csv*^[<https://github.com/jindrichmynarz/sparql-to-csv>] allows to save results of SPARQL queries into CSV.
It is primarily intended to support data preparation for analyses that require tabular input.
It has two main modes of operation: paged queries and piped queries.
In both cases it generates SPARQL queries from Mustache[^mustache] templates, which enable to input parameters into the queries.
The mode of paged queries splits the provided SELECT query into queries that retrieve partial results delimited by `LIMIT` and `OFFSET`, so that demanding queries that produce many results can be executed without running into the load restrictions imposed by the queried RDF stores, such as timeouts or maximum result sizes.
The mode of piped queries allows using Unix pipes to chain the execution of several dependent SPARQL queries.
In this mode, each solution from results of the piped query is bound as variables for the template that generates the subsequent query.
Such approach facilitates the decomposition of complex queries into a chain of simpler queries that do not strain the queried RDF store.
It also enables to query a SPARQL endpoint using data from another SPARQL endpoint, in a similar manner to federated queries [@Prudhommeaux2013].
Alternatively, the query results can be piped to a template producing SPARQL Update operations, so that complex data transformations can be divided into simpler subtasks.

### sparql-to-graphviz

*sparql-to-graphviz*^[<https://github.com/jindrichmynarz/sparql-to-graphviz>] generates a class diagram representing an empirical schema of RDF data exposed via a SPARQL endpoint.
The empirical schema reflects the structure of instance data in terms of its vocabularies.
Instead of representing the structures prescribed by the vocabularies (e.g., `rdfs:domain` and `rdfs:range`), it mirrors the way vocabularies are used in instance data, such as in the actual links between resources.
In this way, it supports the exploration of unknown data that may not necessarily conform to the expectations set by its vocabularies.
In order to separate concerns, in place of producing a visualization, the tool generates a description of the schema in the DOT language.[^dot-language]
The description can be then turned into an image using Graphviz,[^graphviz] an established visualization tool that offers several algorithms for constructing graph layouts.
Instead of producing a bitmap image, a vector image in SVG can be generated, which lends itself to further manual post-production to perfect the visualization.

### sparql-to-jsonld

*sparql-to-jsonld*^[<https://github.com/jindrichmynarz/sparql-to-jsonld>] retrieves RDF data from a SPARQL endpoint and serializes it to JSON-LD documents.
It starts by fetching a list of IRIs of resources selected by a provided SPARQL SELECT query.
The query allows to filter the resources of interest, such as instances of a given class.
For each resource a user-defined SPARQL CONSTRUCT or DESCRIBE query is executed.
This query selects or constructs the features that describe the resource.
Both SPARQL queries are provided as Mustache[^mustache] templates to allow parametrization.
Each retrieved description in RDF is converted to JSON-LD and transformed via a provided JSON-LD frame that coerces the input RDF graph into a predictable JSON tree.
The output is appended to a file serialized as NDJSON.

### sparql-to-tensor {#sec:sparql-to-tensor}

*sparql-to-tensor*^[<https://github.com/jindrichmynarz/sparql-to-tensor>] exports RDF data from SPARQL endpoints to tensors.
The tensors are represented as a collection of frontal slices serialized as sparse matrices in the MatrixMarket coordinate format.^[<http://math.nist.gov/MatrixMarket/formats.html#MMformat>]
IRIs of the tensor entities are written to a `headers.txt` file.
Each IRI is written on a separate line, so that line numbers can be used as indices of the entities in the matrices.
The headers file can thus be used to translate the indices in matrices to IRIs of RDF resources.
This output complies with the format used by the Web of Needs' RESCAL matchmaker [@Friedrich2015].

Tensors are constructed from results of SPARQL SELECT queries provided to the tool. 
Each query must project several variables with pre-defined interpretation.
The `?feature` variable determines the tensor slice.
It typically corresponds to an RDF property, but it can also represent a feature constructed from the source RDF data.
The `?s` variable is an entity that is the subject of the feature, and the `?o` variable is its object.
An optional variable `?weight` can indicate the weight of the relation between the entities.
It is a decimal number from the interval $\left[0, 1\right]$, with the default value being 1.
The SELECT queries must be provided as Mustache[^mustache] templates that allow to retrieve the query results via pages delimited by `LIMIT` and `OFFSET`.
Support of multiple queries enable to separate concerns and write simpler queries for the individual features.

### sparql-unlimited

*sparql-unlimited*^[<https://github.com/jindrichmynarz/sparql-unlimited>] can execute SPARQL Update operations that affect many resources by running multiple updates that affect successive subsets of these resources.
The input SPARQL Update operation must be provided as a Mustache[^mustache] template containing a variable for the `LIMIT` to indicate the size of the subset to process.
Operations rendered from this template are executed repeatedly until the requested SPARQL endpoint responds with a message reporting that no data was modified.
In order to avoid repeating processing of the same subsets of data, either an `OFFSET` variable can be provided, which is incremented by the limit in each step, or the update operation itself can directly filter out the already processed bindings.
The latter approach is preferable since it avoids sorting a potentially large list of resources affected by the update operation.
Due to its stopping condition, the tool can be used only for update operations that eventually converge to a state when there is no more data to modify.
Since there is no standard way for SPARQL endpoints to respond that no data was modified by a received update operation, the tool relies on the way Virtuoso responds, which makes it usable only with this RDF store.

### vocab-to-graphviz

*vocab-to-graphviz*^[<https://github.com/jindrichmynarz/vocab-to-graphviz>] visualizes RDF vocabularies via Graphviz.[^graphviz]
It converts an input vocabulary from an RDF file to a description of a class diagram in the DOT language.[^dot-language]
The description can be subsequently rendered to an image via Graphviz.
The generated class diagram captures the relations between the vocabulary's terms as defined by its schema axioms, such as `rdfs:domain` or `rdfs:range`.
It thus functions in a way similar to *sparql-to-graphviz*.

[^dot-language]: <http://www.graphviz.org/doc/info/lang.html>
[^graphviz]: <http://www.graphviz.org>
