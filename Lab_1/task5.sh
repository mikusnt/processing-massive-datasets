#!/bin/bash

# utwory od queen [nowe id]
# join utworow queen z lista odsluchan [id utworu, id uzytkownika]
# wyszukanie trzech najpopularniejszych [id utworu]
# 

gawk -F $',' '{
  if ($4 == "Queen") {
    print $1 > "temp/5_queen_songs.txt"
  }
}' original/songs_final.txt

gawk -F',' '
FNR==NR {
  hash[$1]=1
}
FNR<NR {
  if (hash[$2]==1) {
    songs[$2]++
    users_songs[$1][$2]=1
  }
}
END {
  for (song in songs) {
    print song "," songs[song] "," > "temp/5_queen_counter.txt"
  }
  for (user in users_songs) {
    for (song in users_songs[user]) {
        print user "," song > "temp/5_users_songs.txt" 
    }
  }
}' temp/5_queen_songs.txt original/triplets_final.txt

cat temp/5_queen_counter.txt | sort -t "," -k 2 -n -r | head -n 3 | cut -d "," -f 1 > temp/5_queen_most.txt

gawk -F',' '
FNR==NR {
  queen_most[$1]=1
}
FNR<NR {
  for (key in queen_most) {
    if ($2 == key) {
        counter[$1][$2]=1
    }
  }
}
END {
  for (user in counter) {
        if (length(counter[user]) == 3)
        print user > "temp/5_all_queen_users.txt"
  }
}' temp/5_queen_most.txt temp/5_users_songs.txt


gawk -F',' '
FNR==NR {
  hash[$1]=$2
}
FNR<NR {
  print hash[$1] > "temp/5_all_queen_users2.txt"
}' original/users_final.txt temp/5_all_queen_users.txt

sort temp/5_all_queen_users2.txt > task5_output.txt
