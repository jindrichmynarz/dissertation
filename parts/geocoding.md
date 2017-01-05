### Geocoding

Geocoding is the process of linking postal addresses to geo-coordinates.
~ instance matching
We geocoded business entities in the Czech public procurement register in order to be able to locate them.

<!--
We geocoded two datasets.
First, we geocoded business entities from ARES that were missing links to RÚIAN.
Second, we geocoded business entities in Czech public procurement register that were not linked to ARES to support their linking.
The geocoder was built using the Czech address data.
-->

Cleaning data, structuring postal addresses

[elasticsearch-geocoding](https://github.com/jindrichmynarz/elasticsearch-geocoding) is a tool for geocoding instances of `schema:PostalAddress` using Czech address data stored in Elasticsearch.

#### Evaluation

[Here](https://developer.here.com/rest-apis/documentation/geocoder) open location platform
Alternatives explored: [Google Maps Geocoding API](https://developers.google.com/maps/documentation/geocoding), [MapQuest Geocoding API](https://developer.mapquest.com/products/geocoding)
Google: good results both for structured and unstructured queries
Results of Google's API must be displayed on a Google map (see [policy](https://developers.google.com/maps/documentation/geocoding/policies)).
MapQuest: poor results 

Two "silver" standards purified into a gold standard
10 thousand postal addresses from ARES that link the Czech addresses dataset
Out of the sample, geo-coordinates of 7300 postal addresses were found no farther than 1 meter from the source geo-coordinates.

Evaluation metrics:

We used evaluation metrics defined in Goldberg et al. ([2013](#Goldberg2013)).

* Match rate
* Spatial accuracy (at 50 meters)

Evaluation results (using the gold standard from ARES):

* match rate = 0.963
* spatial accuracy at 1 meter = 0.9497
* spatial accuracy at 50 meters = 0.954
* median distance = 0 meters
* mean average distance = 86 meters

Results of application on other datasets:

* Trade Licensing Register: match rate = 0.7989
* Public Register: match rate = 0.1195
* Public procurement register: match rate = 0.0815
