## Future work

<!-- náměty pro další vědecké zkoumání -->

Overall, we explored only a handful of ways of matching public contracts to bidders.
Our work suggests that investing in improving the data quality may produce the highest returns.
Adaptation of different approaches for the matchmaking tasks may also fundamentally alter the characteristics of matchmakers.
In particular, we expect methods that are better able to leverage unstructured data in literals to determine the similarity of public contracts, such as full-text search in semi-structured data, to have a considerable potential to improve the results of matchmaking.
Alternatively, matchmakers can build on other promising approaches for statistical relational learning from linked data, such as @Bordes2013.
Ultimately, many more ways of relevance engineering for the task of matchmaking are left open to pursue and assess their worth.
However, assessing matchmakers on the task of prediction of the awarded bidders may turn out to be a false compass.
As we discussed at length in [Section @sec:ground-truth], this evaluation setup using retrospective data on contract awards is subject to many shortcomings.
Alternative ways of evaluation may bypass the weaknesses of this setup, possibly by conducting an online evaluation with real users or by involving domain experts in qualitative evaluation.
Thorough examination of these alternatives for evaluation is imperative for further investigation of matchmaking methods.
