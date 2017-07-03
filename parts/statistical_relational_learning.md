### Statistical relational learning

Statistical relational learning (SRL) is a subfield of machine learning that is concerned with learning from relational data.
SRL learns models that *"describe probability distributions $P(\{X\})$ over the random variables in a relational domain"* [@Tresp2014, p. 1554].
Here $X$ denotes a random variable and $\{X\}$ refers to the set of such variables in a relational domain.
The learned model reflects characteristic patterns and global dependencies in relational data.
Unlike inference rules, these statistical patterns may not be universally true, but have useful predictive power nonetheless.
An example of such pattern is homophily [@McPherson2001], which describes a tendency of similar entities to be related.
A model created by SRL is used to predict probabilities of unknown relations in data.
In other words, in SRL *"the underlying idea is that reasoning can often be reduced to the task of classifying the truth value of potential statements"* [@Nickel2012, p. 271].

<!-- #### Collective learning with latent feature models -->

There are two basic kinds of SRL models: models with known features and models with latent features.
Our work focuses on the latent feature models.
Unlike known features, latent features cannot be directly observed in data.
Instead, they are assumed to be hidden causes for the observed variables.
<!-- Consequently, results from machine learning based on latent features are difficult to interpret. -->
Latent feature models are used to derive relationships between entities from interactions of their latent features [@Nickel2016, p. 17].
Since latent features correspond to global patterns in data, they can be considered products of collective learning.

<!--
Latent feature models (tensor factorization) assume that features are conditionally independent.
Latent features model global patterns. On the other hand, graph feature models are suitable for local patterns.
Creating latent features is also called predicate invention.
-->

Collective learning *"refers to the effect that an entity's relationships, attributes, or class membership can be predicted not only from the entity's attributes but also from information distributed in the network environment of the entity"* [@Tresp2014, p. 1550].
It refers to the *"automatic exploitation of attribute and relationship correlations across multiple interconnections of entities and relations"* [@Nickel2012, p. 272].
The exploited contextual information propagates through relations in data, so that the inferred dependencies can span across entity boundaries and involve entities more distant in a relational graph.
This feature of collective learning can cope with modelling artefacts in RDF, such as intermediate resources that decompose n-ary relations into binary predicates.

<!--
*"Some Relational Machine Learning approaches can exploit contextual information that might be more distant in the relational graph, a capability often referred to as collective learning."* [@Nickel2012, p. 271]
Information propagates through the relations in data.
*"Collective learning is a form of relational learning where information distant in the graph can be made useful."*
<http://www.eswc2012.org/sites/default/files/Tutorial4-Material.pdf>
dependencies can be derived across entity boundaries, such as homophily (entities tend to be associated with similar entities)
Importance for modelling artefacts, such as intermediate resources that decompose complex relations into binary predicates: *"Since attributes and complex relations are often connected by intermediary nodes such as blank nodes or abstract entities when modeled according to the RDF formalism, this collective learning ability of RESCAL is a very important feature for learning on the Semantic Web."* [@Nickel2012, p. 272]
Transitivity of relations, discovery of indirect relations
-->

Collective learning is a distinctive feature of SRL and is particularly manifest in *"domains where entities are interconnected by multiple relations"* [@Nickel2011].
Conversely, traditional machine learning expects data from a single relation, usually provided as a single propositional table.
It considers only attributes of the involved entities, which are assumed to be independent.
This is why SRL was shown to produce superior results for relational data when compared to learning methods that do not take relations into account [@Tresp2014, p. 1551].
It is thus important to be able to leverage relations in data effectively.

Nowadays the relevance of SRL grows as relational data becomes more prevalent.
In fact, many real datasets have relational nature.
For instance, vast amounts of relational data are produced by social networking sites.
Relational data appears in many contexts, including relational databases, ground predicates in first order logic, or RDF.

Using relational datasets is nevertheless challenging, since many of them are incomplete or noisy and contain uncertain or false statements.
Fortunately, SRL is robust to inconsistencies, noise, or adversarial input, since it utilizes non-deterministic dependencies in data.
Yet it is worth noting that even though SRL copes well with faulty data, systemic biases in the data will manifest in biased results produced by this method.

<!-- #### Statistical relational learning for linked open data -->

LOD is a prime example of a large-scale source of relational data afflicted with the above-mentioned ills.
The open nature of LOD has direct consequences to data inconsistency and noisiness.
These consequences make LOD challenging for reasoning and querying.
While SRL can overcome these challenges to some extent, they pose a massive hurdle for traditional reasoning using inference based on description logic.
Logical inference imposes strict constraints on its input, which are often violated in real-world data [@Nickel2016, p. 28]:

> *"Concerning requirements on the input data, it is quite unrealistic to expect that data from the open Semantic Web will ever be clean enough such that classical reasoning systems will be able to draw useful inferences from them.
This would require Semantic Web data to be engineered strongly according to shared principles, which not only contrasts with the bottom-up nature of the Web, but is also unrealistic in terms of conceptual realizability: many statements are not true or false, they rather depend on the perspective taken."* [@Hitzler2010, p. 42]

To compound matters further, reasoning with ontologies is computationally demanding, which makes it difficult to scale to the larger datasets in LOD.
While we cannot guarantee most LOD datasets to be sound enough for reasoning based on logical inference, *"it is reasonable to assume that there exist many dependencies in the LOD cloud which are rather statistical in nature than deterministic"* [@Nickel2012, p. 271].
Approximate reasoning by SRL is well-suited to exploit these dependencies and to address the challenges inherent to LOD.
This setup enables logical inference to complement SRL where appropriate.
For example, results produced by logical inference can serve as gold standard for evaluation of SRL, such as in case of @Nickel2012, who used `rdfs:subClassOf` inferences to evaluate a classification task.

<!--
Relational features can be enriched with aggregations.

Relational learning typically involves unirelational graphs.
We focus on multi-relational data in RDF.

Statistical relational models:
- Known features
- Latent features (e.g., tensor factorization, multiway neural networks)
-->

<!-- #### Link prediction -->

We conceived matchmaking via SRL as a link prediction task.
Link prediction is *"concerned with predicting the existence (or probability of correctness) of (typed) edges in the graph"* [@Nickel2016, p. 14].
An example application of link prediction is discovery of protein interactions in bioinformatics.
In our case, we predict the link between a public contract and its awarded bidder.
Typical cases of link prediction operate on multi-relational and noisy data, which makes the task suitable for SRL.

<!--
There is an inherent disproportion between existing and potential links in link prediction.
*"In the context of knowledge graphs, link prediction is also referred to as knowledge graph completion."* [@Nickel2016, p. 14]
-->

<!-- Out-takes

SRL exploits correlations in the target relation.
Knowledge graphs encode the existence of facts. [@Nickel2016, p. 25]
-->
