html:
	pandoc -f markdown+implicit_figures \
		--mathjax \
		--number-sections \
		--toc \
		-s \
		-o text.html \
		--filter pandoc-include \
		--filter pandoc-crossref \
		--template template.html \
		text.md

pdf:
	pandoc -f markdown+implicit_figures \
		--latex-engine=xelatex \
		--number-sections \
		--toc \
		-s \
		-o text.pdf \
		--filter pandoc-include \
		--filter pandoc-crossref \
		--variable urlcolor=blue \
		text.md

excerpt:
	pandoc -f markdown+implicit_figures \
		--latex-engine=xelatex \
		--toc \
		--number-sections \
		-s \
		-o excerpt.pdf \
		--filter pandoc-include \
		--filter pandoc-crossref \
		--variable urlcolor=blue \
		excerpt.md

clean:
	rm -f text.html text.pdf excerpt.pdf
