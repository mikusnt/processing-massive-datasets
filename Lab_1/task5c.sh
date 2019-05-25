#!/bin/bash

# zapisanie do pliku id wszystkich utworów zespołu Queen
gawk -F $',' '{
  if ($4 == "Queen") {
    print $1 > "temp/5_queen_songs.txt"
  }
}' original/songs_final.txt

# liczenie ile razy odsłuchali dany utwór Queen poszczególni użytkownicy oraz wygenerowanie listy piosenek Queen jakie odsłuchali poszczególni użytkownicy
gawk -F',' '
# tworzenia tablicy hashowej gdzie kluczem są wszystkie tytuły zespołu Queen, wartości dla danego klucza są niezerowe, dla każdej innej piosenki niż Queen wartość to 0
FNR==NR {
  hash[$1]=1
}
FNR<NR {
# jeśli wskazana piosenka jest od Queen zwiększ licznik dla tablicy hashowej z liczbą odsłuchań dla poszczególnych piosenek ()
  if (hash[$2]==1) {
    songs[$2]++
    # oznaczenie, że użytkownik odsłuchał dany utwór Queen
    users_songs[$1][$2]=1
  }
}
END {
# wypisanie liczby odsluchań dla poszczególnych utworów do pliku
  for (song in songs) {
    print song "," songs[song] "," > "temp/5_queen_counter.txt"
  }
  # wypisanie piosenek jakie odsłuchali poszczególni użytkownicy
  for (user in users_songs) {
    for (song in users_songs[user]) {
        print user "," song > "temp/5_users_songs.txt" 
    }
  }
}' temp/5_queen_songs.txt original/triplets_final.txt
# posortowanie malejąco tytułów piosenek Queen według liczby odsłuchań
# wyciągnięcie trzech piosenek z największą wartościa odsłuchań
# pozostawienie tylko pierwszej kolumny czyli nazw utworów
# zapis do pliku
cat temp/5_queen_counter.txt | sort -t "," -k 2 -n -r | head -n 3 | cut -d "," -f 1 > temp/5_queen_most.txt

# budowanie tablicy hashowej [klucz - tytuł najpopularniejszej piosenki Queen (1 z 3)] [wartość - niezerowa]
# stworzenie tablicy hashowej która przechowuje informacje o tym, że dany użytownik przesłuchał jedną z tych najpopularniejszych piosenek
# wypisanie do pliku wszystkich użytowników, którzy odsłuchali wszystkie trzy najpopularniejsze piosenki
gawk -F',' '
FNR==NR {
  queen_most[$1]=1
}
# 
FNR<NR {
 # dla każdej najpopularniejszej piosenki sprawdź czy użytownik słuchający Queen ją przesłuchał, jeśli tak dodaj do słownika
  for (key in queen_most) {
    if ($2 == key) {
        counter[$1][$2]=1
    }
  }
}
END {
# dla każdego użytkownika ktory odsłuchał najpopularniejsze piosenki Queen
  for (user in counter) {
  # sprawdź czy istnieją wartości dla wszystkich trzech piosenek, jeśli odsłuchał mniej niż trzy to długość teblicy będzie mniejsza
        if (length(counter[user]) == 3)
        # jeśli tak to zapisz do pliku
        print user > "temp/5_all_queen_users.txt"
  }
}' temp/5_queen_most.txt temp/5_users_songs.txt


# użytkownicy przechowywani jako klucz sztuczny, transformacja klucza sztucznego na ten oryginalny za pomocą tablicy hashowej
gawk -F',' '
FNR==NR {
  hash[$1]=$2
}
FNR<NR {
  print hash[$1] > "temp/5_all_queen_users2.txt"
}' original/users_final.txt temp/5_all_queen_users.txt

# sortowanie oryginalnych id użytkownika
sort temp/5_all_queen_users2.txt > task5_output.txt
