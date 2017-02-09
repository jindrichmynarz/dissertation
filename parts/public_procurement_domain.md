## Public procurement domain

<!-- Pro-active disclosure of demand data. -->

The domain of public procurement is suitable for matchmaking because, unlike many other domains, demands are made explicit in contract notices.
In many other domains only supply is explicitly described in advertising, while demand is left implicit.
Explicit formulation of demand allows us to process it automatically.
The explicit formulation is required by law to ensure a basic level of transparency and thus minimize corruption risks.

Problems of transparency:

- Matchmaking will be used only by willing civil servants.
- Corruption scandals are ignored and eventually forgotten by the public.

Disclosure of public procurement data is mandated by legislation, which requires public contracts that meet prescribed conditions, including thresholds for money spent, to be advertised publicly through contract notices ([Graux and Kronenburg, 2012](#Graux2012), p. 7). 
In the European Union, public contracts are classified as public sector information, which is prescribed to be publicly available by the *Directive on the re-use of public sector information* ([EU, 2013](#EU2013)).
Standardization is a key instrument for achieving reuse of public sector data by third parties, such as businesses or supervisory bodies for the public sector.
While the central registers of public procurement are intended to improve reuse and serve to public oversight, their implementation often leaves much to be desired.
Public procurement data is subject to imperfect standardization, which results in variety in data.
The imperfect standardization of public procurement data is caused by factors including divergent transposition of EU directives into legal regimes of EU member states, lack of adherence to standards, underspecified standards leaving open space for inconsistencies, or meagre incentives and sanctions for abiding by the standards and prescribed practices. 
Euzenat and Shvaiko characterize the public sector domain by *"a variety of information, of variable granularity and quality created by different institutions and represented in heterogeneous formats"* ([2013](#Euzenat2013), p. 12).
While Gosain offers a definition of a standard as a *"coordination mechanism around non-proprietary knowledge that organizes and directs technological change"* ([2003](#Gosain2003), p. 18), linked data enables to cope with insufficient standardization by allowing for *"cooperation without coordination"* ([Wood, 2011](#Wood2011), p. 5), which enables to bridge local heterogeneities via the flexible data model of linked data.
In effect, data integration based on linked data can be considered as a compensating mechanism for the impact of imperfect standardization.

Public procurement data is subject to mandatory disclosure to ensure equal access to the data for all members of the public.
The objectives pursued by public disclosure of procurement data include improved transparency of the participating public sector bodies or enabling fair competition in the procurement market.
A typical solution for enhancing accessibility and usability of public sector data is its aggregation in central registers.
However, the goals pursued by public disclosure and aggregation of procurement data are often undermined by insufficient data integration caused by heterogeneity of data provided by diverse contracting authorities.
Imperfect standardization of public procurement data, violations of the prescribed schema, lacking data validation, and absent enforcement of the mandated practices of public disclosure result in partial data integration, so that a large share of the integration effort is left to the users of the data.
Tasks such as search in aggregated data or establishing identity of economic operators suffer from data inconsistency.
Moreover, public procurement data can be distributed across disparate sources providing different level of detail and completeness, such as in public profiles of contracting authorities and central registers.
Fragmentation of procurement data requires further integration of data combined from distinct sources in order for the consumer to come to a unified view of the procurement domain that is necessary conducting data analyses.

Public procurement data also suffers from shortcomings similar to those of user-generated data. 
The users generating data for the public procurement registers usually comprise many contracting authorities. 
Each authority may produce data digressing from the mandated data standards in a different way.
Due to the distinct interpretations of the extent of mandatory and discretionary data by contracting authorities, the resulting aggregated dataset may appear to be incomplete.
Additionally, public procurement data is typically collected from forms filled out by people, who may inadvertently or purposely enter errors into the data they create.
A shortcoming of public procurement data that becomes apparent in data integration is the lack of global, agreed-upon and well-maintained identifier schemes for values of attributes of public contracts; such as the award criteria employed in the course of selecting the winning bid for a contract.
Coletta et al. claim that data integration is harder in the context of public sector data because important metadata is often missing ([2012](#Coletta2012)).
Fazekas discusses a similar set of issues of public procurement data from Hungary and highlights missing identifiers, imprecise links, and structural weaknesses ([Fazekas and Tóth, 2012](#Fazekas2012), p. 14).
A corollary of these issues is that tracking public contracts through the stages of their life-cycle, from their announcement over to completion, is difficult because of the lack of reliable identifiers.

<!-- TODO: Describe where does matchmaking fit in the public procurement process.
Information phase
-->

Matchmaking in public procurement can be framed in its legal and economic context.

### Legal context

We are focused on Czech public procurement, for which there are two primary sources of relevant law.
Public procurement in the Czech Republic is governed by the law no. 2016/134 ([Czech Republic, 2016](#CzechRepublic2016)).
Czech Republic, as a member state of the European Union, harmonises its law with EU directives, in particular the directives 2014/24/EU ([EU, 2014a](#EU2014a) and 2014/25/EU ([EU, 2014b](#EU2014b)) in the case of public procurement.
The law no. 2016/134 transposes these directives into the Czech legislation.
The aim of the EU's common regulatory framework is to build a single public procurement market spanning across the member states.

In particular, these documents form the legal basis for proactive disclosure of public procurement data.
standard forms for publishing public procurement data
Tenders Electronic Daily ('Supplement to the Official Journal') ^[<http://ted.europa.eu>]

<!-- Although the share of cross-country procurement is minimal. See <http://www.govtransparency.eu/wp-content/uploads/2016/03/Fazekas-Skuhrovec_OECD-Integrity-Forum_draft_160321_towebsite.pdf> -->

### Economic context

* Single market for cross-country public procurement: However, the public procurements markets in the EU member states are fragmented.
* Clientelism, collusion, bid rigging
* Economy of scale: due to the volume of public procurement, even minor improvements can have substantial impact

*"The estimate of total general government expenditures on works, goods, and services [...] represented 13.1 % of the EU GDP in 2015, the highest value for the last 4 years"* ([European Commission, 2016](#EuropeanCommission2016)).

Estimate of total general government expenditures on works, goods, and services (excluding utilities): 24.2 billion EUR in 2015 in the Czech Republic, which amounts for 14.5 % of the country's GDP ([European Commission, 2016](#EuropeanCommission2016))

![Percentage of public procurement's share of GDP](img/share_of_gdp_v2.png){width=75%}

Sources: Public Procurement Indicators 2015, 2014, 2013, 2012 ([European Commission, 2016](#EuropeanCommission2016)).

B2B context

Relevance of matchmaking based on procedure types:

* Open procedures: alerts to relevant bidders may be sent
<!--
Also for the first round of restricted procedures.
To a lesser extent also applicable with other procedure types, such as innovation partnership.
-->
* Closed procedures: contracting authority may be recommended suitable bidders to approach
  * A potential issue: A closed procedure is probably chosen when the contracting authority already knows which bidders to invite.
<!-- In case of simplified under limit procedure, contracting authority can directly approach bidders.
In that case, at least five bidders must be approached. (<https://www.zakonyprolidi.cz/cs/2016-134#p53>)
-->

<!--
- Contracting authorities are recommended to estimate contract price based on similar contract. This is a use case for similarity-based retrieval.
-->

From the perspective of recommendation systems:
* A strong desire for conformity, not deviating from the defaults, high risk-aversion <!-- TODO: Substantiate this claim. -->
  - An emphasis should be put on legal conformance (e.g., correctly evaluating award criteria).
  - Compliance to regulations
  - Desire for conformity may imply there is less propensity for diversity.
  - Awarding popular bidders may be perceived as a safe choice.
  - On the contrary, matchmaking may intentionally emphasize diversity to offset the desire for conformity.
* Civil servants are not motivated, so they behave like satisficers, searching for "good enough" solutions.

Public contracts are typically complex demands.
Complex representation, many latent features, many features unstructured (documentation), or not disclosed
Matchmaking has to operate on simplified models of public contracts.

<!--
Public procurement is an uncommon domain for recommender systems:
*"experiment designs that evaluate different algorithm variants on historical user ratings derived from the      movie domain form by far the most popular evaluation design and state of practice."* ([Jannach et al., 2010](#Jannach2010), p. 175)
-->
