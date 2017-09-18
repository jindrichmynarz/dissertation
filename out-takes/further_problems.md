## Further problems

* Explaining recommendations <!-- To achieve transparency of matchmaking results. -->
* Constraint relaxation: When no results are returned, use more generic features or leave most discriminating features out.
* Ranking and the primacy effect (= users look at the first results)
  * Primacy effect = Items at the beginning of a recommendation list are analyzed more frequently.
* Determine the weights of features based on their perceived utility
* Reformulate award criteria using <https://en.wikipedia.org/wiki/Conjoint_analysis>?
* What repair action can we provide users when faced with empty results of matchmaking?
* Try hybrid methods?
* Learning to rank

<!--
TODO: Try to run matchmaking over data in <http://pproc.unizar.es:8890/sparql>. We'd need to make our own copy.
-->

<!--
* Now-defunct bidders should be filtered out.
* Match score can be normalized by the bidders age (now() - dcterms:issued).
* Contracts with more tenders (`pc:numberOfTenders`) can be scored as more telling, since the bidder won in greater competition.
* Contracts with open procedures can be also scored as more telling.
-->
