## Extraction

Data from the Czech public procurement register was not initially available as structured data, so that the interested parties had to scrape the data from HTML.
The dataset was eventually released as open data.^[<http://www.isvz.cz/ISVZ/Podpora/ISVZ_open_data_vz.aspx>]
The data is published in exports to XML, CSV, and Microsoft Excel, each partitioned by year.
However, the dataset exports contain only the past contracts that were already awarded, so they cannot be used for alerting bidders about the relevant opportunities in public procurement.
Nevertheless, this historical data can be used for training and evaluation.
Although published in structured formats, the data is structured poorly, so we had to spend substantial effort improving its structure.
The portal publishing this open data also includes exports from the electronic marketplaces where some public contracts are published, such as purchases of commodities.
Nonetheless, we did not use this dataset, since it follows a different schema than the Czech public procurement register, so that using it would require us to spend further effort on data preparation.
Unfortunately, since data preparation is not a routine task, reliable estimates of the required effort are difficult to come by, so we avoid making them.

We chose the XML version as the source for data extraction.
XML allows us to leverage mature tooling, such as XSLT processors, for the extraction.
The choice of the input data format also enabled us to explore the data by using the tools designed for manipulating XML.

Ad hoc exploratory queries were done using XQuery.
We ran queries to discover possible values of a given XML element or to verify assumptions about the data.
Finding distinct values of XML elements helped us detect fixed enumerations, which can be turned into code lists.
Queries verifying our assumptions about the data allowed us to tell if an error in data is present in its source or if it is made during data transformation.
For example, we assumed that the awarded bidder's registered identification number (RN) is always different from the contracting authority's RN.
This assumption turned out to be false, caused by errors in the source data.

More systematic analysis of the dataset's structure was implemented using an XSL transformation.
For the purposes of development of the XSL stylesheet we implemented a transformation that computes the cardinalities of elements in the data.
This allowed us to tell the always-present elements that can be used as keys identifying the entities described in the data.
The tree of element cardinalities revealed the *empirical schema* of the data.
When we looked at this schema, we saw that it follows a fixed structure.
In fact, it exhibited a reductive use of XML.
Cardinalities of all XML elements were strictly one-to-one, at the expense of empty elements for missing values.
Instead of repeating an element in case of multiple values, each value was encoded in a different element named with a numerical index (e.g., `<element_1>`, `<element_2>` etc.).
For instance, this pattern is used for award criteria, which are represented using the elements `<Kriterium1>`, `<Kriterium2>`, etc.
Due to the fixed cardinalities, there were many empty elements of this type where less than the maximum number of values was present.
To reduce the size of the processed data and simplify further processing we first applied an XSL transformation to remove the empty elements from the data.
Doing so simplified the subsequent transformations, since they did not have to cater for the option of empty elements.

We developed an XSL stylesheet to extract the source XML data to RDF/XML [@Gandon2014].
The stylesheet maps the schema of the source data onto the target schema described in the [@sec:concrete-data-model].
During the extraction we validated the syntax of registered identification numbers, CPV codes, and literals typed with `xsd:date`.
If possible, we established links in the extracted data by concatenating unambiguous identifiers to namespace IRIs.
However, the majority of linking was offloaded to a dedicated phase in the ETL process, covered in the [@sec:linking], since it typically required queries over the complete dataset.
A trade-off we had to make due to our choice of an RDF store was to use plain literals in place of literals typed with `xsd:duration`, since Virtuoso^[<https://virtuoso.openlinksw.com>] does not yet support this data type.
We used LinkedPipes-ETL (LP-ETL) [@Klimek2016] to automate the extraction.
LP-ETL provided us with a way to automate downloading and transforming the source data in a data processing pipeline.
The syntax of the extracted output was validated via Apache Jena's *riot*^[<https://jena.apache.org/documentation/io>] to avoid common problems in RDF/XML, such as incorrect striping [@Brickley2002].

The selected dataset spans Czech public contracts from June 1, 2006 to January 18, 2017.
This selection amounts to 1.6 GB of raw data in XML and corresponds to 20.5 million extracted RDF triples.
The dataset contains 186 965 public contracts.

To aid the visual validation of the extracted data, we developed *sparql-to-graphviz*^[<https://github.com/jindrichmynarz/sparql-to-graphviz>] that produces a class diagram representing the empirical schema of the data it is provided with.
It generates a description of the dataset's class diagram in the DOT language, which can be rendered to images via Graphviz,^[<http://www.graphviz.org>] an established visualization software for graph structures.
The dataset's summary in the diagram, shown in [Fig. @fig:vvz], contains the classes instantiated in the dataset, along with their datatype properties and object properties interconnecting the classes.
Each property is provided with its most common range, such as `xsd:date` for a datatype property or `schema:Organization` for an object property, and its minimum and maximum cardinality.
As mentioned before, the cardinality ranges may signalize errors in the data transformation, such as insufficient data fusion when the maximum cardinality surpasses an expected value.

<!--
- Data validation is typically mentioned as an intrinsic part of extraction. However, it is also found in the transformation step.
- We currently do "validation through use". Syntactical validation is performed when loading the data into an RDF store. However, the data breaks many assumptions of the Public Contracts Ontology to allow to automated validation using tools such as RDFUnit.
-->
