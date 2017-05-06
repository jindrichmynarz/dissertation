html:
	pandoc -f markdown+implicit_figures+backtick_code_blocks \
		--mathjax \
		--number-sections \
		--toc \
		-s \
		-S \
		-o text.html \
		--filter pandoc-include \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--template style/template.html \
		--bibliography references.bib \
		--csl style/iso690-author-date-cs.csl \
		text.md

pdf:
	pandoc -f markdown+implicit_figures+backtick_code_blocks+citations \
		--latex-engine=xelatex \
		--number-sections \
		--toc \
		--include-before-body parts/title_page.tex \
		-s \
		-S \
		-o text.pdf \
		--filter pandoc-include \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--variable citecolor=orange \
		--variable urlcolor=orange \
		--variable linkcolor=orange \
		--template style/template.tex \
		--bibliography references.bib \
		--csl style/iso690-author-date-cs.csl \
		-V fontsize=12pt \
		-V papersize=a4paper \
		-V documentclass:report \
		text.md

excerpt:
	pandoc -f markdown+implicit_figures+backtick_code_blocks \
		--latex-engine=xelatex \
		--number-sections \
		--toc \
		--include-before-body parts/title_page.tex \
		-s \
		-S \
		-o excerpt.pdf \
		--filter pandoc-include \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--variable citecolor=orange \
		--variable urlcolor=orange \
		--variable linkcolor=orange \
		--template style/template.tex \
		--bibliography references.bib \
		--csl style/iso690-author-date-cs.csl \
		-V fontsize=12pt \
		-V papersize=a4paper \
		-V documentclass:report \
		excerpt.md

clean:
	rm -f text.html text.pdf excerpt.pdf
