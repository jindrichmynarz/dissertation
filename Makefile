.PHONY: citations clean

define PARTS
parts/preface.md \
parts/acknowledgements.md \
parts/introduction.md \
parts/linked_open_data.md \
parts/open_data.md \
parts/linked_data.md \
parts/public_procurement_domain.md \
parts/matchmaking.md \
parts/case_based_reasoning.md \
parts/statistical_relational_learning.md \
parts/related_work.md \
parts/data_preparation.md \
parts/modelling.md \
parts/public_contracts_ontology.md \
parts/concrete_data_model.md \
parts/extraction.md \
parts/transformation.md \
parts/linking.md \
parts/geocoding.md \
parts/linked_datasets.md \
parts/cpv.md \
parts/ares.md \
parts/czech_addresses.md \
parts/zindex.md \
parts/fusion.md \
parts/loading.md \
parts/loading_sparql.md \
parts/loading_rescal.md \
parts/data_summary.md \
parts/methods.md \
parts/ground_truth.md \
parts/sparql.md \
parts/tensor_factorization.md \
parts/evaluation.md \
parts/offline_evaluation.md \
parts/results_sparql.md \
parts/results_rescal.md \
parts/results_comparison.md \
parts/conclusions.md \
parts/references.md \
parts/abbreviations.md \
parts/software.md \
parts/publications.md
endef

define COMMON_PARAMS
-f markdown+implicit_figures+backtick_code_blocks+smart \
--number-sections \
--toc \
--standalone \
--filter pandoc-crossref \
--filter pandoc-citeproc \
--bibliography references.bib \
--csl resources/iso690-author-date-cs.csl \
parts/metadata.yaml
endef

define PDF_PARAMS
--pdf-engine=xelatex \
--include-before-body parts/title_page.tex \
--include-before-body parts/affidavit.tex \
--include-before-body parts/abstract_czech.tex \
--include-before-body parts/abstract_english.tex \
--template resources/templates/template.tex \
-V fontsize=12pt \
-V papersize=a4paper \
-V documentclass:report \
-o dissertation.pdf
endef

html:
	pandoc \
		-o index.html \
		-t html5 \
		--section-divs \
		--template resources/templates/template.html \
		--css http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css \
		--css http://fonts.googleapis.com/css?family=Source+Sans+Pro:700 \
		--css http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic \
		--css resources/css/bootstrap.css \
		--mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-AMS_CHTML-full \
		-V lang=en \
		--strip-comments \
		$(COMMON_PARAMS) \
		$(PARTS)

dokieli:
	pandoc \
		-o index.html \
		-t html5 \
		--section-divs \
		--template resources/templates/dokieli.html \
		--css http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css \
		--css http://fonts.googleapis.com/css?family=Source+Sans+Pro:700 \
		--css http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic \
		--css https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css \
		--css https://dokie.li/media/css/do.css \
		--css resources/css/bootstrap.css \
		--mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-AMS_CHTML-full \
		-V lang=en \
		$(COMMON_PARAMS) \
		$(PARTS)

pdf:
	pandoc --variable citecolor=orange \
		--variable urlcolor=orange \
		--variable linkcolor=orange \
		$(PDF_PARAMS) \
		$(COMMON_PARAMS) \
		$(PARTS)

print:
	pandoc --variable citecolor=black \
		--variable urlcolor=black \
		--variable linkcolor=black \
		$(PDF_PARAMS) \
		$(COMMON_PARAMS) \
		$(PARTS)

citations:
	pandoc --latex-engine=xelatex \
		-o citations.pdf \
		--variable citecolor=black \
		--variable urlcolor=black \
		--variable linkcolor=black \
		-V fontsize=12pt \
		-V papersize=a4paper \
		-V documentclass:report \
		-f markdown \
		--normalize \
		--smart \
		--standalone \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--bibliography citations/citations.bib \
		--csl resources/iso690-author-date-cs.csl \
		citations/citations.md

autoreferat:
	pandoc --latex-engine=xelatex \
		-o autorefererat.pdf \
		--variable citecolor=black \
		--variable urlcolor=black \
		--variable linkcolor=black \
		-V fontsize=12pt \
		-V papersize=a4paper \
		-V documentclass:report \
		-f markdown \
		--normalize \
		--smart \
		--standalone \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--bibliography references.bib \
		--csl resources/iso690-author-date-cs.csl \
		autoreferat/autoreferat.md

clean:
	rm -f index.html dissertation.pdf citations.pdf autoreferat.pdf
