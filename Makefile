
LUA_HIGHLIGHT_WORKAROUND_STYLE=lua-highlight-asciidoc-dblatex.sty
ASCIIDOC_INSTALL_DIR="/usr/share/asciidoc/"

.PHONY: all
all: pdf html

.PHONY: pdf
pdf: $(LUA_HIGHLIGHT_WORKAROUND_STYLE)
	a2x --verbose -f pdf \
		-a lang=en \
		--dblatex-opts="-s ./$(LUA_HIGHLIGHT_WORKAROUND_STYLE)" \
		--dblatex-opts="-P doc.publisher.show=0" \
		--dblatex-opts="-P latex.output.revhistory=0" \
		main.asciidoc

.PHONY: html
html:
	asciidoc --verbose \
		-a toc2 \
		main.asciidoc


# This is a work around to problem with asciidoc + dblatex and Lua syntax
# highlighting inspired by suggestions on asciidoc and dblatex malinglists
# and by https://developer.jboss.org/message/738608
$(LUA_HIGHLIGHT_WORKAROUND_STYLE):
	cp $(ASCIIDOC_INSTALL_DIR)/dblatex/asciidoc-dblatex.sty $(LUA_HIGHLIGHT_WORKAROUND_STYLE)
	echo '\lstdefinelanguage{lua}[5.1]{Lua}{}' >> $(LUA_HIGHLIGHT_WORKAROUND_STYLE)
