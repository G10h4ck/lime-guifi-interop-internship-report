
.PHONY: all
all: pdf html

.PHONY: pdf
pdf:
	a2x --verbose -f pdf \
		--dblatex-opts="-P doc.publisher.show=0" \
		--dblatex-opts="-P latex.output.revhistory=0" \
		main.asciidoc

.PHONY: html
html:
	asciidoc --verbose \
		-a toc2 \
		main.asciidoc

