html:
	pandoc -f markdown+implicit_figures+backtick_code_blocks \
		--mathjax \
		--number-sections \
		--toc \
		-s \
		-o text.html \
		--filter pandoc-include \
		--filter pandoc-crossref \
		--template template.html \
		--highlight-style tango \
		text.md

pdf:
	pandoc -f markdown+implicit_figures+backtick_code_blocks \
		--latex-engine=xelatex \
		--number-sections \
		--toc \
		-s \
		-o text.pdf \
		--filter pandoc-include \
		--filter pandoc-crossref \
		--variable urlcolor=blue \
		--highlight-style tango \
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
		--variable urlcolor=blue \
		--highlight-style tango \
		excerpt.md

clean:
	rm -f text.html text.pdf excerpt.pdf
