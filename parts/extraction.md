## Extraction

The central dataset that we used in matchmaking is the [Czech public procurement register](https://www.vestnikverejnychzakazek.cz).
This dataset contains Czech public contracts from the year 2006 to the present.
<!-- It seems that there are no unawarded contracts in the data dumps.
This makes is unsuitable for the development of the matchmaking service that alerts about open calls for tenders.
Data from electronic marketplaces also contains open calls for tenders (marked with `<VZstav>PH010003 - Zadávací řízení</VZstav>`).
-->
The available description of each contract differs, although generally the contracts feature data such as their contracting authority, the contract's object, award criteria, and the awarded bidder, comprising the primary data for matchmaking demand and supply.
Viewed from the market perspective, public contracts can be considered as expressions of demand, while awarded tenders express the supply.

Although initially this dataset was not available as structured data and interested parties had to scrape its data from HTML, it was eventually released as [open data](http://www.isvz.cz/ISVZ/Podpora/ISVZ_open_data_vz.aspx).
The data is published in exports to XML, CSV, or Microsoft Excel, partitioned by year.
This open data offering also includes exports from electronic marketplaces, where some public contracts are published, but this part was not used for matchmaking.

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

- Data validation is typically mentioned as an instrinsic part of extraction. However, it is also found in the transformation step.
<!--
We validate the syntax of registered identification numbers and Common Procurement Vocabulary codes.
-->
- We currently do "validation through use". Syntactical validation is performed when loading the data into an RDF store. However, the data breaks many assumptions of the Public Contracts Ontology to allow to automated validation using tools such as RDFUnit.

Substantial effort must be spent to extract structured data out of poorly structured Czech public procurement data.

We used a batch ETL approach, since our source data is published in batches partitioned per year.
Realtime ETL would be feasible if the source data is be provided at a finer granularity.
This is the case with the profiles of contracting authorities.

<!-- TODO: Work through the XSLT and document the important parts. -->
