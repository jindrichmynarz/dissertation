### Geocoding {#sec:geocoding}

Geocoding is the process of linking postal addresses to geographic locations.
The locations are represented as coordinates corresponding to a place on the Earth's surface.
Geocoding can be considered a case of instance matching [@Christen2012, section 9.1] that matches addresses from a dataset to reference addresses equipped with geo-coordinates.
We geocoded postal addresses of business entities in the Czech public procurement register, the Public Register (PR), and the Trade Licensing Register (TLR).
In case of the PR we geocoded only the addresses that were missing links to the Czech address dataset.
Unlinked addresses in the PR amounted for 12.42 % of all its addresses.
No addresses in the TLR were linked.
We geocoded over 180 thousand postal addresses from these registers in total.
In case of the Czech public procurement register we geocoded addresses of business entities that were not linked to the above-mentioned registers.
The overall goal of this effort was to be able to locate the business entities for the purposes of linking, analyses, and matchmaking.

The main challenge to address in geocoding was the lack of structure in the geocoded data.
<!--
// We don't do geocoding of non-organization addresses that contain only `schema:description`, hence commented out.
87.22 % postal addresses in the Czech public procurement register have only unstructured `schema:description`.
-->
As described in the [@sec:transformation], we attempted to parse the unstructured addresses to recover their structure.
Nevertheless, many addresses contained just a name of a region or a municipality.
This is why we started with simple geocoding based on matching region or municipality names.

