### Linking

Linked data employs a materialized data integration.

Linking the Czech public procurement register to ARES
Linking ARES to the czech addresses (geocoding)

Linking mechanisms:

* Construction of IRIs from shared identifiers
* SPARQL 1.1 Update operations
* Silk link discovery framework

SPARQL updates were used when links required a join via key (typically more than one key).
Silk was used when links cannot be established via exact matches.
Fuzzy similarity
string distance metrics of business entity identifiers (IČO)

When legal entity identifiers are available, they may be misleading.
For example, there are several public contracts each year that a contracting authority awards to itself.

Linking organizations from the Czech public procurement register to the Czech business register.

Properties used:

* Business entity identifier (IČO): syntactically invalid identifiers were used in string distance metrics to find typos
* Postal codes
* URLs
* Legal names: stop-words (e.g., "Czech") were removed
* Geo-coordinates
