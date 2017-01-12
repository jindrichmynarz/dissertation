## Public procurement domain

The domain of public procurement is suitable for matchmaking because, unlike many other domains, demands are made explicit in contract notices.
In many other domains only supply is explicitly described in advertising, while demand is left implicit.
Explicit formulation of demand allows us to process it automatically.
The explicit formulation is required by law to ensure a basic level of transparency and thus minimize corruption risks.

*"The estimate of total general government expenditures on works, goods, and services [...] represented 13.1 % of the EU GDP in 2015, the highest value for the last 4 years"* ([European Commission, 2016](#EuropeanCommission2016)).

Estimate of total general government expenditures on works, goods, and services (excluding utilities): 24.2 billion EUR in 2015 in the Czech Republic, which amounts for 14.5 % of the country's GDP ([European Commission, 2016](#EuropeanCommission2016))

Problems of transparency:

- Matchmaking will be used only by willing civil servants.
- Corruption scandals are ignored and eventually forgotten by the public.

Legal basis of proactive disclosure of public procurement data.

EU's common regulatory framework
to produce a single public procurement market <!-- Although the share of cross-country procurement is minimal. See <http://www.govtransparency.eu/wp-content/uploads/2016/03/Fazekas-Skuhrovec_OECD-Integrity-Forum_draft_160321_towebsite.pdf> -->
<!-- TODO: Work through the relevant EU directives and Czech law. -->

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

The impact of imperfect standardisation of public procurement data can be ameliorated by applying data integration methods.
The presented paper covers an incremental, pay-as-you-go approach to data integration supported by methods based on linked data and the semantic web technologies.
It offers a workflow for data integration that consists of operations including schema alignment, data translation, entity reconciliation, and data fusion.
Unlike traditional integration efforts, this approach sidelines low-level technical aspects of data integration, such as syntactic or structural heterogeneity, and thus puts emphasis on higher-level issues, such as agreement on canonical data, and establishes a cleaner separation of concerns attended to in the data integration process.
This paper explores an application of the described approach to data integration built on linked data principles to the domain of public procurement data.
As the paper progresses through the individual steps of the integration workflow it highlights the key concerns and proposes solutions based on linked data to address these concerns.
The discussed data integration methods are illustrated on a running example describing integration of Czech public procurement data.

Public procurement data also suffers from shortcomings similar to those of user-generated data. 
The users generating data for the public procurement registers usually comprise many contracting authorities. 
Each authority may produce data digressing from the mandated data standards in a different way.
Due to the distinct interpretations of the extent of mandatory and discretionary data by contracting authorities, the resulting aggregated dataset may appear to be incomplete.
Additionally, public procurement data is typically collected from forms filled out by people, who may inadvertently or purposely enter errors into the data they create.
A shortcoming of public procurement data that becomes apparent in data integration is the lack of global, agreed-upon and well-maintained identifier schemes for values of attributes of public contracts; such as the award criteria employed in the course of selecting the winning bid for a contract.
Coletta et al. claim that data integration is harder in the context of public sector data because important metadata is often missing ([2012](#Coletta2012)).
Fazekas discusses a similar set of issues of public procurement data from Hungary and highlights missing identifiers, imprecise links, and structural weaknesses ([Fazekas and Tóth, 2012](#Fazekas2012), p. 14).
A corollary of these issues is that tracking public contracts through the stages of their life-cycle, from their announcement over to completion, is difficult because of the lack of reliable identifiers.
