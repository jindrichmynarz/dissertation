### Fusion

Fusion of user-generated content
Fusion policy for correction notices
Topological (dependency) sorting to establish order or rewriting blank nodes to IRIs

- Inverse sort may be used to delete orphaned resources

Dropping conflicting boolean properties: if there are both true and false assertions, then we know nothing.

- Null values do not exist in RDF, hence do not need to be removed. (Some data is better than no data.)

TODO: Add dataset size reduction before and after cleaning
TODO: Add percentage of conflict-free contracts before and after conflict resolution.

* Truth Discovery to Resolve Object Conflicts in Linked Data. <https://arxiv.org/abs/1509.00104>

We adopted a conventional directionality of the `owl:sameAs` links from a non-preferred IRI to the preferred IRI.
This convention allowed us to use a uniform SPARQL Update operation to resolve non-preferred IRIs to their preferred counterparts.
For example, if there is a triple `:a owl:sameAs :b`, `:a` as the non-preferred IRI will be rewritten to `:b`.
Note that this convention can be applied only if you can distinguish between non-preferred and preferred IRIs, such as by preferring IRIs from a reference dataset.
