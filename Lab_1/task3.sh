#!/bin/bash

gawk -F',' '
FNR==NR {
  hash[$1]=$4;
}
FNR<NR {
  print hash[$2] > "temp/3_artists.txt"
}' original/songs_final.txt original/triplets_final.txt

gawk -F',' '{
  listen[$1]++;
}
END {
  for (key in listen) {
    print key "," listen[key] > "temp/3_count_artists.txt"
  }
}' temp/3_artists.txt

sort -t ',' -k 2 -n -r temp/3_count_artists.txt | head -n 1 > task3_output.txt

