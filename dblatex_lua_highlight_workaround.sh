#!/bin/sh

# This script is a work around to problem with asciidoc + dblatex and Lua
# syntax highlighting inspired by suggestions on asciidoc and dblatex
# malinglists and by https://developer.jboss.org/message/738608

ASCIIDOC_INSTALL_DIR="/usr/share/asciidoc/"

cp ${ASCIIDOC_INSTALL_DIR}/dblatex/asciidoc-dblatex.sty ${1}

echo '\lstdefinelanguage{lua}[5.1]{Lua}{}' >> ${1}
