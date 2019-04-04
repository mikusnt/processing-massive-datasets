#!/bin/bash

cat original/triplets_final.txt | cut -d "," -f 1,2 | uniq > temp/2_triplets.txt 
gawk -F',' '{
  count[$1]++
}
END {
  for (key in count) {
    print key "," count[key] > "temp/2_users_count.txt"
  }
}' temp/2_triplets.txt

cat temp/2_users_count.txt | sort -t "," -k 2 -n -r | head > temp/2_users_ranking.txt

gawk -F',' '
FNR==NR {
  hash[$1]=$2;
}
FNR<NR {
  print hash[$1] "," $2 > "task2_output.txt"
}' original/users_final.txt temp/2_users_ranking.txt

