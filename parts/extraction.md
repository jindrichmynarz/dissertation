## Extraction

Sources:

* Czech public procurement register: 2 parts - public procurement journal and electronic marketplaces
* Common Procurement Vocabulary 2008 (CPV): along with a bridge mapping CPV 2003 to CPV 2008
* Czech address data: all recognized addresses in the Czech Republic
* ARES (Czech organization register): officially registered business entities
* zIndex: index of fairness of contracting authorities

(TODO: Describe what each dataset provides. What motivates its use?)

The central dataset that we used in matchmaking is the [Czech Public procurement register](https://www.vestnikverejnychzakazek.cz).
This dataset contains Czech public contracts from the year 2006 and on.
The available description of each contract differs, although generally the contracts feature data such as their contracting authority, the contract's object, award criteria, and the awarded bidder, comprising the primary data for matchmaking demand and supply.
Roughly speaking, public contracts can be considered as expressions of demand, while awarded tenders express the supply.

Although initially this dataset was not available as structured data and interested parties had to scrape its data from HTML, it was eventually released as [open data](http://www.isvz.cz/ISVZ/Podpora/ISVZ_open_data_vz.aspx).
The data is published in exports to XML, CSV, or Microsoft Excel, partitioned by year.

This open data offering also includes exports from electronic marketplaces, where some public contracts are published, but this part was not used for matchmaking.

We used data from the Czech public procurement register to evaluate the proposed matchmaking methods.
The data is available as exports to XML, CSV, or Excel.
The data is partitioned by year into the exports.

We chose the XML version as the source.
XML allows us to leverage mature tooling for the extraction, such as XSLT processors.

The schema of the XML data follows a fixed structure.
It exhibits a degenerated use of XML.
Cardinalities of all XML elements are strictly 1-to-1.
Instead of omitting an element when its value is missing, it is kept in data with an empty text value.
Instead of repeating an element in case it has multiple values, each value is in a different element named with a numerical index (e.g., `<element_1>`, `<element_2>` etc.).
To simplify further processing we first apply an XSL transformation to remove empty elements from the data.
Doing so simplifies the implementation of the subsequent transformation, which does not have to deal with possibly empty elements.

Since we chose XML as the format of the data, we used tools designed for manipulating XML to explore the data.
Ad hoc exploratory queries were done using XQuery.
More systematic analysis of the dataset's structure was implemented using XSL transformations.

For the purposes of development of the data transformation we implemented an XSL transformation that computes cardinalities of elements in the data.
This allows us to tell the always-present elements that can be used as keys identifying entities described in the data.

- Data validation is typically mentioned as an instrinsic part of extraction. However, it is also found in the transformation step.
- We currently do "validation through use". Syntactical validation is performed when loading the data into an RDF store. However, the data breaks many assumptions of the Public Contracts Ontology to allow to automated validation using tools such as RDFUnit.

Substantial effort must be spent to extract structured data out of poorly structured Czech public procurement data.

We used a batch ETL approach, since our source data is published in batches partitioned per year.
Realtime ETL would be feasible if the source data is be provided at a finer granularity.

We used manual scheduling due to unstable behaviour of Virtuoso RDF store that requires ad hoc manual adjustments.
