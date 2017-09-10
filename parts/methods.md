# Matchmaking methods

<!--
TODO: It may make sense to move much content from the specific sections of this chapter here.
Many methods will be generic to more than one approach. For example, weighting or query expansion.
However, without the finished implementations of all the matchmaking methods, shuffling content around would be a premature optimization.
-->

Case-based reasoning [@sec:cbr]: SPARQL
- Custom built method
- Implements only the *Retrieve* and *Reuse* steps from the CBR cycle?
  - The *Revise* step would require to incorporate user feedback.
  - The *Retain* step is useless if the proposed solutions are not verified in the revise step.
- Both the *Knowledge representation* and the *Problem formulation* steps are implemented in data preparation, as described in the [@sec:data-preparation].
- Observable features
- Real time response possible

Statistical relational learning [@sec:srl]: RESCAL
- Latent feature model
- Batch mode of operation, no updates in real time 
- Reused method (RESCAL is treated as a black-box)

Both methods share the same ground truth and have to cope with its limitations and biases [@sec:ground-truth].

Why we have chosen these methods?

<!-- FIXME: This seems to match the introductory section on case-based reasoning. -->

Matchmaking public contracts to bidders can be framed as a task for case-based reasoning.
Data on awarded contracts can be recast as past cases to learn from.
Bidders in the most similar awarded contracts are recommended as solutions to the query contract.

Public contract ~ case
Reinterpretation of the previously awarded public contracts as experiences of solved problems.
Contract award can be interpreted an implicit rating of the awarded bidder.
Reinterpretation of contract award as a positive rating (in the context of the awarded contract)
Limitation: We have only positive ratings.

The matchmaker learns from interactions between contracting authorities and bidders

Collaborative recommender systems: explicit offers (product or services) + demand behaviour (user interactions)
Our case-based recommender: explicit demands (contracts) + offer behaviour (histories of bidders)

<!--
From the perspective of a contracting authority, the task seems like matchmaking.
From the bidder's perspective, the task seems like recommendation.
-->

<!-- Portability -->

The portability of the developed matchmaking methods is granted by the common data model underlain by the Public Contracts Ontology [@sec:pco].
Matchmakers can therefore run on any dataset described by the PCO.
One of such datasets is the Czech public procurement dataset which constitutes the use case for our work.

<!-- Limitations -->

The proposed methods for matchmaking suffer from several limitations.

<!-- One-shot recommendation -->

A limitation of our approach is that it works as a one-shot recommendation that does not take user feedback on the generated recommendations into account.
Since the matchmakers do not have a conversational interface with which users can iteratively refine their query, if no suitable match is found, users need to revise their query and start again, even though they may not be able to provide a detailed query from the start.
This can be characterized as a query-based approach, in which users have to respecify their query in case no results are found.
One-shot recommendation is typical for case-based recommenders [@Smyth2007].
The opposite is true of conversational recommender systems that elicit user feedback to refine their recommendations.
For example, users may provide a critique, such as requiring cheaper matches.
Critiques can be interpreted as directional feature constraints [@Smyth2007, p. 361].

Moreover, SPARQL requires *"users to express their needs in a single query"*. <!-- FIXME: Missing a citation! -->
This is why the matchmaker employs a single-shot approach.

<!--
Is there a way to provide user feedback?
Browsing-based approaches: navigation of the item space, for example using critique-based navigation
- Critiquing can be used to reformulate matchmaking queries (e.g., assign different weights) or query the results (e.g., filter to meet the critique).
-->

<!--
Queries vs. subscriptions

Subscription to streams
- Notifications

Push-based recommendations ~ matchmaking subscriptions
- Proactive recommendation: *"A proactive recommender system pushes recommendations to the user when the current situation seems appropriate, without explicit user request."* (<http://pema2011.cs.ucl.ac.uk/papers/pema2011_vico.pdf>)
-->

<!--
SPARQL and full-text matchmakers are "lazy learners", since they do not build explicit models.
Since there is no model, performance might be worse. (Why?)
We can consider database indices to be the "models".
-->

<!--
Limitation: CBR approach favours larger and longer-established suppliers.
This is an opportunity to normalize by the bidder's age from ARES.
-->

Using the terminology of case-based reasoning, CPV provides a "bridge attribute" that allows to derive the similarity of contracts from the shared concepts in their descriptions.
<!-- The other properties can be considered bridge attributes too, right? -->

Matchmaking basically learns the associations between CPV concepts and bidders from contract awards. <!-- Potentially NACE concepts too. -->
For each CPV concept the most associated bidders can be found.

Diversity of results is often low in case-based recommenders based on similarity-based retrieval.
There are several strategies to mitigate this issue:
- Bounded greedy selection: minimizes total similarity in the result set, while maximizing total similarity of the result set to the query.

<!--
Comparison of CBR systems with databases in [@Richter2013, p. 524].
Mismatch: SPARQL operates under the closed world assumption. CBR assumes open world.
-->

<!--
Use a more content-based approach (leveraging data from ARES) for cold-start users (i.e. those without an awarded contract)?
Alternative solutions:
* Users may subscribe to recommendations for other users. For example, they may be asked to list their competitors, who were awarded public contracts, and be subscribed to their recommendations.
* Ask users to rate a sample of public contracts either as relevant or irrelevant. The sample must be chosen in order to maximize the insight learnt from the rating, e.g., the sample should be generated dynamically to increase its overall diversity.
-->

<!-- ## Feature selection -->

We employed manual feature selection.
As such, it corresponds to schema-aware matchmaking.

<!-- Feature selection as a way of mitigating the curse of dimensionality? -->

The matchmakers suffer from the curse of dimensionality.
RDF data is typically complex and contains many dimensions.
Linear increase of dimensions leads to exponential growth of negative effects.

[@Ragone2017]

<!--
Top-k recommendation: best matches are shown, but not their predicted ratings.
-->

<!-- ... segue ... -->

We experimented with matchmaking methods that use SPARQL and tensor factorization.

<!-- ## Notation conventions -->

We employ conventional notation to describe the matchmaking methods.
We use $\mathbb{P}$ to denote a power set of a set.
We use $a \oplus b$ to denote concatenation of n-tuples $a$ and $b$.
We mark the set of tuples of elements from the set $S$ as $(S)$.
Composition of functions $f$ and $g$ is denoted $f \circ g$.
