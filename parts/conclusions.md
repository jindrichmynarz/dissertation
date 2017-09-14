# Conclusions

<!--
See p. 3, <http://fis.vse.cz/wp-content/uploads/2014/02/Standardy_zpracovani_doktorskych_praci.pdf>
-->

<!-- Summary of the main contributions -->

We developed and documented methods to match public contracts to bidders.
These methods leverage linked open data that describes the entities involved in matchmaking as being a part of a semantically described knowledge graph, which includes descriptions of the entities, as well as their interactions, relations, or contextual data.
We implemented the proposed matchmaking methods by using existing technologies, namely SPARQL, an RDF query language, and RESCAL, a tensor factorization algorithm.
The implementations served as artefacts that we experimented with.
We examined their usefulness by evaluating the accuracy and diversity of the matches they produce.

In order to approximate the conditions in real-world public procurement we evaluated the designed matchmaking methods on a large dataset of retrospective data spanning ten years of Czech public procurement, including several related datasets.
Preparation of this dataset constituted a fundamental part of our work.
Transforming the data into a knowledge base structured as linked open data required an extensive effort that warranted the development of novel and reusable tools for data processing.
Both the prepared dataset and the developed tools thus represent a key side contribution of our research.
We published the cleaned and enriched Czech public procurement dataset as linked open data for anyone to reuse.
Similarly, the implemented tools for working with RDF data were released as open source.

The evaluation proved it challenging to obtain good results for the matchmaking task.
Already during data preparation, we discovered the underlying data to be riddled with errors and ambiguity.
Moreover, we problematized the ground truth that the matchmakers use to learn about matching public contracts to bidders.
As we explained, the ground truth comprising data on historical awards of public contracts is subject to systemic biases that undermine its relevance for matchmaking.
Despite these shortcomings, the evaluation indicated that the SPARQL-based matchmakers can be used to pre-screen relevant bidders or public contracts.
Moreover, they can answer matchmaking queries on demand, even on constantly updating data.
Apart from having subpar accuracy, the results of the RESCAL-based matchmakers were afflicted with very low diversity.
These matchmakers turned out to be inferior in all the evaluated respects when compared with the SPARQL-based ones.
We found the assumption that contextual data from linked can improve matchmaking to be justified, although the improvements proceeding from incorporating additional linked data turned out to be relatively minor.
Nevertheless, most linked open data must be considered to be raw data that requires significant data preparation effort to realize its effective use.

<!-- Delta from the state-of-the-art -->

When we review our progress beyond the state-of-the-art, introduced in the [@sec:related-work], our key contribution is the adaption of existing generic technologies for a concrete use case concerning matchmaking in the Czech public procurement.
Using SPARQL, we developed a novel matchmaking method inspired by case-based reasoning.
As a side effect of our investigation of matchmaking methods, we advanced the available means of processing RDF data by developing a set of reusable tools that address some of the recurrent tasks involved in handling RDF data.
Ultimately, our work produced a greater value in the developed reusable artefacts for data preparation and matchmaking than as a practical use case in public procurement.

<!-- Assessment of degree of fulfillment of the stated goals -->

As stated in our goals, we explored the ways of matching of public contracts to bidders when their interactions are described as linked open data.
Since the space of possibilities of applying matchmaking in this setting is vast, we managed to explore only a fraction of this space.
We used sound heuristics to navigate this space and select the more salient and informative features to explore.
<!-- Future work -->
Overall, we explored only a few ways of matching public contracts to bidders.
Many more ways of relevance engineering for this task are left open to pursue and assess their worth.
<!-- Our work suggests that improving the data quality may produce the highest returns. -->
