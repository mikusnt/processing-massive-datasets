#!/bin/bash

gawk -F',' '
FNR==NR {
  hash[$1]=$3;
}
FNR<NR {
  print hash[$3] > "temp/4_months.txt"
}' original/dates_final.txt original/triplets_final.txt


sort -t "," -n temp/4_months.txt | uniq -c > task4_output.txt





