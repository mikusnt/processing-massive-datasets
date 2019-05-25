#!/bin/bash

# generowanie tablicy hashowej [klucz - id daty] [wartość - miesiąc] gdy czytamy z dates_final.txt
#zapisywanie do pliku tymczasowego miesiąca dla każdego rekordu z triplets_final.txt
gawk -F',' '
FNR==NR {
  hash[$1]=$3;
}
FNR<NR {
  print hash[$3] > "temp/4_months.txt"
}' original/dates_final.txt original/triplets_final.txt

# sortowanie po miesiącu roznąco
# obliczenie sumy wystąpień poszczególnych miesięcy, wynikiem suma wystąpień dla każdego miesiąca, wymagane aby dane wejściowe były posortowane rosnąco
# zapis wyniku do pliku
sort -t "," -n temp/4_months.txt | uniq -c > task4_output.txt





