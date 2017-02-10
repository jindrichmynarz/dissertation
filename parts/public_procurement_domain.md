## Public procurement domain

Our target domain is public procurement.
The use case to apply the developed methods focuses on the Czech public procurement.

<!--
Definitions:
* What is a public contract?
* What is public procurement?
  * "Public procurement is the process for awarding contracts for the purchase of goods and services by the public authorities."
* What is a contracting authority? A public body issuing a public contract.
* Who is a bidder?
-->

A particular feature of public procurement is that it is a domain where interests of public and private sector   meet.

* An interface between public and private sector, different motivations

<!--
Explicit formulation of demands
Legal mandate for proactive disclosure
-->

The domain of public procurement is suitable for matchmaking because, unlike many other domains, demands are made explicit in contract notices.
In many other domains only supply is explicitly described in advertising, while demand is left implicit.
Explicit formulation of demand allows us to process it automatically.
The explicit formulation is required by law to ensure a basic level of transparency and thus minimize corruption risks.

Public contracts constitute a specific case of demand that represents public interest, while the side of supplies is driven by private interests.

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

Matchmaking covers the information phase of market transaction ([Schmid, Lindemann, 1998, p. 194](#Schmid1998)) that corresponds to the preparation and tendering stages in public procurement life-cycle ([Nečaský et al., 2014, p. 865](#Necasky2014)), during which public bodies learn about relevant suppliers and companies learn about relevant open calls.

To frame matchmaking within the process of demand meeting supply, it occurs during the information phase, in which *"participants to the market seek potential partners"* ([Di Noia et al., 2004](#DiNoia2004)).
In this sense, demands for products and services correspond to information needs and the aim of matchmaking is to retrieve the information that will satisfy them.

Matchmaking in public procurement can be framed in its legal and economic context.

### Legal context

We are focused on Czech public procurement, for which there are two primary sources of relevant law.
Public procurement in the Czech Republic is governed by the law no. 2016/134 ([Czech Republic, 2016](#CzechRepublic2016)).
Czech Republic, as a member state of the European Union, harmonises its law with EU directives, in particular the directives 2014/24/EU ([EU, 2014a](#EU2014a) and 2014/25/EU ([EU, 2014b](#EU2014b)) in the case of public procurement.
The law no. 2016/134 transposes these directives into the Czech legislation.
The aim of the EU's common regulatory framework is to build a single public procurement market spanning across the member states.

In particular, these documents form the legal basis for proactive disclosure of public procurement data.
standard forms for publishing public procurement data
Tenders Electronic Daily ("Supplement to the Official Journal")^[<http://ted.europa.eu>]

### Economic context

<!-- Economy of scale -->

* Economy of scale: due to the volume of public procurement, even minor improvements can have substantial impact
The large volume of transactions in this domain gives rise to economies of scale, so that even minuscule improvements of public procurement processes can have a substantial impact.
As an instance of such improvement, the matchmaking method presented in this paper may potentially increase the efficiency of resource allocation in the public sector.
The promises of economic impact are particularly relevant for public procurement where the scale of operations provides ample opportunity for cost savings.

*"The estimate of total general government expenditures on works, goods, and services [...] represented 13.1 % of the EU GDP in 2015, the highest value for the last 4 years"* ([European Commission, 2016](#EuropeanCommission2016)).

Estimate of total general government expenditures on works, goods, and services (excluding utilities): 24.2 billion EUR in 2015 in the Czech Republic, which amounts for 14.5 % of the country's GDP ([European Commission, 2016](#EuropeanCommission2016))

![Percentage of public procurement's share of GDP](img/share_of_gdp_v2.png){width=75%}

Sources: Public Procurement Indicators 2015, 2014, 2013, 2012 ([European Commission, 2016](#EuropeanCommission2016)).

<!-- Passive waste -->

Improving the effective allocation of public sector resources in public procurement. (Improving government's decision making) <!-- Link to the previous discussion in the section on open data. -->
Goal: efficiency - reducing the decision-making effort.
Automation of parts of the public procurement process

Active waste: entails benefit to public decision maker
Passive waste: passive waste proceeding from ineffieciencies dominates over active waste

This affects not only the active waste with public resources that is often caused by corruption or clientelism.
A study of the Italian public sector ([Bandiera, Prat, Valletti, 2009, p. 1282](#Bandiera2009)) observed that 83 % of inefficient spending in public procurement is due to passive waste that does not entail any benefit for the public decision-maker, and which is caused rather by a lack of skills or incentives.
Releasing public procurement data also makes it possible to build applications on the data that assist contracting authorities to avoid passive waste and improve the quality of their decisions.

<!-- Defragmentation of the public procurement market -->

Defragmentation of data on contracting authority profiles
- Creating a single market across the EU member states
Better access to public procurement for SMEs, since the market is dominated by large companies, who can afford the friction.
* Single market for cross-country public procurement: However, the public procurements markets in the EU member states are fragmented.
* Clientelism, collusion, bid rigging: contributes to fragmentation of the public procurement market

<!-- Although the share of cross-country procurement is minimal. See <http://www.govtransparency.eu/wp-content/uploads/2016/03/Fazekas-Skuhrovec_OECD-Integrity-Forum_draft_160321_towebsite.pdf> -->

B2B context

### Use cases for matchmaking

Several use cases for matchmaking follow from the public procurement legislation according to the procedure types chosen for public contracts.
Public procurement law defines types of procedures that govern how contracting authorities communicate with bidders.
In particular, procedure types determine what data on public contracts is published, along with specifying who has access to it and when it needs to be made available.
The main procedure types are either open or restricted.
Open procedure mandates contracting authorities to disclose data on contracts publicly, so that any bidders can respond with an offer.
In this case, contracting authorities do not negotiate with bidders and contracts are awarded solely based on the received bids.
Restricted procedure differs by an extra screening step.
As in open procedure, contracting authorities announce contracts publicly, but bidders respond with expression of interest instead of bids.
Contracting authorities then screen the interested bidders and send invitation to tender to the selected bidders.

The chosen procedure type determines for which users is matchmaking relevant.
Bidders can use matchmaking both in case of open and restricted procedures to be alerted about current business opportunities in public procurement that are relevant for them.
Contracting authorities can use matchmaking in restricted procedure to get recommendations of suitable bidders.
<!-- A potential issue: A restricted procedure is probably chosen when the contracting authority already knows which bidders to invite. -->
Moreover, in case of the simplified under limit procedure, which is allowed for public contracts below a specified financial threshold, contracting authoritiy can approach bidders directly.
In such case, at least five bidders must be approached according to the law no. 2016/134. <!-- <https://www.zakonyprolidi.cz/cs/2016-134#p53> -->
In that scenario, matchmaking can help recommend appropriate bidders to interest in the public contract.
There are also other procedure types, such as innovation partnership, in which matchmaking is applicable to a lesser extent.

Additionally, a use case for similarity-based retrieval during contract specification.
The Czech law no. 2016/134 suggests contracting authorities to estimate contract price based on similar contracts. <!-- <https://www.zakonyprolidi.cz/cs/2016-134#f5805154> -->
In order to address this use case, matchmaking can recommend similar contracts based on the incomplete description of the specified contract.

<!-- Diversity vs. conformity -->

From the perspective of recommendation systems:
* A strong desire for conformity, not deviating from the defaults, high risk-aversion <!-- TODO: Substantiate this claim. -->
  - An emphasis should be put on legal conformance (e.g., correctly evaluating award criteria).
  - Compliance to regulations
  - Desire for conformity may imply there is less propensity for diversity.
  - Awarding popular bidders may be perceived as a safe choice.
  - On the contrary, matchmaking may intentionally emphasize diversity to offset the desire for conformity.
* Civil servants are not motivated, so they behave like satisficers, searching for "good enough" solutions.

<!-- Complex representation -->

Public contracts are typically complex demands.
They may stipulate non-negotiable qualification criteria as well as setting desired qualities in bidders.
Apart from their complex representation, public contracts have many features unavailable as structured data.
These features comprise unstructured documentation or undisclosed terms and conditions.
Matchmaking has to operate on simplified models of public contracts.
The data model for public contracts we designed is described in the section on [modelling](#modelling).

<!-- Uncommon domain -->

Public procurement is an uncommon domain for recommender systems.
Recommender systems are conventionally used in domains such as books, movies, or music.
In fact, the *"experiment designs that evaluate different algorithm variants on historical user ratings derived from the movie domain form by far the most popular evaluation design and state of practice"* ([Jannach et al., 2010](#Jannach2010), p. 175).
Our use case is thereby a novel application of recommender systems.
