## Summary {#sec:data-summary}

<!--
Summarize the data preparation work done as well as key challenges encountered.

Problems:
- Missing data
- Unreliable identifiers
- Conflicting data without more annotations to identify the correct data (and resolve the conflicts)
- The data suffers from the same problems as user-generated data, since it is created by many users of the public procurement system.
- Reductive use of XML
- Violations of the allegedly validated rules
- Missing shared identifiers
- A more detailed description of the quality of the Czech public procurement data is available in@      Soudek2016a.

Aims:
- Combating the afore-mentioned problems
- Reducing variety/heterogeneity: conforming values, fusing aliases, resolving value conflicts

Approach:
- Separation of concerns to reduce the complexity of data preparation and avoid bugs caused by needless coupling
- Defensive transformations with few assumptions about the data, check the assumptions, and able to cope with violations of the assumptions via fallback solutions.
- Explicit acknowledgments of the known limitations of data, such as its sampling bias.
- Partitioning transformations to allow processing large data
- Declarative specifications of the transformations: XSLT and SPARQL Update operations
- Content-based addressing for deduplication/linking
-->
