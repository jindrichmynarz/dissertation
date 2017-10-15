## Comparison of the results

<!--
Compare the results of SPARQL-based and RESCAL-based matchmakers.
Add a comparison of the best-performing configurations of SPARQL-based and RESCAL-based matchmakers.
-->

<!--
The evaluation results of both approaches are in line with each other.
Both approaches highlight `pc:mainObject` as the principal feature for matchmaking.
highest predictive power found in subject classifications with controlled vocabularies
-->

<!--
Overall, the RESCAL-based matchmakers produce results with very low diversity, especially when considering their CC@10.
The low diversity means that they tend to recommend the same bidders repeatedly.
-->

The best SPARQL-based matchmaker uses `pc:mainObject` with query expansion by 1 hop to both broader and narrower CPV concepts that are associated with the weight of 0.1.
The best RESCAL-based matchmaker employs `pc:mainObject` in combination with `rov:orgActivity`.
As shown in [Table @tbl:sparql-rescal-comparison], the best SPARQL-based matchmaker clearly outmatches the best RESCAL-based matchmaker both in terms of accuracy and diversity.

Matchmaker     HR@10    MRR@10     CC@10    PC    LTP@10
---------- --------- --------- --------- ----- ---------
SPARQL     **0.259** **0.128** **0.563** 0.991 **0.678**
RESCAL         0.187     0.083     0.036 **1**     0.295

Table: Best matchmakers based on SPARQL and RESCAL {#tbl:sparql-rescal-comparison}
