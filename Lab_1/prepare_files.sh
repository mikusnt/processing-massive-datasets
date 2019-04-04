#!/bin/bash

#echo "changing coding" 
#iconv -t UTF-8 -f ISO-8859-2 original/unique_tracks.txt > original/unique_tracksi.txt
#iconv -t UTF-8 -f ISO-8859-2 original/triplets_sample_20p.txt > original/triplets_sample_20pi.txt

echo "change separators..."
sed 's/<SEP>/,/g' original/unique_tracks.txt > original/unique_tracks_uns.txt
sed 's/<SEP>/,/g' original/triplets_sample_20p.txt > original/triplets_uns.txt
# separator will be ","

echo "creating files from triplets..."

mkdir -p temp
gawk -F',' '{
  # start date block
  ymd = strftime("%Y-%m-%d", $3);
  date[ymd] = 1
  print $1 "," $2 "," ymd > "temp/triplets_d.txt"
  # end date block
  
  # start user block
  user[$1] = 1
  # end user block
}
END {
  # start date block
  n = asorti(date, indexes1);
  for (i = 1; i <= n; i++) {
    split(indexes1[i], array, "-");
    print i "," indexes1[i] "," array[1] "," array[2] "," array[3] > "temp/dates.txt"
  }
  # end date block
  
  # start user block
  n = asorti(user, indexes2);
  for (i = 1; i <= n; i++) {
    print i "," indexes2[i] > "original/users_final.txt"
  }
  # end user block
}' original/triplets_uns.txt

echo "adding key to unique_tracks.txt"

cat original/unique_tracks_uns.txt | sort -t "," -k 2 > temp/songs.txt
gawk -F',' '{
    print ++i "," $2 "," $1 "," $3 "," $4 > "original/songs_final.txt"
}' temp/songs.txt

echo "updating triplets..."

gawk -F',' '{
    if (FILENAME == "temp/dates.txt") {
        dates[$2] = $1
    }
    if (FILENAME == "original/users_final.txt") {
        users[$2] = $1
    }
    if (FILENAME == "original/songs_final.txt") {
        songs[$2] = $1
    }
    if (FILENAME == "temp/triplets_d.txt") {
        print users[$1] "," songs[$2] "," dates[$3] > "original/triplets_final.txt"
    }
    
}' temp/dates.txt original/users_final.txt original/songs_final.txt temp/triplets_d.txt

echo "removing temp data"

cat temp/dates.txt | cut -d "," -f1,3-5 > original/dates_final.txt
#rm -f temp/*

