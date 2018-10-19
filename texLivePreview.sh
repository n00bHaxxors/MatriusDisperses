#!/bin/sh
if [ "$#" -ne 2 ]; then
        echo "Usage: ./texLivePreview.sh input.tex refreshInterval (in seconds)"
        exit
fi
pdflatex -interaction=batchmode $1
zathura *.pdf &
while true
do
	pdflatex -interaction=batchmode $1
	#pkill -HUP mupdf
	sleep $2s
done
