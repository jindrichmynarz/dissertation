## Tensor factorization

<!--
TODO: Re-read:
- <https://pdfs.semanticscholar.org/308b/f5b1b6cd5c2124d7589945f715b0adc7b8f8.pdf>
- <https://pdfs.semanticscholar.org/c971/32a582efacd84d6550ad8107d1ad9a83a88e.pdf>
- <http://machinelearning.wustl.edu/mlpapers/paper_files/ICML2011Nickel_438.pdf>
- <https://pdfs.semanticscholar.org/498c/a0a1f8c980586408addf7ab2919ecdb7dd3d.pdf>

- <https://en.wikipedia.org/wiki/Tensor_rank_decomposition>
- <https://en.wikipedia.org/wiki/Tensor_(intrinsic_definition)#Tensor_rank>
-->

<!--
Tensor factorization in broad strokes, link to statistical relational learning
-->

Factorization is a method used in statistical relational learning.
Tensor factorization can be regarded as generalizing matrix factorization (singular value decomposition) for higher-dimensional arrays.

Tensor factorization is a method of decomposing tensors into lower-rank approximations ...
Tensor factorization is based on the assumption that there exists a low-dimensional representation of the entities in tensors.

Factorization methods yield good results in domains characterized by high dimensionality and sparseness [@Nickel2011].

Rank of tensor $\mathcal{X}$ is "*the smallest number of rank-one tensors that generate $\mathcal{X}$ as their sum"* [@Kolda2009].
Rank-one tensors are those that *"can be written as the outer product of $N$ vectors"* [@Kolda2009]:

$$\mathcal{X} = \mathbf{a}^{(1)} \circ \mathbf{a}^{(2)} \circ \cdots \circ \mathbf{a}^{(N)}$$

<!--
low-rank factorization
*"The rank of a tensor $\mathcal{X}$, denoted as $rank(\mathcal{X})$, is defined as the smallest number of rank one tensors that generate $\mathcal{X}$ as their sum."* [@Kolda2009]

FIXME: Clarify when "tensor factorization" means a method and when its result. We should probably use "tensor decomposition" for the result (and define it explicitly).

Tensor factorization produces a latent feature model.
- explains triples by latent features of entities
- factorizes a partially observed tensor

Tensor factorizations generalizes matrix factorization.
decomposition into a product of two or more simpler tensors or matrices

Tensor factorization has applications in many domains, such as chemometrics or mining of social networks.

Theoretical generalization of the abilities of tensor factorization is in @Nickel2013b.
decompositions are possible because most tensors have latent structure

Tensor factorization is inefficient if data contains a lot of strongly connected graph components.
Decomposition addresses high dimensionality and sparseness.

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

tensor factorization can be considered a generalization of the matrix singular value decomposition

There are many methods for factorization of tensors representing RDF data.
Cite related work? [@Franz2009]
Why have we chosen RESCAL?

Relations are functions of a linear combination of latent factors.

Factorization reduces the noise in the input tensor [@Zhiltsov2013, p. 1254].
-->

### RESCAL

RESCAL is an algorithm for factorization of third-order tensors.

frontal slice $X_{k}$ of $\mathcal{X}$:

$X_{k} \approx AR_{k}A^{T}$