We used LP-ETL to extract region and municipality names with their corresponding geo-coordinates from the RÚIAN SPARQL endpoint.^[<http://ruian.linked.opendata.cz:8890/sparql>]
The data provides geo-coordinates of centroids of each region and municipality.
The geo-coordinates were reprojected from EPSG:5514 coordinate reference system (CRS) to EPSG:4326 to improve their interoperability.
We loaded the data into our RDF store and ran a SPARQL Update operation to match the geo-coordinates to postal addresses via the names of regions and municipalities.

In order to geocode other postal addresses, we built and Elasticsearch-based geocoder using the Czech address data ([@sec:czech-addresses]).
We decided not to use an existing solution for several reasons.
Some geocoding services have restrictive licenses.
For instance, the results of Google's Maps Geocoding API can be used only in conjuction with displaying the obtained geo-coordinates on the Google map.^[<https://developers.google.com/maps/documentation/geocoding/policies#map>]
More liberal geocoding services often provide poor accuracy.
For example, this is the case of OpenStreetMap's Nominatim,^[<http://wiki.openstreetmap.org/wiki/Nominatim>] both for its structured and unstructured search.
Finally, we wanted to assess whether open data can help build a geocoder on par with the commercial offerings.
This is why we based the developed geocoder on the gazetteer from the Czech address data.

During the development of the geocoder we leveraged the tooling we built for data preparation.
*sparql-to-jsonld*^[<https://github.com/jindrichmynarz/sparql-to-jsonld>] was used to retrieve the Czech address data from a SPARQL endpoint, construct descriptions of the individual postal addresses, and frame them into JSON-LD documents.
We used *jsonld-to-elasticsearch*^[<https://github.com/jindrichmynarz/jsonld-to-elasticsearch>] to index the addresses in Elasticsearch.
In the index phase we used basic normalization and employed a synynom filter that expanded abbreviations commonly found in postal addresses.

The geocoder^[<https://github.com/jindrichmynarz/elasticsearch-geocoding>] was implemented as a command-line tool that loads addresses to geocode from a SPARQL endpoint using a paged SPARQL SELECT query provided by the user, and queries an Elasticsearch index with the Czech address data for each address.
We adopted Elasticsearch for the geocoder because, unlike SPARQL, it allows to perform fuzzy searches, in which results are ranked by the degree to which they fulfil the search query.
This is useful since the geocoded addresses may be incomplete, poorly structured, or contain misspellings.
In case of multiple results, we selected the first one, which ranked the best.

Since we practice separation of concerns, the geocoder expects a reasonably clean input.
It is the responsibility of data preparation to structure and normalize postal addresses.
This effort has benefits for many tasks, not geocoding only.
Instead of ad hoc cleaning during geocoding we thus prepared postal addresses as part of the ETL pre-processing, as described in [@sec:transformation]. 

Queries to Elasticsearch are generated from the provided addresses to geocode.
Since every property of the addresses is optional, the queries can be generated in several ways.
If `schema:description` is the only available property, we search for it across all fields.
A more complex query matching combinations of subqueries is generated if more properties are present.
The objects of postal code (`schema:postalCode`) and address locality (`schema:addressLocality`) are treated as co-referent, so that it suffices if one matches if both are available.

Design of the geocoding queries was guided by the level of accuracy required to support the envisioned use cases.
In our case errors in the range of tens to hundreds of meters are tolerable, so that we could trade in accuracy for increased recall.
We made adjustments to the geocoding queries to better serve this objective.
As house numbers and orientational numbers are often mixed up, we enabled the geocoding queries to match either number.
We boosted the weight of postal codes because the match on their level is more important than the match on more specific levels, such as the house number.
Moreover, unlike address localities, postal codes are usually regular, which makes them more reliable in retrieval.
Prior to introducing the boost for postal codes, in some cases distant addresses sharing the same street address and house number were mixed in their geolocation.
Further optimization of the geocoding query was guided by the results of evaluation.

#### Evaluation

We chose to evaluate the geocoder using metrics adapted from Goldberg et al. [-@Goldberg2013].
*Match rate* is defined as the share of addresses capable of being geocoded.
If $A$ is a set of addresses and $geocode()$ is a geocoding function, we can define match rate as $\frac{|\{a \in A, geocode(a) \neq \varnothing\}|}{|A|}$.
We adapted *spatial accuracy* as the share of addresses that are geocoded within a specified distance from the reference location.
We chose to evaluate spatial accuracy at 50 meters, so that geo-coordinates found within 50 meters from the reference location are considered matching.
Provided a set of addresses $A$ and ground truth $G$, we can define this metric as $\frac{|\{a \in A, distance(geocode(a), G_a)< 50\}|}{|A|}$.

While match rate can be computed without a gold standard dataset, spatial accuracy needs one.
Thanks to the links to the Czech addresses dataset from the Public Register, we had a dataset that could be used as a gold standard.
Nevertheless, the provenance and quality of these links is undocumented, with a possibility of outdated or invalid links due to mismatched versions of the linked datasets.
Therefore, we decided to verify them by comparing them to another dataset.
We experimented with several geocoding services, including Google Maps Geocoding API,^[<https://developers.google.com/maps/documentation/geocoding>] MapQuest Geocoding API,^[<https://developer.mapquest.com/products/geocoding>] and Here Geocoding API,^[<https://developer.here.com/rest-apis/documentation/geocoder>], to assess their accuracy.
Here Geocoding API turned out to deliver the best results while also providing a liberal licence allowing to use its geo-coordinates in our evaluation.
When geocoding with this API, we used structured queries with a bounding box set to the Czech Republic to rule out evident non-matches.

We loaded 10 thousand randomly selected postal addresses from the PR that linked the Czech addresses dataset.
Out of this sample, 73 % of the geo-coordinates provided by the Here Geocoding API were found no farther than 1 meter from the source geo-coordinates.
In this way, we purified two "silver" standard datasets into a gold one, consisting of 7300 verified postal addresses.
The match rate achieved by our geocoder on this dataset was 0.9893.
The geocoder scored 0.9556 for the spatial accuracy at 50 meters, with median distance of 0.425 meters and mean average distance of 272 meters.
<!-- Spatial accuracy at 1 meter = 0.9507 -->

We also evaluated our geocoder using a sample of 5 thousand addresses from the TLR, for which true location was unknown.
The geocoder achieved a match rate of 0.9788, while Here Geocoding API scored 0.6278 on this sample.
We sorted the postal addresses that were matched both by Here Geocoding API and our geocoder by the distance of the returned geo-coordinates in descending order.
We manually checked the top geo-coordinates and found that the maximum distance where our geo-coordinates were invalid was 8 kilometers.
Median distance was 0.63 meters and arithmetic mean distance was 290 meters.
We deem such results to be reasonable for our use case.

<!--
We geocoded 49 635 postal addresses in the Czech public procurement register.
-->

<!--
Match rate for a sample of 5000 postal addresses from the Trade Licensing Register:
Here Geocoding API: 0.6278 
- Our geocoder: 0.9788
- Overlap: 0.6278
-->
