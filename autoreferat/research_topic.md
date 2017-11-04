\newpage

# Research topic

<!-- vymezení tématu práce -->

Our approach to matchmaking is based on two components: good data and good technologies.
We employ linked open data as a method to defragment and integrate public procurement data and enable to combine it with other data.
A key challenge in using linked open data is to reuse or develop appropriate techniques for data preparation.

We demonstrate how two generic approaches can be applied to the matchmaking task, namely case-based reasoning and statistical relational learning.
In the context of case-based reasoning, we treated matchmaking as top-$k$ recommendation.
We used the SPARQL [@Harris2013] query language to implement this task.
In the case of statistical relational learning, we approached matchmaking as link prediction.
We used tensor factorization with RESCAL [@Nickel2011] for this task.
The key challenges of matchmaking by these technologies involve feature selection or feature construction, ranking by feature weights, and combination functions for aggregating similarity scores of matches.
Our work discusses these challenges and proposes novel ways of addressing them.

In order to explore the outlined approaches we prepared a Czech public procurement dataset that links several related open government data sources together, such as the Czech business register or the postal addresses from the Czech Republic.
Our work can be therefore considered a concrete use case in the Czech public procurement.
Viewed as a use case, our task is to select, combine, and apply the state-of-the-art techniques to a real-world scenario.
Our key stakeholders in this use case are the participants in the public procurement market: contracting authorities, who represent the side of demand, and bidders, who represent the side of supply.
The stakeholder groups are driven by different interests; contracting authorities represent the public sector while bidders represent the private sector, which gives rise to a sophisticated interplay of the legal framework of public procurement and the commercial interests.
