\newpage

# Research topic

<!-- vymezení tématu práce -->

Matchmaking is an information retrieval task that ranks pairs of demands and offers according to the degree to which the offer satisfies the demand.
It is a *"process of searching the space of possible matches between demand and supplies"* [@DiNoia2004, p. 9].
For example, matchmaking can pair job seekers with job postings, discover suitable reviewers for doctoral theses, or match romantic partners.

Our work concerns matchmaking of bidders to public contracts in public procurement.
The main motivation of our research is to improve resource allocation in the public procurement market by providing better information to its participants. 
In this context, matchmaking can suggest relevant business opportunities to bidders or recommend bidders to be approached by contracting authorities for a given public contract.

Our approach to matchmaking is based on sound data and technologies.
We employ linked open data (LOD) as a method for integrating public procurement data and enabling to combine it with other data.
A key challenge in using linked open data is to reuse or develop appropriate techniques for data preparation.

We demonstrate how two generic approaches can be applied to the matchmaking task, namely case-based reasoning (CBR) and statistical relational learning (SRL).
In the CBR context, we treated matchmaking as top-$k$ recommendation.
We used the SPARQL [@Harris2013] query language for data in RDF [@Cyganiak2014b] to implement this task.
In the case of SRL, we approached matchmaking as link prediction.
We used tensor factorization with RESCAL [@Nickel2011] for this task.
The key challenges of matchmaking by these technologies involve feature selection or feature construction, weighting features, and combination functions for aggregating similarity scores of matches.

In order to examine the outlined approaches for matchmaking, we prepared a Czech public procurement dataset that links together several sources of open government data, such as the Czech business register or public procurement classifications.
In this use case, our task is to select, combine, and apply the state-of-the-art techniques to a real-world scenario.
Our key stakeholders in this use case are the participants in the public procurement market: contracting authorities, who represent the side of demand, and bidders, who represent the side of supply.
