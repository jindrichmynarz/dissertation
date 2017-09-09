## Tensor factorization

Tensor factorization is a method for decomposing tensors, described in the [@sec:loading-rescal], into lower-rank approximations.
The rank of a tensor $\mathcal{X}$ is "*the smallest number of rank one tensors that generate $\mathcal{X}$ as their sum"* [@Kolda2009].
$\mathcal{X}$ is an $N$^th^ order rank one tensor when it *"can be written as the outer product of $N$ vectors"* [@Kolda2009]: $\mathcal{X} = \mathbf{a}^{(1)} \circ \mathbf{a}^{(2)} \circ \cdots \circ \mathbf{a}^{(N)}$.
Determining the tensor's rank is known to be an NP-hard problem [@Sidiropoulos2017], so in practice low-rank approximations are used instead.
As such, tensor factorization can be considered a dimensionality reduction technique based on the assumption that there exists a low-dimensional embedding of entities in tensors.
In fact, computing a tensor factorization is possible because most tensors exhibit latent structure.
A theoretical generalization of the abilities of tensor factorization is provided in @Nickel2013b.

Tensor factorization can be regarded as a generalization of matrix factorization for higher-dimensional arrays.
Unlike matrices, tensor representation offers a greater fidelity, since it can preserve the structure of higher order relations that would be lost were these relations collapsed into a matrix representation [@Morup2011].
Tensor factorization is also referred to as tensor decomposition.
Here, for clarity, we use tensor factorization to denote the process of computing its product, the tensor decomposition.

Statistical relational learning, introduced in the [@sec:srl], employs tensor factorization for link prediction.
Viewed from this perspective, the input of factorization is considered to be a noisy, partially observed tensor.
Tensor decomposition produced by the factorization can be in turn used to reconstruct an approximation of the complete tensor.
In this way, we can use tensor decompositions as prediction models that explain the predicted links by latent features of entities.
Tensor factorization typically yields good results for link prediction in domains characterized by high dimensionality, sparseness [@Nickel2011], and noise [@Zhiltsov2013, p. 1254].
So far, it has found applications in many domains, including chemometrics or social network mining.
There were also a few attempts to apply tensor factorization to RDF, such as TripleRank [@Franz2009], the dominant one being RESCAL [@Nickel2011]. 
We reused RESCAL for matchmaking via tensor factorization.

<!--
linear combination
generalization of matrix singular value decomposition

*"The rank of a tensor is given by its minimal sum of rank one components $R$ such that"* [@Morup2011]:

$$\mathcal{X} = \sum_{r=1}^{R} a_{r} \circ b_{r} \circ c_{r}$$

Decomposition addresses high dimensionality and sparseness.
Tensor factorization is inefficient if data contains a lot of strongly connected graph components.

Relations are functions of a linear combination of latent factors.

matrices $R$ are low-rank matrix approximations

Perspective of probabilistic databases

Hybrid approaches combining multiple methods
- E.g., re-ranking

Dealing with the noise in the data
-->

### RESCAL

RESCAL is a machine learning algorithm for factorization of third-order tensors.
It factorizes a tensor $\mathcal{X}$ with $n$ entities to a rank-$r$ representation, so that each frontal slice $\mathcal{X}_{k}$ of the tensor can be approximately reconstructed via matrix product from the decomposition to latent components, as shown in the @fig:rescal-decomposition: <!-- _b -->

