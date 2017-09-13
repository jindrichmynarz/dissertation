## Public procurement domain {#sec:public-procurement}

Our work targets the domain of public procurement.
In particular, we apply our developed method on the Czech public procurement.
Public procurement is the process by which public bodies purchase products or services from companies.
Public bodies make such purchases in public interest in order to pursue their mission.
For example, it can be used to procure road repairs or arrange supplies of electricity.
Bodies issuing public contracts, such as ministries or municipalities, are referred to as contracting authorities.
Companies competing for contract award are called bidders.
Since public procurement is a legal domain, public contracts are legally enforceable agreements on such purchases financed from public funds.
Public contracts are publicized and monitored by contract notices.
Contract notices announce competitive bidding for the award of public contracts [@Distinto2016, p. 14] and update the progress of public contracts as they go through their life cycle, ending either in completion or cancellation.
In our case we deal with public contracts that can be described more precisely as proposed contracts [@Distinto2016, p. 14] until they are awarded and agreements with suppliers are signed.
We use the term "public contract" as a conceptual shortcut to denote the whole contract's life-cycle.

Public procurement is an uncommon domain for recommender and matchmaking systems.
Recommender systems are conventionally used in domains such as books, movies, or music.
In fact, the *"experiment designs that evaluate different algorithm variants on historical user ratings derived from the movie domain form by far the most popular evaluation design and state of practice"* [@Jannach2010, p. 175].
Our use case thereby constitutes a novel application of these technologies.

Matchmaking in public procurement can be framed in its legal and economic context.

### Legal context {#sec:legal-context}

