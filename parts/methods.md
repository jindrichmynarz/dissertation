# Matchmaking methods {#sec:methods}

<!--
Why we have chosen these methods?
Should we formulate requirements for the matchmaking methods?
-->

We applied two methods to matching public contracts to bidders: case-based reasoning (CBR) and statistical relational learning (SRL).
We first review what these methods have in common and then discuss their differences.
Both methods learn from the same ground truth and have to cope with its limitations and biases, described in the [@sec:ground-truth], such as having only positive training examples.
In this ground truth, public contracts represent explicit demands and contract awards model past behaviour of bidders offering products or services.
Both methods learn only from their input data, not from user feedback.
In order to incorporate user feedback, it would need to materialized as part of the input data.
This approach is known as one-shot recommendation, and is typical for case-based recommenders in particular [@Smyth2007].
We employed manual feature selection, corresponding to schema-aware matchmaking.
Portability of the developed matchmakers is granted by the common data model underlain by the Public Contracts Ontology, which we covered in the [@sec:pco].
The matchmakers therefore work with any dataset described by the PCO, such as the Czech public procurement dataset that constitutes our use case.
Both methods are evaluated on the task of predicting the awarded bidders.
The inverse task of recommending relevant public contracts to bidders is feasible as well, but we have not focused on it, since it mirrors the evaluated task.

<!-- Case-based reasoning -->

The underlying technology we used to implement the matchmakers based on case-based reasoning, introduced in the [@sec:cbr], is SPARQL [@Harris2013].
Using the means of SPARQL we designed a custom-built matchmaking method, explained in detail in the [@sec:method-sparql].
In line with the CBR perspective, this method recasts data on awarded contracts as past cases to learn from.
Viewed this way, awarded contracts can be considered as experiences of solved problems and contract awards can be thus interpreted as implicit positive ratings of the awarded bidders.
Consequently, bidders awarded with most contracts similar to a given query contract can be recommended as potential awardees of the contract.

The developed matchmakers implement only the *Retrieve* and *Reuse* steps from the CBR cycle.
The retrieved matches are ranked to produce recommendations for reuse.
Including the *Revise* step would require the matchmakers to incorporate user feedback.
The *Retain* step is not applicable if the proposed matches are not approved or disapproved in the *Revise* step.
Both the *Knowledge representation* and the *Problem formulation* steps can be considered to be incorporated in data preparation, as documented in the [@sec:data-preparation], since both cases and queries are materialized as data. 

Matchmaking via SPARQL is conceived as a top-$k$ recommendation task.
It produces a list of bidders sorted by their degree to which they match the requirements of a given query contract.
Since there is no explicit model built by this method, it is a case of lazy learning.
Having no model to create up front allows to answer matchmaking queries in real time and to update the queried data in an incremental fashion.

<!-- Statistical relational learning -->

Matchmakers based on statistical relational learning (SRL), which we presented in the [@sec:srl], are built on RESCAL [@Nickel2011],
In this case, we adopted an existing learning method for the matchmaking task, as explained in the [@sec:method-rescal].
Viewed from the perspective of SRL, matchmaking can be conceived as link prediction.
In our setting, the task of matchmaking is predicting the most likely links between public contracts and their winning bidders.

Unlike the method based on SPARQL, RESCAL is a latent feature model.
Since it builds a prediction model up front, it is an example of eager learning.
Consequently, it operates in a batch mode that allows to update data only in bulk.

The key differences between the use of CBR and SRL for matchmaking are summarized in the [@tbl:matchmaking-methods-differences].
Matchmaking can be also implemented via hybrid methods that combine multiple approaches.
For instance, SPARQL can be used to pre-select matches and RESCAL can then re-rank this selection.

Method                    CBR                     SRL
------------------------- ----------------------- --------------
Underlying technology     SPARQL                  RESCAL
Method origin             custom-built            reused
Learning method           lazy learning           eager learning
Matchmaking conceived as  top-$k$ recommendation  link prediction
Features                  observable              latent
Mode of operation         on demand query         batch
Update                    incremental             bulk

