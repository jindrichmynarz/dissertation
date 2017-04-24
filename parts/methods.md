# Matchmaking methods

Matchmaking can be framed as a task for case-based reasoning.
Data on awarded contracts can be recasted as past cases to learn from.
Bidders in the most similar awarded contracts are recommended as solutions to the query contract.

Public contract ~ case
Reinterpretation of previously awarded public contracts as experiences of solved problems.
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

<!--
Interoperability based on common data model.
If data follows the model described in the chapter on data preparation, the developed matchmakers can be applied to it.
-->

<!--
Limitation: Our approach works as a one-shot recommendation
One-shot recommendation is typical for case-based recommenders [@Smyth2007].
Is there a way to provide user feedback?
Conversational recommender system elicit user feedback to refine their recommendations.
For example, user may provide critiques, e.g., require cheaper matches.
Critiques are directional feature constraints [@Smyth2007, p. 361].
Query-based approaches: often users have to respecify their query in case no results are found.
Browsing-based approaches: navigation of the item space, for example using critique-based navigation
- Critiquing can be used to reformulate matchmaking queries (e.g., assign different weights) or query the results (e.g., filter to meet the critique).
-->

<!--
Formalization of the methods should be provided.
We can start with a definition of the key entities involved in the matchmaking task.
-->

<!-- TODO: Add a diagram showing the technology stack involved in the matchmaker. -->

<!--
Subscription to streams
- Notifications

Push-based recommendations ~ matchmaking subscriptions
- Proactive recommendation: *"A proactive recommender system pushes recommendations to the user when the current situation seems appropriate, without explicit user request."* (<http://pema2011.cs.ucl.ac.uk/papers/pema2011_vico.pdf>)
-->

<!--
SPARQL and full-text matchmakers are "lazy learners", since they do not build explicit models.
Since there is no model, performance might be worse.
We can consider database indices to be the "models".

Representation of cases for efficient retrieval ~ feature selection and construction
-->

<!--
Limitation: CBR approach favours larger and longer-established suppliers.
This is an opportunity to normalize by the bidder's age from ARES.
-->

Using the terminology of case-based reasoning, CPV provides a "bridge attribute" that allows to derive the similarity of contracts from the shared concepts in their descriptions.

Matchmaking basically learns the associations between CPV concepts and bidders from contract awards. <!-- Potentially NACE concepts too. -->
For each CPV concept the most associated bidders can be found.

<!--
## Feature selection

Manual feature selection ~ schema-aware matchmaking
-->

<!--
Top-k recommendation: best matches are shown, but not their predicted ratings.
-->
