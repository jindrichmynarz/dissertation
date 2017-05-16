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

## Ground truth {#sec:ground-truth}

There are downsides that are inherent to our assumptions about the used ground truth.
The assumption that the awarded bidder is the best match for a contract is fundamentally problematic.
We have to rely on contract awards only, since we do not have explicit evaluations of the awarded bidders after finishing the contracts.
Bidders may be awarded on the basis of adverse selection, caused by asymmetric distribution of information.
Tendering processes can suffer from collusion when multiple parties agree to limit open competition.
In that case, rival bidders may cooperate for mutual benefit, for instance, by bid rigging that involves submitting overvalued fake bids to make real bids more appealing.
Neither we can assume that bidders who were awarded multiple contracts from the same contracting authority have proven their quality.
Instead, they may just be cases of clientelism.

<!--
Cartels are explicit collusion agreements.
A close problem: monopoly

Can we identify "bad" bidders? Do they exhibit certain patterns that we can recognize in the data?
(Perhaps we can use data from ÚOHS. However, Sbírka rozhodnutí by ÚOHS is not machine readable.)

The majority of the Czech public contracts actually used an open procedure.

What we have is this: Similar contracts are usually awarded to these bidders.

Matchmaking can therefore serve only as pre-filtering.
The problem with filtering is that it potentially leaves relevant bidders behind, so that we cannot say that the bias will be dealt with by manual screening of the matches.

Since learning from contracts awarded in the past is the fundamental part of our machine learning approach, the key question is this: Is the bias severe enough to make it better to avoid learning from past contracts?

Nevertheless, how can matchmaking work without learning from the awarded contracts? Can it only employ similarity-based retrieval?

Countermeasures:
There are several ways we attempted to ammeliorate the biases in our ground truth:

* We experimented with discounting contract awards by the zIndex scores of their contracting authorities.
  However, this is a blunt tool, since it applies across the board for all contracts by a contracting authority.
  Within large contracting authorities each contract may be administered by different civil servant.
  Moreover, the people involved in public procurement of a contracting authority change over time.
* We experimented with limiting contracts awards to those awarded in open procedures.
  An intuition motivating this experiment is that a contract awarded in an open procedure enables fairer competition and thus avoid some risks of adverse selection.
  However, a likely outcome of these corrective measures is performance loss in the evaluation via retrospective data.
  This can be described as underfitting, while learning from all contract awards overfits, so that it includes the negative effects in public procurement too.
* An alternative option is to restrict contract awards to learn from by their award criteria.
  It seems that the simplistic criterion of lowest price is fair, but, due to bidder collusion the lowest price may be intentionally inflated by fake bids.
  Other, more complex award criteria leave more room for deliberation of contracting authorities.
  As such, they can be made less transparent.
-->