Public procurement is a domain governed by law.
We are focused on Czech public procurement, for which there are two primary sources of relevant law.
Public procurement in the Czech Republic is governed by the law no. 2016/134 [@CzechRepublic2016].
Czech Republic, as a member state of the European Union, harmonises its law with EU directives, in particular the directives 2014/24/EU [@EU2014a] and 2014/25/EU [@EU2014b] in the case of public procurement.
The first directive regulates public procurement of works, supplies, or services, while the latter one regulates public procurement of utilities, including water, energy, transport, and postal services.
The law no. 2016/134 transposes these directives into the Czech legislation.
Besides legal terms and conditions to harmonize public procurement in the EU member states these directives also define standard forms for EU public procurement notices,^[<http://simap.ted.europa.eu/web/simap/standard-forms-for-public-procurement>] which constitute a common schema of public notices.
The directives design Tenders Electronic Daily ("Supplement to the Official Journal")^[<http://ted.europa.eu>] to serve as the central repository of public notices conforming to the standard forms.

In an even broader context, the EU member states adhere to the Agreement on Government Procurement (GPA)^[<https://www.wto.org/english/tratop_e/gproc_e/gp_gpa_e.htm>] set up by the World Trade Organization.
GPA mandates the involved parties to observe rules of fair, transparent, and non-discriminatory public procurement.
In this way the agreement sets basic expectations facilitating international public procurement.

Legal regulation of public procurement has important implications for matchmaking, including explicit formulation of demands, their proactive disclosure, desire for conformity, and standardization.
Public procurement law requires explicit formulation of demands in contract notices to ensure a basic level of transparency.
In most markets only supply is described explicitly, such as through advertising, while demand is left implicit.
Since matchmaking requires demands to be specified, public procurement makes for a suitable market to apply the matchmaking methods.

<!-- Complex representation -->

Since public procurement often pursues multiple objectives, public contracts are demands with variable degrees of complexity and completeness.
Their explicit formulation thus requires sufficiently expressive modelling, which makes it a suitable use case for semantic web technologies, including RDF and RDF Schema.
Public contracts may stipulate non-negotiable qualification criteria as well as setting desired qualities in bidders.
The objects of public contracts are often heterogeneous products or services, that cannot be described only in terms of price.
Apart from their complex representation, public contracts have many features unavailable as structured data.
These features comprise unstructured documentation or undisclosed terms and conditions.
Consequently, matchmaking has to operate on simplified models of public contracts.
The data model for public contracts we designed is described in [@sec:modelling].

<!-- Proactive disclosure -->

Moreover, there is a legal mandate for proactive disclosure of contract notices.
Public contracts that meet prescribed minimum conditions, including thresholds for money spent, must be advertised publicly [@Graux2012, p. 7].
Since public contracts in the EU are classified as public sector information, they fall within the regime of mandatory public disclosure under the terms of the Directive on the re-use of public sector information [@EU2013].
This provides equal access to contract notices for all members of the public without the need to make requests for the notices, which in turn helps to enable fair competition in the public procurement market.

<!-- Desire for conformity -->

Public procurement is subject to stringent and complex legal regulations.
Civil servants responsible for public procurement therefore put a strong emphasis on legal conformance. <!-- TODO: Substantiate this claim. -->
For example, it is important to evaluate award criteria correctly to avoid protracted appeals of unsuccessful bidders.
Consequently, public officials in this domain exhibit high risk-aversion and desire for conformity.
For instance, this is why not deviating from defaults or awarding popular bidders may be perceived as a safe choice.
In effect, desire for conformity may imply there is less propensity for diversity in recommendations produced via matchmaking.
On the one hand, matchmaking may address this by trading in improved accuracy for diversity in matchmaking results.
On the other hand, it may intentionally emphasize diversity to offset the desire for conformity.
Qualitative evaluation via interviews with civil servants may potentially indicate which direction is preferable.

<!-- Standardization -->

Finally, legal regulations standardize the communication in public procurement.
Besides prescribing procedures that standardize how participants in public procurement communicate, it standardizes the messages exchanged between the participants.
Contracting authorities have to disclose public procurement data following the structure of standard forms for contract notices.
The way in which public contracts are described in these forms is standardized to some degree via shared vocabularies and code lists, such as the Common Procurement Vocabulary (CPV) or the Nomenclature of Territorial Units for Statistics (NUTS).
Standardization is especially relevant in the public sector, since it is characterized by *"a variety of information, of variable granularity and quality created by different institutions and represented in heterogeneous formats"* [@Euzenat2013, p. 12].

Standardization of data contributes to defragmentation of the public procurement market.
Defragmentation of the EU member states' markets is the prime goal of the EU's common regulatory framework.
It aims to create a single public procurement market that enables cross-country procurement among the member states.
Standardization simplifies reuse of public procurement data by third parties, such as businesses or supervisory public bodies.
Better reuse of data balances the information asymmetries that fragment the public procurement market.

<!-- Imperfect standardization -->

Nevertheless, public procurement data is subject to imperfect standardization, which introduces variety in the data.
The imperfect standardization is caused by divergent transposition of EU directives into legal regimes of EU member states, lack of adherence to standards, underspecified standards leaving open space for inconsistencies, or meagre incentives and sanctions for abiding by the standards and prescribed practices.
Violations of the prescribed schema, lacking data validation, and absent enforcement of the mandated practices of public disclosure require a large effort from those wanting to make effective use of the data.
For example, tasks such as search in aggregated data or establishing identity of economic operators suffer from data inconsistency.
Moreover, public procurement data can be distributed across disparate sources providing varying level of detail and completeness, such as in public profiles of contracting authorities and central registers.
Fragmentation of public procurement data thus requires further data integration in order for the consumer to come to a unified view of the procurement domain that is necessary conducting data analyses.
In fact, one of the reasons why the public procurement market is dominated by large companies may be that they, unlike small and medium-sized enterprises, can afford the friction in processing the data.

According to our approach to data preparation, linked data provides a way to compensate the impact of imperfect standardization.
While a standard can be defined as *"coordination mechanism around non-proprietary knowledge that organizes and directs technological change"* [@Gosain2003, p. 18], linked data enables to cope with insufficient standardization by allowing for *"cooperation without coordination"* [@Wood2011, p. 5] or centralization.
Instead, linked data allows to bridge local heterogeneities via the flexible data model of RDF and explicit links between decentralized data sources.
We describe our use of linked data in detail in [@sec:data-preparation].

### Economic context

Public procurement constitutes a large share of the volume of transactions in the economy.
The share of government expenditures in public procurement on works, goods, and services (excluding utilities) was estimated to be *"13.1 % of the EU GDP in 2015, the highest value for the last 4 years"* [@EuropeanCommission2016].
This estimate amounted to 24.2 billion EUR in 2015 in the Czech Republic, which corresponded with 14.5 % of the country's GDP [@EuropeanCommission2016].
Compared with the EU, Czech Republic exhibits consistent above-average values of this indicator, as can be seen in [@fig:gdp].

![Percentage of public procurement's share of GDP. Source: Public Procurement Indicators 2012-2015 [@EuropeanCommission2016]](img/share_of_gdp_v2.png){#fig:gdp}

<!-- Economy of scale -->

The large volume of transactions in public procurement gives rise to economies of scale, so that even minor improvements can accrue substantial economic impact, since the scale of operations in this domain provides ample opportunity for cost savings.
Publishing open data on public procurement as well as using our matchmaking methods can be considered among the examples of such improvements, which can potentially increase the efficiency of resource allocation in the public sector, as mentioned in the [@sec:open-data].

<!-- Passive waste -->

Due to the volume of the public funds involved in public procurement, it is prone to waste and political graft.
Wasteful spending in public procurement can be either classified as active waste, which entails benefits to the public decision maker, or passive waste, which does not benefit the decision maker.
Whereas active waste may result from corruption or clientelism, passive waste proceeds from inefficiencies caused by lack of skills or incentives.
While active waste is widely perceived as the main problem of public procurement, a study of the Italian public sector [@Bandiera2009, p. 1282] observed that 83 % of uneconomic spending in public procurement can be attributed to passive waste.
We therefore decided to focus on optimizing public procurement where most impact can be expected.
Matchmaking can help improve the public procurement processes to cut down passive waste. 
It can assist civil servants by providing relevant information, thus reducing the decision-making effort related to public procurement processes.
<!--
Moreover, communication protocols can reduce corruption potential.
In particular, protocols that automate interactions between contracting authorities and bidders leave less leeway.
For instance, *"automatic matching services can find suitable pairs for a resource transfer.
The transfer itself can be mediated by a protocol, reducing human interaction to a necessary minimum."*^[<https://sat.researchstudio.at/en/web-of-needs>]
On the other hand, automation may be corrupted too.
-->
We identified several use cases where matchmaking can help.

### Use cases for matchmaking

Matchmaking covers the information phase of market transaction [@Schmid1998, p. 194] that corresponds to the preparation and tendering stages in public procurement life-cycle [@Necasky2014, p. 865].
During this phase *"participants to the market seek potential partners"* [@DiNoia2004], so that public bodies learn about relevant bidders and companies learn about relevant open calls.
In this sense, demands for products and services correspond to information needs and the aim of matchmaking is to retrieve the information that will satisfy them.
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
Moreover, in case of the simplified under limit procedure, which is allowed for public contracts below a specified financial threshold, contracting authority can approach bidders directly.
In such case, at least five bidders must be approached according to the law no. 2016/134 [@CzechRepublic2016]. <!-- <https://www.zakonyprolidi.cz/cs/2016-134#p53> -->
In that scenario, matchmaking can help recommend appropriate bidders to interest in the public contract.
There are also other procedure types, such as innovation partnership, in which matchmaking is applicable to a lesser extent.

An additional use case for similarity-based retrieval during contract specification.
The Czech law no. 2016/134 [@CzechRepublic2016] suggests contracting authorities to estimate contract price based on similar contracts. <!-- <https://www.zakonyprolidi.cz/cs/2016-134#f5805154> -->
In order to address this use case, matchmaking can recommend similar contracts based on the incomplete description of the specified contract.

<!--
A particular feature of public procurement is that it is a domain where interests of public and private sector   meet.
It is a domain situated at the intersection of the public and private sector where different motivations overlap.
Public contracts constitute a specific case of demand that represents public interest, while the side of supplies is driven by private interests.

Problems of transparency:

- Matchmaking will be used only by willing civil servants.
- Corruption scandals are ignored and eventually forgotten by the public.

B2B context: although contracting authorities are not necessarily typical "businesses"

Although the share of cross-country procurement is minimal. See <http://www.govtransparency.eu/wp-content/uploads/2016/03/Fazekas-Skuhrovec_OECD-Integrity-Forum_draft_160321_towebsite.pdf>

* Single market for cross-country public procurement: However, the public procurements markets in the EU member states are fragmented.
* Clientelism, collusion, bid rigging: contributes to fragmentation of the public procurement market

Civil servants are not motivated, so they behave like satisficers, searching for "good enough" solutions.
-->
