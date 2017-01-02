## Access to Registers of Economic Subjects/Entities

[Access to Registers of Economic Subjects/Entities](http://wwwinfo.mfcr.cz/ares/ares.html.en) (ARES) is an information system about business entities, which is maintained by the Ministry of Finance of the Czech Republic.
The data describes business entities along with their registrations required to pursue their business.
It contains legal business entity names, registration dates, their postal addresses, and classifications according to NACE. 
Thanks to these features ARES can serve as a reference dataset for Czech business entities.

This system is not the primary source of the data it provides.
Instead, it mediates data from several source registers and links back to these registers where possible.
The main sources of ARES are the [Public Register](https://or.justice.cz/ias/ui/rejstrik) run by the Czech Ministry of Justice, the [Trade Licensing Register](http://www.rzp.cz/eng/index.html) operated by the Czech Ministry of Industry and Trade, and the [Business Register](https://www.czso.cz/csu/res/business_register) maintained by the Czech Statistical Office.
Consequently, the data ARES provides may not be up-to-date or complete.
ARES explicitly renounces any guarantees about the data.
Its data is not to be treated as legally binding, but instead it serves only an informative purpose.

The benefit of ARES that outweighs its drawbacks is that, unlike the source registers, it provides data in a structured format.
It exposes an [HTTP API](http://wwwinfo.mfcr.cz/ares/ares_xml.html.cz) that allows to retrieve data in XML about one legal entity per request.
The access to data is rate-limited to prevent high load from automated harvesters that may cause unavailability of the service for human users.
The limits allow to issue a thousand requests per day and five thousand requests per night.
Since ARES provides access to hundreds of thousands of business entities and no option for bulk download, harvesting a copy of its data may take many weeks.
The rate-limiting and the prolonged execution thus need to be factored into account when designing an ETL pipeline that obtains the data. 

Since ARES wraps many registers, we narrowed our focus to two registers most relevant to the public procurement: the Public Register and the Trade Licensing Register.
These registers are the ones that the awarded bidders of public contracts are registered in.

XSL transformation
Registered Identification Number (RN) must be known in advance to form a valid request to ARES
we extracted the identifiers from the Czech public procurement register
a subset of the entire dataset
Most of the transformation was done by Jakub Klímek from the Charles University in Prague with a contribution of this thesis' author.
Both the [data transformation](https://github.com/opendatacz/ARES2RDF) and the [custom DPU](https://github.com/mff-uk/DPUs/tree/master/dpu-domain-specific/ares) developed for it were released as open-source.

The transformation was done using [UnifiedViews](https://unifiedviews.eu) ([Knap et al., 2017](#Knap2017)).
UnifiedViews is an ETL tool for producing RDF data.
It can be considered a predecessor of LP-ETL.

relatively consistent dataset
SPARQL Update operations for cleaning postal addresses

<!-- Total distinct business entities 204 620 in OR and RŽP (November 2016). -->

A mixture of RDF vocabularies was used to describe the ARES data with the key roles played by the GoodRelations ([Hepp](#Hepp)) and the Registered Organization Vocabulary ([Archer et al., 2013](#RegOrg2013)).
