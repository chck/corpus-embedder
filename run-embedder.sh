#!/bin/sh

wget https://dumps.wikimedia.org/jawiki/latest/jawiki-latest-pages-articles.xml.bz2 -P /tmp/jawiki/ && \
	cd /tmp/jawiki && \
	git clone https://github.com/attardi/wikiextractor.git && \
	python wikiextractor/WikiExtractor.py -b 500M -o corpus jawiki-latest-pages-articles.xml.bz2 && \
	cat ./corpus/AA/wiki_* > ./jawiki.txt

mv jawiki.txt jawikitmp.txt
head jawikitmp.txt > jawiki.txt

mecab -d $MECAB_DICDIR jawiki.txt -O wakati -o jawiki_wakatied.txt

fasttext skipgram -input jawiki_wakatied.txt -output /tmp/jawiki_neologd -dim 200 -neg 25 -ws 8

