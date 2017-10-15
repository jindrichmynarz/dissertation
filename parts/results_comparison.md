## Comparison of the results

When we compared the evaluation results of the SPARQL-based and the RESCAL-based matchmakers, we could see that both approaches were largely in line with each other.
Both highlighted `pc:mainObject` as the principal feature for matchmaking.
Both found the highest predictive power in subject classifications with controlled vocabularies.
Overall, the RESCAL-based matchmakers produced results with very low diversity, especially when considering their CC@10.
The low diversity means that they tend to recommend the same bidders repeatedly, the shortcoming we did not observe in most of the SPARQL-based matchmakers.
The gap between the evaluated approaches to matchmaking was not as pronounced in accuracy metrics, although for them the RESCAL-based matchmakers also delivered inferior results.

The best SPARQL-based matchmaker used `pc:mainObject` with query expansion by 1 hop to both broader and narrower CPV concepts that were associated with the weight of 0.1.
The best RESCAL-based matchmaker employed `pc:mainObject` in combination with `rov:orgActivity`.
Both best-performing matchmakers merged features from multiple linked datasets.
The SPARQL-based one added the CPV hierarchy to the Czech public procurement dataset, while the RESCAL-based one combined the procurement data with the Business Register.

Matchmaker     HR@10    MRR@10     CC@10    PC    LTP@10
---------- --------- --------- --------- ----- ---------
SPARQL     **0.259** **0.128** **0.563** 0.991 **0.678**
RESCAL         0.187     0.083     0.036 **1**     0.295

Table: Best matchmakers based on SPARQL and RESCAL {#tbl:sparql-rescal-comparison}

As shown in [Table @tbl:sparql-rescal-comparison], the best SPARQL-based matchmaker clearly outmatches the best RESCAL-based matchmaker both in terms of accuracy and diversity.
Moreover, the SPARQL-based matchmaker also excels in performance and the ability to handle real-time queries.
