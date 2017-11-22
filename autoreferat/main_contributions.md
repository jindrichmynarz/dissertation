## Main contributions

<!-- přínosy disertační práce -->

We developed and documented methods to match public contracts to bidders.
These methods leverage linked open data that describes the entities involved in matchmaking as being a part of a semantically described knowledge graph, which includes descriptions of the entities, as well as their interactions, relations, or contextual data.
We implemented the proposed matchmaking methods by using existing technologies, namely SPARQL, an RDF query language, and RESCAL, a tensor factorization algorithm.
The implementations served as artefacts with which we experimented.
We examined their usefulness by evaluating the accuracy and diversity of the matches they produce.

In order to approximate the conditions in real-world public procurement we evaluated the designed matchmaking methods on a large dataset of retrospective data spanning ten years of Czech public procurement, including several related datasets.
Transforming the data into a knowledge base structured as linked open data required an extensive effort that warranted the development of novel and reusable tools for data processing.
Both the prepared dataset and the developed tools thus represent a key side contribution of our research.

The evaluation proved it challenging to obtain good results for the matchmaking task.
We discovered the underlying data to be riddled with errors and ambiguity.
Moreover, we problematized the ground truth that the matchmakers use to learn about matching public contracts to bidders.
Despite these shortcomings, the evaluation indicated that the SPARQL-based matchmakers can be used to pre-screen relevant bidders or public contracts.
Of these, the best-performing matchmaker, leveraging query expansion in the Common Procurement Vocabulary, predicted the awarded bidder in 25.9 % of cases in the top 10 results, and was able to recommend 56.3 % of the known bidders, thus achieving both acceptable accuracy and diversity.
Apart from having subpar accuracy, the results of the RESCAL-based matchmakers were afflicted with very low diversity.
Both approaches found the highest predictive power in subject classifications with controlled vocabularies.
We found the assumption that contextual data can improve matchmaking to be justified, although the improvements proceeding from incorporating additional linked data turned out to be relatively minor.
Nevertheless, most linked open data must be considered to be raw data that requires significant data preparation effort to realize its effective use.
