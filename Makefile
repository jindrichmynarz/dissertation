html:
	pandoc -f markdown+implicit_figures+backtick_code_blocks \
		--mathjax \
		--number-sections \
		--toc \
		-s \
		-o text.html \
		--filter pandoc-include \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--template style/template.html \
		--bibliography references.bib \
		--csl style/ref_format.csl \
		text.md

pdf:
	pandoc -f markdown+implicit_figures+backtick_code_blocks+citations \
		--latex-engine=xelatex \
		--number-sections \
		--toc \
		-s \
		-o text.pdf \
		--filter pandoc-include \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--variable urlcolor=blue \
		--template style/template.tex \
		--bibliography references.bib \
		--csl style/ref_format.csl \
		-V fontsize=12pt \
		-V papersize=a4paper \
		-V documentclass:report \
		text.md

excerpt:
	pandoc -f markdown+implicit_figures+backtick_code_blocks \
		--latex-engine=xelatex \
		--toc \
		--number-sections \
		-s \
		-o excerpt.pdf \
		--filter pandoc-include \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--variable urlcolor=blue \
		--template style/template.tex \
		--bibliography references.bib \
		--csl style/ref_format.csl \
		-V fontsize=12pt \
		-V papersize=a4paper \
		-V documentclass:report \
		excerpt.md

clean:
	rm -f text.html text.pdf excerpt.pdf
