#!/bin/bash

SIZE_OPT=""
SUFFIX=""

case ${1} in
*dpi)
	DPI="${1%%dpi}"
	INKSCAPE_SIZE="--export-dpi ${DPI}"
	SUFFIX="_${DPI}dpi.png"
	;;
*px)
	WIDTH="${1%%px}"
	INKSCAPE_SIZE="--export-width ${WIDTH}"
	SUFFIX="_${WIDTH}px.png"
esac

mkdir -p images

grep -h ^image:: *.asciidoc | while read IMAGE_LINE ; do
	GRAPHNAME="${IMAGE_LINE%%_{*}"
	GRAPHNAME="${GRAPHNAME##*/}"
	GRAPHPARAMS="${GRAPHNAME##*+}"
	GRAPHNAME="${GRAPHNAME%%+*}"
	FILE="$(ls graphics/${GRAPHNAME}.* | head -n 1)"
	GRAPHTYPE="${FILE##*.}"

	[ "${FILE}" -nt "images/${GRAPHNAME}${SUFFIX}" ] &&
	{
		case ${GRAPHTYPE} in
		"dia")
			dia -O images -t svg ${FILE}
			inkscape --without-gui --export-area-drawing ${INKSCAPE_SIZE} \
				--export-png=images/${GRAPHNAME}${SUFFIX} \
				images/${GRAPHNAME}.svg
			;;
		"gp")
			gnuplot -e "datafile=\"graphics/data_${GRAPHNAME}.${GRAPHPARAMS}.dat\";" ${FILE} > images/${GRAPHNAME}.${GRAPHPARAMS}.svg
			inkscape --without-gui --export-area-drawing ${INKSCAPE_SIZE} \
				--export-png=images/${GRAPHNAME}+${GRAPHPARAMS}${SUFFIX} \
				images/${GRAPHNAME}.${GRAPHPARAMS}.svg
			;;
		"png")
			cp ${FILE} images/${GRAPHNAME}${SUFFIX}
			;;
		"svg")
			inkscape --without-gui --export-area-drawing ${INKSCAPE_SIZE} \
				--export-png=images/${GRAPHNAME}${SUFFIX} \
				graphics/${GRAPHNAME}.svg
			;;
		esac
	}
done

exit 0
