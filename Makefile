
.PHONY: all
all: pdf html

LUA_HIGHLIGHT_WORKAROUND_STYLE=lua-highlight-asciidoc-dblatex.sty

.PHONY: pdf
pdf: $(LUA_HIGHLIGHT_WORKAROUND_STYLE)
	a2x --verbose -f pdf \
		--dblatex-opts="-s ./$(LUA_HIGHLIGHT_WORKAROUND_STYLE)" \
		--dblatex-opts="-P doc.publisher.show=0" \
		--dblatex-opts="-P latex.output.revhistory=0" \
		main.asciidoc

.PHONY: html
html:
	asciidoc --verbose \
		-a toc2 \
		main.asciidoc

$(LUA_HIGHLIGHT_WORKAROUND_STYLE):
	./dblatex_lua_highlight_workaround.sh $(LUA_HIGHLIGHT_WORKAROUND_STYLE)
