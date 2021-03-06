### Case-based reasoning {#sec:cbr}

<!-- Definitions -->

Case-base reasoning (CBR) is a problem solving methodology that learns from experiences of previously solved problems, which are called cases [@Richter2013, p. 17].
A case consists of a problem specification and a problem solution.
Experiences described in cases can be either positive or negative.
Positive experiences propose solutions to be reused, whereas the negative ones indicate solutions to avoid.
For example, experiences may concern diagnosing a patient and evaluating the outcome of the diagnosis, which may be either successful or unsuccessful.
Cases are stored and organized in a case base, such as a database.
Case base serves as a memory that retains the experiences to learn from.

The workings of CBR systems can be described in terms of the CBR cycle [@Kolodner1992].
The cycle consists of four principal steps a CBR system may iterate through:

1. Retrieve
2. Reuse
3. Revise
4. Retain

In the *Retrieve* step a CBR system gets cases similar to the query problem.
Case bases are thus usually built for efficient similarity-based retrieval. 
Since descriptions of cases are often complex, computing their similarity may involve determining and weighting similarities of their individual features.
For each use case and each feature a different similarity measure may be adopted, which allows to use pairwise similarity metrics tailored for particular kinds of data.
This also enables assigning each feature a different weight, so that more relevant features may be emphasized.
The employed metrics may be either symmetric or asymmetric.
For example, we can use an asymmetric metric to favour lower prices over higher prices, even though their distance to the price in the query is the same.
Since the similarity metrics allow fuzzy matches, reasoning in CBR systems is approximate.
Consequently, as Richter and Weber argue, the characteristic that distinguishes CBR from deductive reasoning in logic or databases is that *"it does not lead from true assumptions to true conclusions"* [-@Richter2013, p. 18].

A key feature of CBR is that similarity computation typically requires background knowledge.
While similarity of cardinal features can be determined without it, nominal features call for additional knowledge to assess their degree of similarity. <!-- Richter and Weber use "ordinal" instead of "cardinal". -->
For instance, a taxonomy may be used to compute similarity as the inverse of taxonomic distance between the values of the compared feature.
Since hand-coding background knowledge is expensive, and typically requires assistance of domain experts, CBR research considered alternatives for knowledge acquisition, such as using external semantics from linked open data or discovering latent semantics via machine learning.

The retrieved nearest neighbour cases serve as potential sources of a solution to the query problem.
Solutions of these cases are copied and adapted in the *Reuse* step to formulate a solution answering the query.
If a solved case matches the problem at hand exactly, we may directly reuse its solution.
However, exact matches are rare, so the solutions to matching cases often need to be adapted.
For example, solutions may be reused at different levels.
We may either reuse the process that generated the solution, reuse the solution itself, or do something in between.

The reused solution is evaluated in the *Revise* step to assess whether it is applicable to the query problem.
Without this step a CBR system cannot learn from its mistakes.
It is the step in which CBR may add user feedback.

Finally, in the *Retain* step, the query problem and its revised and adopted solution may be incorporated in the case base as a new case for future learning.
Alternatively, the generated case may be discarded if the CBR system stores only the actual cases.

The CBR cycle may be preceded by preparatory steps described by Richter and Weber [-@Richter2013].
A CBR system can be initialized by the *Knowledge representation* step, which structures the knowledge contained in cases the system learns from.
Cases are explicitly formulated and described in a structured way, so that their similarity can be determined effectively.
The simplest representation of a case is a set of feature-value pairs.
However, using more sophisticated data structures is common.
In order to compute similarity of cases, they must be described using comparable features, or, put differently, the descriptions of cases must adhere to the same schema.

*Problem formulation* is a preliminary step in which a query problem is formulated.
A query can be considered a partially specified case.
It may be either underspecified, such that it matches several existing cases, or overspecified, if it has no matches due to being too specific.
Underspecified queries may require solutions from the matching cases to be combined, while overspecified queries may need to be relaxed or provided with partial matches.

Overall, the CBR cycle resembles human reasoning, such as problem solving by finding analogies.
In fact, the CBR research is rooted in psychology and cognitive science.
It is also similar to case law, which reasons from precedents to produce new interpretations of law.
Thanks to these similarities, CBR is perceived as natural by its users [@Kolodner1992], which makes its function usually easy to explain.

<!-- Case-based recommenders -->

CBR is commonly employed in recommender systems. 
Case-based recommenders are classified as a subset of knowledge-based recommenders [@Jannach2010].
Similarly to collaborative recommendation approaches, case-based recommenders exploit data about past behaviour.
However, unlike collaborative recommenders, *"the case-based approach enjoys a level of transparency and flexibility that is not always possible with other forms of recommendation"* [@Smyth2007, p. 370], since it is based on reasoning with explicit knowledge.
Our adaptation of CBR for matchmaking can be thus considered a case-based recommender.

<!--
CBR is based on extensional semantics.
Instead of defining a solution to a case as a class of instances, CBR defines it simply by the set of cases, without synthesizing general class characteristics.

Important factors for case bases:
1. Representational fidelity (knowledge representation of cases)
2. Size (more cases to learn from)
-->
