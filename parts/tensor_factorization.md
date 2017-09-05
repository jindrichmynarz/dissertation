## Tensor factorization

<!--
TODO: Re-read:
- <https://pdfs.semanticscholar.org/c971/32a582efacd84d6550ad8107d1ad9a83a88e.pdf>
- <http://machinelearning.wustl.edu/mlpapers/paper_files/ICML2011Nickel_438.pdf>
- <https://pdfs.semanticscholar.org/498c/a0a1f8c980586408addf7ab2919ecdb7dd3d.pdf>
- <https://pdfs.semanticscholar.org/308b/f5b1b6cd5c2124d7589945f715b0adc7b8f8.pdf>
-->

Tensors are multidimensional arrays.

### Tensor representation of RDF

Tensors provide a simple way to model multi-relational data, such as RDF.
RDF data can represented as a third-order tensor.
Each slice of the tensor corresponds to a relation.
The slices are square adjacency matrices that encode existence or degree of their relation between entities in the tensor.

Tensors representing RDF data are usually very sparse, calling for algorithms that leverage sparsity for efficient execution.

Since RDF predicates are binary relations, they can be represented as adjacency matrices encoding what RDF resources are related by a given RDF predicate.

Two modes represent entities in a domain and the third mode represents the relation type [@Tresp2014].

<!--
First-order tensors are vectors, second-order tensors are matrices.

Tensor order (also known as tensor degree or tensor rank or tensor way)
- Don't use "rank", since it is also used for the number of rows of the latent factor matrix $A$ (and the dimensions of the latent factor tensor $\mathcal{R}$).
N-th order tensor has N dimensions.
*"The order of a tensor is the number of dimensions, also known as ways or modes."* [@Kolda2009]

RDF data can be represented as a third-order tensor.
Third-order tensor $\mathcal{X} \in \mathbb{R}^{I \times J \times K}$.
Three-way tensor = third order tensor

Unlike RDF, tensors can represent higher-order relations.

Tensors provide a modelling simplicity: multiple relations can be represented in a higher-order tensor.
A natural way to represent multi-graphs is to use adjacency tensors.
Adjacency tensors
Slices: two-dimensional subarrays/sections of tensors (i.e. matrices)
- Mode-3 slices are referred to as frontal slices (in a third-order tensor)
- Frontal slices of tensors correspond to adjacency matrices of given predicates.
  - $\mathcal{X}_{::k}$
  - There are horizontal, lateral, and frontal slices.
Fibers: one-dimensional subarrays of tensors (i.e. vectors)
- Fibers fix all tensor indices but one.

Two modes of a three-way tensors are formed by concatenating dataset's entities (subjects and objects).
Entities are not assumed to be homogeneous. Instead, they may instantiate different classes.
The third mode represents the relation types (i.e. predicates).
$n \times n \time m$ tensor $\mathcal_{X}$. $n$ is the number of entities, $m$ is the number of relations.

Can we say that tensors are a representational formalism for statistical relational learning?

Tensors balance expressiveness with complexity of their model. (How?)

No distinction between ontological and instance relations is maintained.
In this way, ontologies are handled as soft constraints [@Nickel2013a, p. 66].
The model of RDF data does not draw a distinction between terminological and instance data (TBox and ABox).
Both classes and instances are modelled as entities.
*"ontologies are handled like soft constraints, meaning that the additional information present in an ontology guides the factorization to semantically more reasonable results"* [@Nickel2012, p. 273]
-->

### Tensor factorization

Tensor factorization is based on the assumption that there exists a low-dimensional representation of the entities in tensors.

<!--
low-rank factorization
*"The rank of a tensor $\mathcal{X}$, denoted as $rank(\mathcal{X})$, is defined as the smallest number of rank one tensors that generate $\mathcal{X}$ as their sum."* [@Kolda2009]

FIXME: Clarify when "tensor factorization" means a method and when its result. We should probably use "tensor decomposition" for the result (and define it explicitly).

Tensor factorizations generalizes matrix factorization.
decomposition into a product of two or more simpler tensors or matrices

Tensor factorization has applications in many domains, such as chemometrics or mining of social networks.

