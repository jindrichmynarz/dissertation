html:
	pandoc -f markdown \
		--number-sections \
		--toc \
		-s \
		-o text.html \
		--filter pandoc-include \
		--template template.html \
		text.md

pdf:
	pandoc -f markdown \
		--number-sections \
		--toc \
		-s \
		-o text.pdf \
		--filter pandoc-include \
		--variable urlcolor=blue \
		text.md

excerpt:
	pandoc -f markdown \
		--number-sections \
		-s \
		-o excerpt.pdf \
		--filter pandoc-include \
		--variable urlcolor=blue \
		excerpt.md

clean:
	rm -f text.html text.pdf excerpt.pdf
