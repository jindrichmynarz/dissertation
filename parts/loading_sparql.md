### SPARQL-based matchmakers

The SPARQL-based matchmakers requires data to be available via the SPARQL protocol [@Feigenbaum2013].
SPARQL protocol describes the communication between clients and SPARQL endpoints, which provide query interfaces to RDF stores.
Exposing data via the SPARQL protocol thus requires simply to load it in an RDF store equipped with a SPARQL endpoint.
We chose to use the open source version of Virtuoso^[<https://virtuoso.openlinksw.com>] from OpenLink as our RDF store.
Even though Virtuoso lacks in stability and adherence to the SPARQL standard, it redeems that by offering a performance unparalleled by other open source solutions.
We used Virtuoso's bulk loader^[<https://virtuoso.openlinksw.com/dataspace/doc/dav/wiki/Main/VirtBulkRDFLoader>] to ingest RDF data into the store.