![RESCAL factorization, adopted from @Nickel2012](img/rescal_factorization.png){#fig:rescal-factorization}

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
- enables learning long-range dependencies that may span chains of relations of multiple types
- traditional factorization methods cannot model collective learning sufficiently [@Nickel2011]

There is a need to balance the expressiveness of the latent features with the runtime of tensor factorization.

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

-->

<!-- Handling literals -->

The original version of RESCAL [@Nickel2011] uses only object properties as relations.
Datatype properties with literal objects can only be used if the literals are treated as entities.
Since literals are included as entities, although they never appear as subjects, the tensor's sparseness grows. 
Moreover, since the number of distinct literals may significantly surpass the number of entities, this naïve treatment will greatly raise the dimensionality of the input tensor. 
Both high dimensionality and sparseness thereby increase the complexity of computing the factorization.
Minor improvements can be attained by pre-processing literals, such as by discretizing ordinal values, tokenizing plain texts, and stemming the generated tokens.
Nevertheless, treatment of literals warrants a more sophisticated approach.
@Nickel2012 introduced an extension of RESCAL to handle literals via an attribute matrix that is factorized conjointly with the tensor with relations between entities.
@Zhiltsov2013 proposed Ext-RESCAL, an approach using term-based entity descriptions that include names, other datatype properties as attributes, and outgoing links.

<!-- Limitations -->

RESCAL is a batch approach that cannot produce results in real time.
First, it needs to factorize the input tensor to a decomposition that models the tensor.
Once this model is built, predictions for individiual contracts can be computed on demand.

<!--
Sparse adjacency matrices generated from RDF are often challenging to process.

*"local closed world assumption (LCWA), which is often used for training relational models"* [@Nickel2016, p. 13]
*"Training on all-positive data is tricky, because the model might easily over generalize."* [@Nickel2016, p. 24]
Negative examples can be generated by type constraints for predicates or valid ranges of literals.
@Nickel2016 proposes generating negative examples by "perturbing" true triples. (Basically, switching subjects in triples sharing the same predicate.) This generates "type-consistent" triples.
Switching objects in triples sharing the same predicate (under LCWA) is valid for functional properties.
@Nickel2016 proposes an approach that assumes the generated triples to be likely false.
-->

Many extensions of RESCAL were proposed.
Its state-of-the-art results and conceptual simplicity invite improvements.
As discussed above, @Zhiltsov2013 enhanced RESCAL with term-based entity descriptions.
Several researchers (-@Chang2014, -@Krompass2014, -@Krompass2015) investigated adding type constraints to RESCAL.
These constraints improve RESCAL by preventing type-incompatible predictions.
The type compatibility can be determined by interpreting `rdfs:domain` and `rdfs:range` axioms under LCWA or by evaluating custom restrictions, such as requiring the subject entity to be older than the object entity.
These type constraints can be represented as binary matrices [@Krompass2014] indicating compatibility of entities.
The original RESCAL considers all possible relations, notwithstanding their type, which increases the model complexity and leads to *"an avoidable high runtime and memory consumption"* [@Krompass2014].
Even though RESCAL is faster than the type-constrained approach when using the same rank, using type constraints typically requires a lower rank to produce results that RESCAL is able of achieving only at higher ranks.
@Kuchar2016 enhanced link prediction to be time-aware.
We used this approach in data pre-processing, described in the [@sec:rescal-loading], to model decaying relevance of older contract awards.
@Padia2016 computed RESCAL with regard to the similarity of tensor slices to obtain better results.

### Matchmaking

We used link prediction via RESCAL for matchmaking, assuming that the tensor decomposition produced by RESCAL can accurately model the affinities between contracts and bidders.
Probabilities of links predicted in the contract award slice can be obtained by reconstructing the slice from the tensor decomposition.
Given the slice $R_{award}$ for contract awards from the latent factor tensor $\mathcal{R}$ produced by RESCAL, we can obtain predictions of entities awarded with the contract $c$ by computing the vector $p = A_{c}R_{award}A^{T}$. <!-- _b -->
Entries in $p$ can be interpreted as probabilities of the contract $c$ being awarded to entities at corresponding indices in $p$.
Using the indices of bidders we can filter the entries in $p$ and then rank them in descending order to obtain the best matches for $c$.

<!--
Matchmaking as link prediction (~ tensor completion)

Link prediction ranks entries in the reconstructed tensor by their values (components/factors?).

matrix slice $R_{award}$ for contract awards from the latent factor tensor $\mathcal{R}$
$C' \subset C$ are the withheld contracts
contract $c \in C'$

select only the entries for indices of bidders
sort in descending order
select top 10 entries
FIXME: Put the details (e.g., top 10 entries) into the evaluation section?

Ranking: no threshold
As reported in [@Nickel2012], determining a reasonable threshold is difficult, because the high sparseness causes a bias towards zero: *"However, due to a general sparseness of relationships there is a strong bias towards zero, which makes it difficult to select a reasonable threshold $\theta$"* [@Nickel2012, 274].
ranking by the likelyhood that the predicted relation exists => no threshold needed
-->

### Implementation

We implemented *matchmaker-rescal* [@sec:matchmaker-rescal], a thin wrapper of RESCAL that runs our evaluation protocol.

Due to the size of the processed data it is important to leverage its sparseness, which is why we employ efficient data structures for sparse matrices from the SciPy^[<https://www.scipy.org>] library.

Reconstructing the whole predictions slice is unfeasible for larger datasets due to its size in memory.
In order to reduce the memory footprint of the matchmakers, we avoid reconstructing the whole predictions slice from the RESCAL factorization, but instead reconstruct only the top-$k$ results.
Predictions are computed for each row separately, so that the rows can be garbage-collected to free memory.

From the performance standpoint it was important to compile the underlying NumPy library with the OpenBLAS^[<http://www.openblas.net>] back-end, which enables to leverage multi-core machines for computing low-level array operations.

<!--
Out-takes:

Experiments with YAGO in @Nickel2012 also include materialized `rdf:type` inferences.
- Should we do the same?

Alternative method for link prediction using tensor representation of RDF:
<http://semdeep.iiia.csic.es/files/SemDeep-17_paper_3.pdf>

Alternative approach: Markov Random Fields (very flexible, but computationally expensive)
-->