$$X_{k} \approx AR_{k}A^{T}$$ {#eq:rescal-decomposition}

![RESCAL decomposition, adopted from @Nickel2012](img/rescal_decomposition.png){#fig:rescal-decomposition}

In this formula, $A$ is an $n \times r$ matrix containing the latent component representation of entities in $\mathcal{X}$, $A^{T}$ is its transposition, and $R_{k}$ is a square $r \times r$ matrix modelling the interactions of the latent components in the $k$^th^ predicate [@Nickel2011]. <!-- _b -->
Using this decomposition, RESCAL *"explains triples via pairwise interactions of latent features"* [@Nickel2016, p. 17].
Unlike other latent feature models, latent variables in RESCAL do not describe entity classes but are latent entity factors [@Tresp2014].
The rank $r$ is a *"a central parameter of factorization methods that determines generalization ability as well as scalability"* [@Nickel2014].
While higher $r$ increases the expressiveness of the latent features, it also increases the runtime of tensor factorization as well as its propensity for over-fitting.
Consequently, setting $r$ to an appropriate value is a key trade-off to be made when tuning RESCAL.

RESCAL uses distinct latent representations of entities as subjects and objects, which enables efficient information propagation to capture correlations over long-range relational chains [@Nickel2013c, p. 619] that may span heterogeneous relations. 
In this way, RESCAL is able to leverage contextual data that is more distant in the relational graph for collective learning, which we described in the [@sec:srl].
Unlike other factorization methods that cannot model collective learning sufficiently, *"the main advantage of RESCAL, if compared to other tensor factorizations, is that it can exploit a collective learning effect when applied to relational data"* [@Nickel2012, p. 272].

RESCAL achieves leading performance for link prediction tasks.
It was shown to be superior for link prediction tasks on several datasets.
Moreover, it scales better to large data than many traditional methods for statistical relational learning, such as Markov logic networks.
@Nickel2012 demonstrated how the execution of RESCAL can be parallelized and distributed across multiple computing nodes.
RESCAL is also fundamentally simpler than other tensor factorization methods. 
Unlike similar algorithms, RESCAL stands out by low Kolmogorov complexity.
It is implemented only in 120 lines of code of Python [@Nickel2011] using only the NumPy^[<http://www.numpy.org>] library.

<!-- Extensions -->

Many extensions of RESCAL were proposed.
Its state-of-the-art results and conceptual simplicity invite improvements.
The aspects that the extensions deal with include negative training examples, handling literals, or type constraints.
We employed some of the discussed extensions for matchmaking.

<!-- Negative examples -->

RESCAL adopts the local closed world assumption (LCWA), which is used often for training relational models [@Nickel2016, p. 13].
It *"approaches the problem of learning from positive examples only, by assuming that missing triples are very likely not true, an approach that makes sense in a high-dimensional but sparse domain"* [@Nickel2012, p. 273].
However, *"training on all-positive data is tricky, because the model might easily over generalize"* [@Nickel2016, p. 24].
In order to avoid under-fitting, negative examples can be generated via type constraints for predicates or valid ranges of literals.
@Nickel2016 proposes generating negative examples by perturbing true triples.
Basically, switching subjects in triples sharing the same functional property produces false, but type-consistent triples.

<!-- Handling literals -->

The original version of RESCAL [@Nickel2011] uses only object properties as relations.
Datatype properties with literal objects can only be used if the literals are treated as entities.
When literals are included as entities, although they never appear as subjects, the tensor's sparseness grows. 
Moreover, since the number of distinct literals may significantly surpass the number of entities, this naïve treatment will greatly expand the dimensionality of the input tensor. 
Both high dimensionality and sparseness thereby increase the complexity of computing the factorization.
Minor improvements can be attained by pre-processing literals, such as by discretizing ordinal values, tokenizing plain texts, and stemming the generated tokens.
Nevertheless, treatment of literals warrants a more sophisticated approach.
To address this issue, @Nickel2012 introduced an extension of RESCAL to handle literals via an attribute matrix that is factorized conjointly with the tensor with relations between entities.
In a similar vein, @Zhiltsov2013 proposed Ext-RESCAL, an approach using term-based entity descriptions that include names, other datatype properties as attributes, and outgoing links.

<!-- Type constraints -->

Several researchers (@Chang2014, @Krompass2014, @Krompass2015) investigated adding type constraints to RESCAL.
These constraints improve RESCAL by preventing type-incompatible predictions.
The type compatibility can be determined by interpreting the `rdfs:domain` and `rdfs:range` axioms under LCWA or by evaluating custom restrictions, such as requiring the subject entity to be older than the object entity when predicting parents.
These type constraints can be represented as binary matrices [@Krompass2014] indicating compatibility of entities.
The original RESCAL considers all entities for possible relations, notwithstanding their type, which increases its model complexity and leads to *"an avoidable high runtime and memory consumption"* [@Krompass2014].
Even though RESCAL is faster than the type-constrained approach with the same rank, using type constraints typically requires a lower rank to produce results that RESCAL is able of achieving only at higher ranks.

<!-- Other extensions -->

Other notable extensions of RESCAL add time awareness or tensor slice similarities.
@Kuchar2016 enhanced link prediction via RESCAL to be time-aware.
We used this approach in data pre-processing, as described in the [@sec:rescal-loading], to model decaying relevance of older contract awards.
@Padia2016 computed RESCAL with regard to the similarity of tensor slices to obtain better results.

### Ranking

We applied link prediction via RESCAL to matchmaking, assuming that the tensor decomposition produced by RESCAL can accurately model the affinities between contracts and bidders.
Probabilities of links predicted in the tensor slice representing contract awards can be obtained by reconstructing the slice from the tensor decomposition.
Given the slice $R_{award}$ for contract awards from the latent factor tensor $\mathcal{R}$ produced by RESCAL, we can obtain predictions of entities awarded with the contract $c$ by following the [@eq:rescal-decomposition] and computing the vector $p = A_{c}R_{award}A^{T}$. <!-- _b This vector is also a mode-2 fiber. -->
Entries in $p$ can be interpreted as probabilities of the contract $c$ being awarded to entities at corresponding indices in $p$.
Using the indices of bidders we can filter the entries in $p$ and then rank them in descending order to obtain the best matches for $c$.

We used no minimal threshold to filter out irrelevant matches.
As reported in [@Nickel2012], determining a reasonable threshold is difficult, because the high sparseness of the input tensors causes a strong bias towards zero [@Nickel2012, 274].
Consequently, instead of setting an arbitrary threshold, we ranked the predictions by their likelyhood and projected the top-ranking predictions as the matches.
This decision is a trade-off erring on the side of delivering less relevant results instead of producing no results.

<!--
Link prediction ranks entries in the reconstructed tensor by their values (components/factors?).

matrix slice $R_{award}$ for contract awards from the latent factor tensor $\mathcal{R}$
$C' \subset C$ are the withheld contracts
contract $c \in C'$

select only the entries for indices of bidders
sort in descending order
select top 10 entries
FIXME: Put the details (e.g., top 10 entries) into the evaluation section?
-->

<!-- Limitations -->

Unlike SPARQL, RESCAL is a batch approach that cannot produce results in real time.
First, it needs to factorize the input tensor to a decomposition that models the tensor.
Once this model is built, predictions for individiual contracts can be computed on demand.
RESCAL is hence slow to cope with changing data.
Matchmaking via RESCAL is thus more appropriate if the matches are delivered via periodic subscriptions instead of on-demand queries.

<!--
FIXME: Mention blind matchmaker implemented by generating random predictions?
-->

### Implementation

We implemented *matchmaker-rescal*, described in the [@sec:matchmaker-rescal], a thin wrapper of RESCAL that runs our evaluation protocol, explained in the [@sec:evaluation-protocol].

When developing the RESCAL wrapper, we needed to take several aspects of performance into consideration.
Due to the size of the processed data it is important to leverage its sparseness, which is why we employ efficient data structures for sparse matrices from the SciPy^[<https://www.scipy.org>] library.
Reconstructing the whole predictions slice is unfeasible for larger datasets due to its size in memory.
In order to reduce the memory footprint of the matchmakers, we avoid reconstructing the whole predictions slice from the RESCAL factorization, but instead reconstruct only the top-$k$ results.
Predictions are computed for each row separately, so that the rows can be garbage-collected to free memory.
In order to enable parallelization it was important to compile the underlying NumPy library with the OpenBLAS^[<http://www.openblas.net>] back-end, which allows to leverage multi-core machines for computing low-level array operations, such as the matrix product that is central to RESCAL.

<!--
numpy.dot implements the matrix product (i.e. sum of rows times columns)
-->

<!--
Out-takes:

Experiments with YAGO in @Nickel2012 also include materialized `rdf:type` inferences.
- Should we do the same?

Alternative method for link prediction using tensor representation of RDF:
<http://semdeep.iiia.csic.es/files/SemDeep-17_paper_3.pdf>

Alternative approach: Markov Random Fields (very flexible, but computationally expensive)

RESCAL exploits idiosyncratic properties of relational data.
*"RESCAL can be regarded as a latent-variable model for multi-relational data"* [@Nickel2012, p. 273]

RESCAL does not require strict feature modelling.
RESCAL may be used to generate similarities between entities that may be then used in non-relational methods.

**Comparison with matrix factorization**

RESCAL is similar to matrix factorization (MF) methods used in recommender systems [@Nickel2016, p. 18].
MF offers good scalability, predictive accuracy, and modelling flexibility [@Koren2009, p. 44].
MF allows to incorporate both explicit and implicit feedback.
However, reshaping tensors into matrices causes data loss.

Switching objects in triples sharing the same predicate (under LCWA) is valid for functional properties.
@Nickel2016 proposes an approach that assumes the generated triples to be likely false.
-->