Theoretical generalization of the abilities of tensor factorization is in @Nickel2013b.
decompositions are possible because most tensors have latent structure

Tensor factorization is inefficient if data contains a lot of strongly connected graph components.
Decomposition addresses high dimensionality and sparsity.

tensor decompositions for learning latent variable models
matrices $R$ are low-rank matrix approximations

numpy.dot implements the matrix product (i.e. sum of rows times columns)

Dealing with the noise in the data
Perspective of probabilistic databases

Hybrid approaches combining multiple methods
- E.g., re-ranking

Latent factors

Traditional methods for statistical relational learning, such as Markov logic networks, suffer from poor scalability.
Tensor factorization was shown to scale well.
-->

### RESCAL

RESCAL is a machine learning algorithm for factorization of third-order tensors.

frontal slice $X_{k}$ of $\mathcal{X}$:

$X_{k} \approx AR_{k}A^{T}$

![RESCAL factorization from @Nickel2012](img/rescal_factorization.png){#fig:rescal-factorization}

@Nickel2011, @Nickel2012, @Zhiltsov2013

<!--
RESCAL was introduced in @Nickel2011.
It is a method based on factorization of a three-way tensor.
RESCAL does not require strict feature modelling.
RESCAL is a supervised machine learning method.
RESCAL exploits idiosyncratic properties of relational data.
It is able to use contextual data more distant in the relational graph. (=> collective learning)
RESCAL achieves leading performance for link prediction tasks.
RESCAL *"explains triples via pairwise interactions of latent features"* [@Nickel2016, p. 17]
RESCAL may be used to generate similarities between entities that may be then used in non-relational methods.
RESCAL was shown to be superior for link prediction tasks on two datasets. Nevertheless, what is the best machine learning method remains dataset-specific.

*"The main advantage of RESCAL, if compared to other tensor factorizations, is that it can exploit a collective learning effect when applied to relational data."* [@Nickel2012, p. 272]
@Nickel2012 shows how the execution of RESCAL can be parallelized and distributed across multiple computing nodes.
RESCAL adopts a closed world assumption: *"RESCAL approaches the problem of learning from positive examples only, by assuming that missing triples are very likely not true, an approach that makes sense in a high-dimensional but sparse domain."* [@Nickel2012, p. 273]
*"RESCAL can be regarded as a latent-variable model for multi-relational data"* [@Nickel2012, p. 273]
Collective learning via latent components of the factorization.
- enables learning long-range dependencies

Latent variables in RESCAL do not describe entity classes but are latent entity factors [@Tresp2014].

RESCAL scales better to large data than many similar approaches.

RESCAL is also fundamentally simpler than other tensor factorization methods. 
Unlike similar algorithms, RESCAL stands out by low Kolmogorov complexity.
It is implemented only in 120 lines of code of Python [@Nickel2011] using only the NumPy^[<http://www.numpy.org>] library.

**Comparison with matrix factorization**

RESCAL is similar to matrix factorization (MF) methods used in recommender systems [@Nickel2016, p. 18].
MF offers good scalability, predictive accuracy, and modelling flexibility [@Koren2009, p. 44].
MF allows to incorporate both explicit and implicit feedback.
However, reshaping tensors into matrices causes data loss.

RESCAL uses unique latent representation of entities as subjects and objects, which enables efficient information propagation to capture correlations over relational chains [@Nickel2013c, p. 619].

*"tensor (and matrix) rank is a central parameter of factorization methods that determines generalization        ability as well as scalability"* [@Nickel2014].

Extensions of RESCAL:

- [@Zhiltsov2013]
- Type constraints: [@Chang2014], [@Krompass2014], [@Krompass2015]
  - Improving RESCAL by removing type-incompatible (`rdfs:domain`, `rdfs:range`, age1 < age2) predictions.
  - *"We argue that, especially for larger datasets, the required      increase of model complexity will lead to an avoidable high runtime and memory consumption."* [@Krompass2014]
  - RESCAL is faster than the type-constrained approach if using the same rank. However, the type-constrained approach typically requires lower rank to produce results that RESCAL is able of producing only at higher ranks.
  - The constraints allow to use a lower rank of the latent factor matrix.
  - Type constraints in [@Krompass2014] are represented as binary matrices.
- Time-aware link prediction [@Kuchar2016].
  - Weighting by time from award date to model decay of usefulness of older contract awards.
- [@Padia2016] enhances RESCAL with tensor slice similarity.
-->

<!--
### Feature selection

There is a need to balance the expressiveness of the latent features with the runtime of tensor factorization.

`:awardedBidder` (i.e. pc:awardedTender/pc:bidder, weighted by pc:awardDate)
`pc:mainObject`
`pc:additionalObject`
`skos:closeMatch`
`skos:related`
`skos:broaderTransitive`
`rov:orgActivity`

There are 76 different relations in the Czech public procurement dataset and even more relations are available if we include the linked data.
We included only few relations in the tensor representation.
We experimented with selecting individual relations as well as their combinations to find which ones produce the best results.
We operated under a strong assumption that the impact of features is monotonic
and that the contributions of individual features do not cancel themselves
-->

<!--
### Handling literals

The original version of RESCAL [@Nickel2011] ignores literals.
@Nickel2012 introduces an extension of RESCAL to handle literals.
Pre-processing literals: discretization of ordinal values, tokenization of plain texts, stemming words
Naïve use of literals dramatically increases the dimensionality of the generated tensors.
Literals are included as entities, even though they never appear as subjects. This would make tensors even sparser.
@Nickel2012 proposes to handle literals by separate matrix factorization.
-->

<!--
### Learning to rank

Use a learning-to-rank method to optimize weights of features.
-->

### Benefits and drawbacks

<!--
Batch approach, cannot produce results in real time, computes matches for all contracts (although, predictions can be reconstructed from the RESCAL decomposition only for specific contracts)
- However, once tensor decomposition is computed, producing predictions for individual contracts can be done in real time. 

Sparse adjacency matrices generated from RDF are often challenging to process.

*"local closed world assumption (LCWA), which is often used for training relational models"* [@Nickel2016, p. 13]
*"Training on all-positive data is tricky, because the model might easily over generalize."* [@Nickel2016, p. 24]
Negative examples can be generated by type constraints for predicates or valid ranges of literals.
@Nickel2016 proposes generating negative examples by "perturbing" true triples. (Basically, switching subjects in triples sharing the same predicate.) This generates "type-consistent" triples.
Switching objects in triples sharing the same predicate (under LCWA) is valid for functional properties.
@Nickel2016 proposes an approach that assumes the generated triples to be likely false.
-->

### Matchmaking

<!--
Matchmaking as link prediction (~ tensor completion)

Link prediction ranks entries in the reconstructed tensor by their values (components/factors?).
Assumption: tensor factorization models the affinities between contracts and bidders accurately

Ranking: no threshold
As reported in [@Nickel2012], determining a reasonable threshold is difficult, because the high sparseness causes a bias towards zero.
ranking by the likelyhood that the predicted relation exists => no threshold needed
-->

### Implementation

We implemented *matchmaker-rescal* [@sec:matchmaker-rescal], a thin wrapper of RESCAL that runs our evaluation protocol.

Due to the size of the processed data it is important to leverage its sparsity, which is why we employ efficient data structures for sparse matrices from the SciPy^[<https://www.scipy.org>] library.

Reconstructing the whole predictions slice is unfeasible for larger datasets due to its size in memory.
In order to reduce the memory footprint of the matchmakers, we avoid reconstructing the whole predictions slice from the RESCAL factorization, but instead reconstruct only the top-$k$ results.
Predictions are computed for each row separately, so that the rows can be garbage collected to free memory.

From the performance standpoint it was important to compile the underlying NumPy library with the OpenBLAS^[<http://www.openblas.net>] back-end, which enables to leverage multi-core machines for computing low-level array operations.

<!--
Out-takes:

Experiments with YAGO in @Nickel2012 also include materialized `rdf:type` inferences.
- Should we do the same?

Alternative method for link prediction using tensor representation of RDF:
<http://semdeep.iiia.csic.es/files/SemDeep-17_paper_3.pdf>

Alternative approach: Markov Random Fields (very flexible, but computationally expensive)
-->
