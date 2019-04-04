#!/bin/bash

gawk -F',' '{
  listen[$2]++;
}
END {
  for (key in listen) {
    print key "," listen[key] > "temp/1_count_songs.txt"
  }
}' original/triplets_final.txt

gawk -F',' '
FNR==NR {
  hash[$1][1]=$5;
  hash[$1][2]=$4;
}
FNR<NR {
  print hash[$1][1] "," hash[$1][2] "," $2 > "temp/1_songs.txt"
}' original/songs_final.txt temp/1_count_songs.txt

cat temp/1_songs.txt | sort -t ',' -k 3 -n -r | head > task1_output.txt

