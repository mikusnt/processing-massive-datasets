#!/bin/bash

# 2.1
cat original/unique_tracks.txt | wc -l
# 1 000 000
cat original/unique_tracks.txt | uniq | wc -l
# 1 000 000
cat original/triplets_sample_20p.txt | wc -l
# 27 729 357
cat original/triplets_sample_20p.txt | uniq | wc -l
# 27 729 357


# 2.2
cat original/unique_tracks.txt | head | fold -w 1 | sort | uniq > temp/chars.txt
cat original/triplets_sample_20p.txt | head | fold -w 1 | sort | uniq > temp/chars2.txt

sed 's/<SEP>/,/g' original/unique_tracks.txt > original/unique_tracks_uns.txt
sed 's/<SEP>/,/g' original/triplets_sample_20p.txt > original/triplets_uns.txt
# separator will be ","

cat original/unique_tracks_uns.txt | cut -d "," -f1 | sort | uniq | wc -l
# 1 000 000
cat original/unique_tracks_uns.txt | cut -d "," -f2 | sort | uniq | wc -l
# 999 056
cat original/unique_tracks_uns.txt | cut -d "," -f3 | sort | uniq | wc -l
# 72 596
cat original/unique_tracks_uns.txt | cut -d "," -f4 | sort | uniq | wc -l
# 702 130

cat original/triplets_uns.txt | cut -d "," -f1 | sort | uniq | wc -l
# 1 014 070
cat original/triplets_uns.txt | cut -d "," -f2 | sort | uniq | wc -l
# 332 123
cat original/triplets_uns.txt | cut -d "," -f3 | sort -n | uniq | wc -l
# 26 544 500


# 2.3
cat original/triplets_uns.txt | cut -d "," -f3 | sort -n | uniq > temp/dates_timestamp.txt

head -n 1 temp/dates_timestamp.txt | xargs -I {} date --date="@{}"
# pon, 1 sty 2001, 01:00:00 CET

tail -n 1 temp/dates_timestamp.txt | xargs -I {} date --date="@{}"
# czw, 30 gru 2010, 00:59:43 CET

rm -f temp/*

