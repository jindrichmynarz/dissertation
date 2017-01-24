## Extraction

The central dataset that we used in matchmaking is the [Czech public procurement register](https://www.vestnikverejnychzakazek.cz).
This dataset contains Czech public contracts from the year 2006 to the present.
<!--
There are no unawarded contracts in the data dumps.
This makes is unsuitable for the development of the matchmaking service that alerts about open calls for tenders.
Data from electronic marketplaces also contains open calls for tenders (marked with `<VZstav>PH010003 - Zadávací řízení</VZstav>`).
-->
The available description of each contract differs, although generally the contracts feature data such as their contracting authority, the contract's object, award criteria, and the awarded bidder, comprising the primary data for matchmaking demand and supply.
Viewed from the market perspective, public contracts can be considered as expressions of demand, while awarded tenders express the supply.

Although initially this dataset was not available as structured data and interested parties had to scrape its data from HTML, it was eventually released as [open data](http://www.isvz.cz/ISVZ/Podpora/ISVZ_open_data_vz.aspx).
The data is published in exports to XML, CSV, or Microsoft Excel, partitioned by year.
This open data offering also includes exports from electronic marketplaces, where some public contracts are published, but this part was not used for matchmaking.
<!-- For instance, electronic marketplaces serve purchases of commodities. --> 

We chose the XML version as the source.
XML allows us to leverage mature tooling, such as XSLT processors, for the extraction.
The choice of input data format also allowed us to explore the data using the tools designed for manipulating XML.

Ad hoc exploratory queries were done using XQuery.
We ran queries to discover possible values of a given XML element or to verify assumptions about the data.
Finding distinct values of XML elements helped us detect fixed enumerations that can be turned into code lists.
Queries verifying assumptions about the data allowed us to tell if an error in data is present in its source or if it is made during our data transformation.
For example, we assumed that the awarded bidder's registered identification number (RN) is always different from the contracting authority's RN.
This assumption turned out to be false, caused by errors in the source data.

More systematic analysis of the dataset's structure was implemented using an XSL transformation.
For the purposes of development of the data transformation we implemented a transformation that computes cardinalities of elements in the data.
This allows us to tell the always-present elements that can be used as keys identifying entities described in the data.

The tree of element cardinalities reveals the *empirical schema* of the data.
When we look at this schema, we see that it follows a fixed structure.
In fact, it exhibits a reductive use of XML.
Cardinalities of all XML elements are strictly one-to-one, at the expense of empty elements for missing values.
Instead of repeating an element in case of multiple values, each value is in a different element named with a numerical index (e.g., `<element_1>`, `<element_2>` etc.).
For instance, this pattern is used for award criteria, which are represented using the elements `<Kriterium1>`, `<Kriterium2>`, etc.
Due to the fixed cardinalities, there are many empty elements of this type where less than the maximum number of values is present.
To reduce the size of the processed data and simplify further processing we first apply an XSL transformation to remove the empty elements from the data.
Doing so simplifies the subsequent transformations, since they do not have to cater for the option of empty elements.

We developed an XSL stylesheet to extract the source XML data to RDF/XML ([Gandon, Schreiber, 2014](#Gandon2014)).
The stylesheet maps the schema of the source data onto the [target schema](#concrete-data-model).
During the extraction we validate the syntax of registered identification numbers, Common Procurement Vocabulary codes, and literals typed with `xsd:date`.
If possible, we establish links in the extracted data via concatenating unambiguous identifiers to namespace IRIs.
However, the majority of linking is offloaded to a [dedicated phase in the ETL process](#linking), since it typically requires queries over the complete dataset.
A trade-off we had to make due to our choice of an RDF store is to use plain literals in place of literals typed with `xsd:duration`, since Virtuoso does not support this data type.
Syntax of the extracted output was validated via Apache Jena's `riot`^[<https://jena.apache.org/documentation/io>] to avoid common problems in RDF/XML, such as incorrect striping ([Brickley, 2002](#Brickley2002)).

To aid visual validation of the extracted data, we developed [sparql-to-graphviz](https://github.com/jindrichmynarz/sparql-to-graphviz) that produces a class diagram representing the empirical schema of the provided data.
This tool generates a description of the dataset's class diagram in the DOT language, which can be rendered to images via [Graphviz](http://www.graphviz.org), an established visualization software for representing graph structures.
The dataset's summary in the diagram contains classes instantiated in the dataset, along with their datatype properties and object properties interconnecting the classes.
Each property is provided with the most common range, such as `xsd:date` for a datatype property or `schema:Organization` for an object property, and its minimum and maximum cardinality.
The cardinality ranges may signalize errors in data transformation, such as insufficient data fusion when the maximum cardinality surpasses an expected value.

<!--
- Data validation is typically mentioned as an instrinsic part of extraction. However, it is also found in the transformation step.
- We currently do "validation through use". Syntactical validation is performed when loading the data into an RDF store. However, the data breaks many assumptions of the Public Contracts Ontology to allow to automated validation using tools such as RDFUnit.
-->
