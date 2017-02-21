## Modelling {#sec:modelling}

The central dataset that we used in matchmaking is the [Czech public procurement register](https://www.vestnikverejnychzakazek.cz).
<!--
There are no unawarded contracts in the data dumps.
This makes is unsuitable for the development of the matchmaking service that alerts about open calls for tenders.
Data from electronic marketplaces also contains open calls for tenders (marked with `<VZstav>PH010003 - Zadávací řízení</VZstav>`).
-->
The available description of each contract in this dataset differs, although generally the contracts feature data such as their contracting authority, the contract's object, award criteria, and the awarded bidder, comprising the primary data for matchmaking demand and supply.
Viewed from the market perspective, public contracts can be considered as expressions of demand, while awarded tenders express the supply.

We described this dataset with a semantic data model.
Our goal of modelling data was to establish a structure that can be leveraged by matchmaking.
However, modelling data in RDF is typically agnostic of its expected use.
Instead, it is guided by a conceptual model that opens the data to a wide array of ways to reuse the data.
Nevertheless, the way we chose to model our data reflected our priorities.

We focused on querying and data integration.
Instead of enabling to draw logical inferences by reasoning with ontological constructs, we wanted to simplify and speed-up querying.
In order to do that, for example, we avoided verbose structures to reduce the size of the queried data.
For the sake of better integration with other data, we established IRIs as persistent identifiers and reused common identifiers where possible.
Thanks to the schema-less nature of RDF, shared identifiers allowed us to merge datasets automatically.

The extracted public procurement data was described using a mixture of RDF vocabularies, out of which the Public Contracts Ontology was the most prominent.
