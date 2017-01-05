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
		text.md

clean:
	rm -f text.html text.pdf
