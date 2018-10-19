#!/bin/sh
if [ "$#" -ne 2 ]; then
        echo "Usage: ./texLivePreview.sh input.tex refreshInterval (in seconds)"
        exit
fi
pdftex -interaction=batchmode $1
        xdg-open *.pdf
while true
do
	pdftex -interaction=batchmode $1
	pkill -HUP mupdf
	sleep $2s
done