Table: Differences of the adopted matchmaking methods {#tbl:matchmaking-methods-differences}

<!--
SPARQL and full-text matchmakers are "lazy learners", since they do not build explicit models.
Since there is no model, performance might be worse. (Why?)
We can consider database indices to be the "models".

Limitation: CBR approach favours larger and longer-established suppliers.
This is an opportunity to normalize by the bidder's age from ARES.

Using the terminology of case-based reasoning, CPV provides a "bridge attribute" that allows to derive the similarity of contracts from the shared concepts in their descriptions.
- The other properties can be considered bridge attributes too, right?

Matchmaking basically learns the associations between CPV concepts and bidders from contract awards.
- Potentially NACE concepts too.
For each CPV concept the most associated bidders can be found.

Diversity of results is often low in case-based recommenders based on similarity-based retrieval.
There are several strategies to mitigate this issue:
- Bounded greedy selection: minimizes total similarity in the result set, while maximizing total similarity of the result set to the query.

Use a more content-based approach (leveraging data from ARES) for cold-start users (i.e. those without an awarded contract)?
Alternative solutions:
* Users may subscribe to recommendations for other users. For example, they may be asked to list their competitors, who were awarded public contracts, and be subscribed to their recommendations.
* Ask users to rate a sample of public contracts either as relevant or irrelevant. The sample must be chosen in order to maximize the insight learnt from the rating, e.g., the sample should be generated dynamically to increase its overall diversity.

If no matches are found:
- Contracting authority can respecify the query contract.
  - Such contract may be overspecified or merge unrelated goods or services that can be better awarded via multiple contracts.
- Bidder can ask for recommendation for its competitors.
-->

<!--
Out-takes:

Top-k recommendation: best matches are shown, but not their predicted ratings.

Matchmaking public contracts to bidders can be framed as a task for case-based reasoning.
Data on awarded contracts can be recast as past cases to learn from.

Public contract ~ case
Reinterpretation of the previously awarded public contracts as experiences of solved problems.
Contract award can be interpreted an implicit rating of the awarded bidder.
Reinterpretation of contract award as a positive rating (in the context of the awarded contract)
Limitation: We have only positive ratings.

The matchmaker learns from interactions between contracting authorities and bidders

Collaborative recommender systems: explicit offers (product or services) + demand behaviour (user interactions)
Our case-based recommender: explicit demands (contracts) + offer behaviour (histories of bidders)

Comparison of CBR systems with databases in [@Richter2013, p. 524].
Mismatch: SPARQL operates under the closed world assumption. CBR assumes open world.

From the perspective of a contracting authority, the task seems like matchmaking.
From the bidder's perspective, the task seems like recommendation.

## Modes of delivery

- on demand queries (pull)
- subscriptions (push, "persistent" queries)
  - Subscription to streams, notifications
  - Push-based recommendations ~ matchmaking subscriptions
    - Proactive recommendation: *"A proactive recommender system pushes recommendations to the user when the current situation seems appropriate, without explicit user request."* (<http://pema2011.cs.ucl.ac.uk/papers/pema2011_vico.pdf>)

## Notation conventions

We employ conventional notation to describe the matchmaking methods.
We use $\mathbb{P}$ to denote a power set of a set.
We use $a \oplus b$ to denote concatenation of n-tuples $a$ and $b$.
We mark the set of tuples of elements from the set $S$ as $(S)$.
Composition of functions $f$ and $g$ is denoted $f \circ g$.

Feature selection as a way of mitigating the curse of dimensionality?
[@Ragone2017]

## One-shot recommendation

A limitation of our approach is that it works as a one-shot recommendation that does not take user feedback on the generated recommendations into account.
Since the matchmakers do not have a conversational interface with which users can iteratively refine their query, if no suitable match is found, users need to revise their query and start again, even though they may not be able to provide a detailed query from the start.
This can be characterized as a query-based approach, in which users have to respecify their query in case no results are found.
One-shot recommendation is typical for case-based recommenders [@Smyth2007].
The opposite is true of conversational recommender systems that elicit user feedback to refine their recommendations.
For example, users may provide a critique, such as requiring cheaper matches.
Critiques can be interpreted as directional feature constraints [@Smyth2007, p. 361].

Moreover, SPARQL requires *"users to express their needs in a single query"*. (FIXME: Missing a citation!)
This is why the matchmaker employs a single-shot approach.

Is there a way to provide user feedback?
Browsing-based approaches: navigation of the item space, for example using critique-based navigation
- Critiquing can be used to reformulate matchmaking queries (e.g., assign different weights) or query the results (e.g., filter to meet the critique).
-->
