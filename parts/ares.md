### Access to Registers of Economic Subjects/Entities

[Access to Registers of Economic Subjects/Entities](http://wwwinfo.mfcr.cz/ares/ares.html.en) (ARES) is an information system about business entities, which is maintained by the Ministry of Finance of the Czech Republic.
The data describes business entities along with their registrations required to pursue their business.
It contains legal business entity names, registration dates, their postal addresses, and classifications according to NACE. 
Thanks to these features ARES can serve as a reference dataset for Czech business entities.

This system is not the primary source of the data it provides.
Instead, it mediates data from several source registers and links back to these registers where possible.
The main sources of ARES are the [Public Register](https://or.justice.cz/ias/ui/rejstrik) (PR) run by the Czech Ministry of Justice, the [Trade Licensing Register](http://www.rzp.cz/eng/index.html) (TLR) operated by the Czech Ministry of Industry and Trade, and the [Business Register](https://www.czso.cz/csu/res/business_register) (BR) maintained by the Czech Statistical Office (CSO).
Consequently, the data ARES provides may not be up-to-date or complete.
In fact, ARES explicitly renounces any guarantees about the data.
Its data is not to be treated as legally binding, but instead it serves only an informative purpose.

The benefit of ARES that outweighs its drawbacks is that, unlike the source registers, it provides data in a structured format.
It exposes an [HTTP API](http://wwwinfo.mfcr.cz/ares/ares_xml.html.cz) that allows to retrieve data in XML about one legal entity per request.
The access to data is rate-limited to prevent high load from automated harvesters that may cause unavailability of the service for human users.
The limits allow to issue a thousand requests per day and five thousand requests per night.
Since ARES provides access to hundreds of thousands of business entities and no option for bulk download, harvesting a copy of its data may take many weeks.
The rate-limiting and the prolonged execution thus need to be factored into account when designing an ETL pipeline that obtains the data. 

Since ARES wraps many registers, we narrowed our focus to two registers most relevant to the public procurement: PR and TLR.
These registers are those that the awarded bidders of public contracts are registered in.
We used only a subset of BR that links bidders to concepts from the NACE classification.
A large share of business entities is present in both these registers.
It is nevertheless useful to obtain data from both registers, since they are complementary.
For instance, while the PR contains classification of organization activity, TLR naturally provides the trade licences entities have registered.

Valid requests to the ARES API must contain a Registered Identification Number (RN) of a business entity.
This design makes it difficult to obtain a complete copy of the ARES data without a complete list of valid RNs.
We collected a subset of the entire datasets by requesting the RNs we found in other datasets. 
The Czech public procurement register was one such dataset, so we gathered data about all business entities participating in Czech public procurement if their valid RN was published.
The downside of the method is that it potentially leaves out much unidentified business entities, since there are almost 2.8 million business entities in total according to the Business Register as of September 2016.^[See the periodical report of the Czech Statistical Office: <https://www.czso.cz/documents/10180/33134052/14007016q301.pdf/db871117-2431-4bba-b8d9-2288cd10862e>] 
Moreover, this number excludes now defunct entities that could have participated in the Czech public procurement before their dissolution date.
In total, as of November 2016 we harvested data about 204 620 distinct entities either in PR or TLR.
Out of these, 161 403 business entities were present in both registries.

What we made was snapshot of data valid at the harvest date.
However, business entities change in time and so does the data in ARES that describes them.
For instance, companies may move to different postal addresses.
Without the complete history of the registers, access to previous addresses is unavailable.
Since we have only a snapshot of the data, the historical data is missing.
This deficiency turned out to be detrimental to linking business entities by making it more difficult to identify correct reference entities to link.

Thanks to the uniform API that ARES provides the ETL of both registers differs only in the URL paramaters and the XSL transformations mapping XML data to RDF.
The data transformation was done using UnifiedViews.
A [custom data processing unit](https://github.com/mff-uk/DPUs/tree/master/dpu-domain-specific/ares) (DPU) was used to fetch data into UnifiedViews.
Raw source data in XML was transformed into RDF/XML using XSL stylesheets.
A mixture of RDF vocabularies was used to describe the ARES data with the key roles played by the GoodRelations ([Hepp, 2008](#Hepp2008)) and the Registered Organization Vocabulary ([Archer et al., 2013](#RegOrg2013)).
The registry data is relatively consistent, so it did not require much cleaning. 
However, we paid special care to postal addresses, since we needed them for geocoding.
SPARQL Update operations were employed to clean and structure the addresses.
The [data transformation](https://github.com/opendatacz/ARES2RDF) was released as open-source.
Most of the transformation was done by Jakub Klímek from the Charles University in Prague with a contribution of this thesis' author, in particular on the XSL stylesheets and SPARQL Update operations.

Organizations registered in BR are assigned concepts from the Statistical Classification of Economic Activities in the European Community (NACE).
NACE is a hierarchical classification describing economic activities pursued by business entities.
The subset of BR in CSV containing links to NACE was provided to us via personal communication with Ondřej Kokeš who harvested it from ARES.
We extracted 873 thousand links to NACE from this subset and converted them to RDF via [*tarql*](http://tarql.github.io), which is a command-line tool for converting tabular data to RDF via SPARQL CONSTRUCT queries.
Links to NACE were available for 89.5 % of organizations in the Czech public procurement register that were linked to ARES.

The version of NACE that these links use is CZ-NACE,^[<https://www.czso.cz/csu/czso/klasifikace_ekonomickych_cinnosti_cz_nace>] a Czech extension to NACE Rev. 2 that adds specific leaf concepts.
CZ-NACE is maintained by the CSO, which provided us with this classification in XML.
We converted the source data to RDF using a custom Python script.

<!--
Extends NACE Rev. 2 with leaf concepts
3209 organizations from the Czech public procurement register that are in ARES are missing links to NACE
All links to NACE lead to valid codes.
27359 organizations linked to NACE (30568 total ARES, 37322 total unlinked)
-->
