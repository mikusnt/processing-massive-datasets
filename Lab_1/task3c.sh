#!/bin/bash

# tworzenie tablicy hashowej [klucz - id piosenki] [wartość - artysta]
# zapis wszystkich artystow z listy odsluchan triplets_final do pliku tymczasowego
gawk -F',' '
# FNR - aktualna linia w biezacym pliku, resetuje się po przejściu do drugiego pliku
# NR - globalny lumer linii, nie resetuje się
# jesli analizowane linie pierwszego pliku, stwórz tablicę hashową
FNR==NR {
  hash[$1]=$4;
}
FNR<NR {
# jeśli analizowane linie drugiego pliku, zapisz artystę każdego odsłuchania do pliku tymczasowego
  print hash[$2] > "temp/3_artists.txt"
}' original/songs_final.txt original/triplets_final.txt

# liczenie w tablicy hashowej (domyślna wartość 0) liczby wystąpień poszczególnych artystów
# [klucz - nazwa artysty] [wartość - liczba odsłuchań]
gawk -F',' '{
# dla kazdego wiersza pliku tymczasowego generuj tablicę hashową
  listen[$1]++;
}
# po zakończeniu przeglądania pliku tymczasowego, każdy klucz i wartość z tablicy hashowej zapisz do kolejnego pliku tymczasowego
END {
  for (key in listen) {
    print key "," listen[key] > "temp/3_count_artists.txt"
  }
}' temp/3_artists.txt

# sortowanie malejące po drugiej kolumnie z wykorzystaniem separatora (-n sortowanie wartości kolumny jako liczby)
# wypisanie pierwszej wartości do pliku task3_output.txt
sort -t ',' -k 2 -n -r temp/3_count_artists.txt | head -n 1 > task3_output.txt

