# Conclusions {#sec:conclusions}

<!--
See p. 3, <http://fis.vse.cz/wp-content/uploads/2014/02/Standardy_zpracovani_doktorskych_praci.pdf>
-->

In conclusion, we summarize our work and review it in hindsight from several perspectives.
We sum up our main contributions and contrast them with the current research to indicate our progress beyond the state of the art.
We consider the practical applicability of our work and provide concrete examples of incorporating it into end-user applications.
Finally, we assess the degree of fulfilment of our stated goals and suggest directions for future research.

## Summary of the main contributions

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
We found the assumption that contextual data can improve matchmaking to be justified, although the improvements proceeding from incorporating additional linked data turned out to be relatively minor.
Nevertheless, most linked open data must be considered to be raw data that requires significant data preparation effort to realize its effective use.

## Progress beyond the state of the art

When we review our progress beyond the state of the art, introduced in [Section @sec:related-work], our key contribution is the adaptation of existing generic technologies for a concrete use case concerning matchmaking in the Czech public procurement.
Using SPARQL, we developed a novel matchmaking method inspired by case-based reasoning.
The closest to this method is the work of @AlvarezRodriguez2011c, which is however documented only in broad strokes, thus preventing more detailed comparison.
The combination of logical deduction and statistical learning we were inspired by can be traced back to the work on iSPARQL by @Kiefer2008.
The RESCAL-based matchmakers build on the generic basis laid out by the Web of Needs [@Friedrich2015], combining it with novel extensions and specialization to the public procurement domain.
As a side effect of our investigation in matchmaking methods, we advanced the available means of processing RDF data by developing a set of reusable tools that address some of the recurrent tasks involved in handling RDF data.
Ultimately, our work produced a greater value in the developed reusable artefacts for data preparation and matchmaking than as a practical use case in public procurement.

The presented work was built on open source software as well as data prepared by others.
In particular, most of the transformations of the ARES dataset were done by Jakub Klímek.
The extracted Business Register data was provided by Ondřej Kokeš.
Both these contributions are acknowledged directly in [Section @sec:ares].
zIndex fairness scores were supplied to us by Datlab s.r.o.
The software we reused in our work is listed in [Appendix @sec:software].
The design of the Public Contracts Ontology was a collaborative effort as indicated in the references in [Section @sec:pco].

## Applicability of the work

The practical applicability of our work stems from the software we developed.
We made both the matchmakers and the data processing tools available as open source software.
The software is thus open to reuse and adaptation.
In this way, we contributed back to the open source ecosystem from which we drawn tools to build on.
However, while the data processing tools were designed to be reusable, the matchmakers are tied with our evaluation protocol, so they would need to be reworked for reuse.
If adapted, matchmakers can be integrated with practical applications for managing public contracts, such as with our prototype described in @Mynarz2014b, or with [zInfo.cz](https://www.zinfo.cz), a Czech platform for public contracts maintained by Datlab s.r.o.

## Fulfilment of the stated goals

As stated in our goals, we explored the ways of matching of public contracts to bidders when their interactions are described as linked open data.
Since the space of possibilities of applying matchmaking in this setting is vast, we managed to explore only a fraction of this space.
In that light, our work can seem incomplete because the exploration has no clear boundaries.
In order to maximize the information gathered in the exploration, we used heuristics to navigate the space of possibilities and select the more salient and informative features to explore.

## Future work

Overall, we explored only a handful of ways of matching public contracts to bidders.
Our work suggests that investing in improving the data quality may produce the highest returns.
Adaptation of different approaches for the matchmaking tasks may also fundamentally alter the characteristics of matchmakers.
In particular, we expect methods that are better able to leverage unstructured data in literals to determine the similarity of public contracts, such as full-text search in semi-structured data, to have a considerable potential to improve the results of matchmaking.
Alternatively, matchmakers can build on other promising approaches for statistical relational learning from linked data, such as @Bordes2013.
Ultimately, many more ways of relevance engineering for the task of matchmaking are left open to pursue and assess their worth.
However, assessing matchmakers on the task of prediction of the awarded bidders may turn out to be a false compass.
As we discussed at length in [Section @sec:ground-truth], this evaluation setup using retrospective data on contract awards is subject to many shortcomings.
Alternative ways of evaluation may bypass the weaknesses of this setup, possibly by conducting an online evaluation with real users or by involving domain experts in qualitative evaluation.
Thorough examination of these alternatives for evaluation is imperative for further investigation of matchmaking methods.
