#### zIndex {#sec:zindex}

zIndex^[<http://zindex.cz/en>] grades Czech contracting authorities with fairness scores.
The scores are based on the contracting authority's adherence to good practices in public procurement as observed from the data it discloses [@Soudek2016b].
As its authors suggest, high zIndex score implies that there is less room for mismanagement of public funds, while a low score indicates the opposite.
zIndex scores are normalized to the interval between 0 and 1, in which 1 represents the best score.
The index is produced by the EconLab,^[<http://www.econlab.cz/en>] a Czech economic NGO focused on public policy.

Our case-based reasoning approach to matchmaking works under the assumption that the awarded bidders constitute cases of successful solutions to public contracts.
As we discuss at length further in [Section @sec:ground-truth], this assumption may not be universally valid, considering that bidders may be awarded for reasons other than providing the best offer.
zIndex gives us a counter-measure to balance this assumption by weighting each award by the fairness score of its contracting authority.

However, the perceived fairness of contracting authorities may change over time and so do their zIndex scores that are based on a specific period of the contracting authority's history.
In our case, most scores zIndex scores we had were derived from the period from 2011 to 2013.
As such, they are most relevant for public contracts dated at the end of this period, and may be misleading for the contracts awarded in years further apart.

zIndex scores were initially supplied to the author by Datlab s.r.o.^[<http://datlab.cz>] in September 2014.
An updated snapshot of zIndex was provided upon request in January 2017.
The data in CSV was transformed to RDF by using Tarql.
The RDF version of the data was represented as a simple data cube using the Data Cube Vocabulary [@Cyganiak2014a].
Each zIndex score was modelled as a measure of an observation indexed by the dimensions of the scored contracting authority and the rating period.
Contracting authorities in this dataset are identified by their IRIs from ARES, which are automatically derived from their RNs.
The scores are available for 29.4 % of the contracting authorities in our dataset. <!-- 4989 out of 16982. -->
