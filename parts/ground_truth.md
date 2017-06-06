## Ground truth {#sec:ground-truth}

The fundamental part of the proposed matchmaking methods is the ground truth they are based on.
We use past contracts awards as the ground truth from which the methods learn to assess matches.

There are inherent downsides in our assumptions about the ground truth we used.
The assumption that the awarded bidder is the best match for a contract is fundamentally problematic.
We have to rely on contract awards only, since we do not have explicit evaluations of the awarded bidders after finishing the contracts.
Lack of post-award data is common in public procurement:

> *"With a few exceptions such as Italy and Estonia, no government publishes information on contract implementation, making it impossible to know what happens after the contract is awarded — for example, did the suppliers deliver on time and budget?"* [@Mendes2017]

Nor do we have any other relations between bidders and contracts in our dataset.
However, profiles of contracting authorities link contracts with all bidders that submitted a valid bid.

We need to take into account that bidders may be awarded on the basis of adverse selection, e.g., caused by asymmetric distribution of information.
Tendering processes can suffer from collusion when multiple parties agree to limit open competition.
In that case, rival bidders may cooperate for mutual benefit, for instance, by bid rigging that involves submitting overvalued fake bids to make real bids more appealing.
Neither we can assume that bidders who were awarded multiple contracts from the same contracting authority have proven their quality.
Instead, they may just be cases of clientelism.

<!--
Cartels are explicit collusion agreements.
A close problem: monopoly

Can we identify "bad" bidders? Do they exhibit certain patterns that we can recognize in the data?
(Perhaps we can use data from ÚOHS. However, Sbírka rozhodnutí by ÚOHS is not machine readable.)

What we have is this: Similar contracts are usually awarded to these bidders.

Matchmaking can therefore serve only as pre-filtering.
The problem with filtering is that it potentially leaves relevant bidders behind, so that we cannot say that the bias will be dealt with by manual screening of the matches.

Since learning from contracts awarded in the past is the fundamental part of our machine learning approach, the key question is this: Is the bias severe enough to make it better to avoid learning from past contracts?

Nevertheless, how can matchmaking work without learning from the awarded contracts? Can it only employ similarity-based retrieval?
-->

We devised several countermeasures to ameliorate the impact of adverse selection in our ground truth.
We experimented with discounting contract awards by the zIndex scores of their contracting authorities.
However, this is a blunt tool, since it applies across the board for all contracts by a contracting authority.
Within large contracting authorities each contract may be administered by different civil servants, which may change over time.

We experimented with limiting our ground truth only to contracts awarded in open procedures.
The intuition motivating this experiment is that a contract awarded in an open procedure enables fairer competition and thus avoids some risks of adverse selection.

An alternative option is to restrict contract awards to learn from by their award criteria.
While it may seem that the simple criterion of lowest price is fair, it may be skewed by intentionally inflated fake bids due to bidder collusion.
Other, more complex award criteria, such as those emphasizing qualitative aspects, can be problematic too.
Their evaluation leaves more room for deliberation of contracting authorities, and as such, they can be made less transparent.

However, a likely outcome of these corrective measures is performance loss in the evaluation via retrospective data.
Matchmakers may be underfitting, unable to completely capture the underlying trends in the public procurement data, which too include biases from adverse selection.
On contrary, learning from all contract awards overfits, so that it includes the negative effects in public procurement too.
It may mistake random variability and systemic biases for causality.
