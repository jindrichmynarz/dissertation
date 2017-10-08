### RESCAL-based matchmakers {#sec:loading-rescal}

The RESCAL-based matchmakers operate on tensors.
Tensors are multidimensional arrays typically used to represent multi-relational data.
The number of dimensions of a tensor, also known as ways or modes [@Kolda2009], is referred to as its order.
Tensors usually denote the higher-order arrays: first-order tensors are vectors and second-order tensors are matrices.

<!--
Further formalization of tensors (add if needed for the further explanations):

- Don't use "rank", since it is also used for the number of rows of the latent factor matrix $A$ (and the dimensions of the latent factor tensor $\mathcal{R}$).

$\mathcal{X}_{k}$ is a $k$-th frontal slice of tensor $\mathcal{X}$

Third-order tensor $\mathcal{X} \in \mathbb{R}^{I \times J \times K}$.

Adjacency tensors
Slices: two-dimensional subarrays/sections of tensors (i.e. matrices)
- Frontal slices of tensors correspond to adjacency matrices of given predicates.
  - $\mathcal{X}_{::k}$
  - There are horizontal, lateral, and frontal slices.
Fibers: one-dimensional subarrays of tensors (i.e. vectors)
- Fibers fix all tensor indices but one.
-->

<!-- Tensor representation of RDF -->

Higher-order tensors provide a simple way to model multi-relational data, such as RDF.
Since RDF predicates are binary relations, RDF data can be represented as a third-order tensor, in which two modes represent RDF resources in a domain and the third mode represents relation types; i.e. RDF predicates [@Tresp2014].
The two modes are formed by concatenating the subjects and objects in RDF data.
The mode-3 slices of such tensors, also referred to as frontal slices, are square adjacency matrices that encode the existence of relation $R_{k}$ between RDF resources $E_{i}$ and $E_{j}$, as depicted in [Fig. @fig:third-order-tensor]. <!-- _b -->
Consequently, RDF can be modelled as $n \times n \times m$ tensor $\mathcal{X}$, where $n$ is the number of entities and $m$ is the number of relations.
If the $i$^th^ entity is related by the $k$^th^ predicate to the $j$^th^ entity, then the tensor entry $\mathcal{X}_{ijk} = 1$.
Otherwise, if such relation is missing or unknown, the tensor entry is zero.

![Frontal slices of a third-order tensor, adopted from @Nickel2011](resources/img/third_order_tensor.png){#fig:third-order-tensor width=50%}

There are a couple of things to note about tensors representing RDF data.
Entities in these tensors are not assumed to be homogeneous.
Instead, they may instantiate different classes.
Moreover, no distinction between ontological and instance relations is maintained, so that both classes and instances are modelled as entities.
In this way, *"ontologies are handled like soft constraints, meaning that the additional information present in an ontology guides the factorization to semantically more reasonable results"* [@Nickel2012, p. 273].
Tensors representing RDF are usually very sparse due to high dimensionality and incompleteness, calling in for algorithms that leverage their sparseness for efficient execution, in particular for large data.
Scalable processing of large RDF datasets in the tensor form is thus a challenge for optimization techniques.
Interestingly, unlike RDF, tensors can represent n-ary relations without decomposing them into binary relations.
What would in RDF require reification or named graphs can be captured with greater tensor order.
This presents an opportunity for more expressive modelling outside of the boundaries of RDF.

We developed *sparql-to-tensor*, described in [Section @sec:sparql-to-tensor], to export RDF data from a SPARQL endpoint to the tensor form.
The transformation is defined by SPARQL SELECT queries given to this export tool. 
Each query retrieves data for one or more RDF properties that constitute the relations in the output tensor.
During the evaluation, we created and tested many tensors, each combining different properties and ways of pre-processing.

In most cases the retrieved relations corresponded to explicit RDF properties found in the source data.
However, in a few select cases we constructed new relations.
This was done either to avoid intermediate resources, such as tenders relating awarded bidders or proxy concepts relating unqualified CPV concepts, or to relate numeric values discretized to intervals.
Since the original RESCAL algorithm does not support continuous variables, we discretized such variables via *discretize-sparql*, which is covered in [Section @sec:discretize-sparql].
We applied discretization to the actual prices of contracts, which we split into 15 equifrequent intervals having approximately the same number of members.

Apart from binary numbers as tensor entries we used float numbers $\mathcal{X}_{ijk} \in \mathbb{R} \colon 0 \leq \mathcal{X}_{ijk} \leq 1$ to distinguish the degrees of importance of relations.
Float entries were used to de-emphasize less descriptive RDF properties, such as `pc:additionalObject`, or to model information loss from ageing, so that older contract awards bear less relevance than newer ones.
We reused the ageing function from [@Kuchar2016, p. 212] to compute the tensor entries:

$$\mathcal{A}(t_{0}) = \mathcal{A}(t_{x}) \cdot e^{-\lambda t}; t_{0} > t_{x}, t = t_{0} - t_{x}$$

In this function *"$\mathcal{A}(t_{0})$ is the amount of information at the time $t_{0}$. $\mathcal{A}(t_{x})$ is the amount of information at the time $t_{x}$ when the information was created, $\lambda$ is ageing/retention factor and $t$ is the age of the information."*
We assume $\mathcal{A}(t_{x})$ to be equal to 1, the same value used for relations encoded without ageing.
Since our dataset covers a period of 10 years, we use $\lambda = 0.005$ that provides a distribution of values spanning approximately over this period.
We used contract awards dates as values of $t_{x}$ and the latest award date as $t_{0}$.
Award dates were unknown for the 2.3 % of contracts, for which we used the median value of the known award dates.
The ageing function was implemented in a SPARQL SELECT query.
Since the required natural exponential function is not natively supported in SPARQL, we used the extension function `exp()`^[<http://docs.openlinksw.com/virtuoso/fn_exp>] built in the Virtuoso RDF store to compute it.

<!-- Feature selection

`:awardedBidder` (i.e. pc:awardedTender/pc:bidder, weighted by pc:awardDate)
`pc:mainObject`
`pc:additionalObject`
`skos:closeMatch`
`skos:related`
`skos:broaderTransitive`
`rov:orgActivity`
-->

Instead of exporting all RDF data to the tensor format, we selected few features from it that we deemed to be the most informative.
There are 76 different relations in the Czech public procurement dataset in total.
Even more relations are available if we add the linked data.
We experimented with selecting individual relations as well as their combinations to find out which ones produce the best results.
We guided this search by the assumption that the contributions of the individual relations do not cancel themselves out.
