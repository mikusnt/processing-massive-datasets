// Zadanie 5.3: Artysta z najwiekszą liczbą odsłuchań

// Odczytywanie listy odtworzen
 val triplets = spark.read.
  option("sep",",").
  csv("../Lab_1/original/triplets_final.txt").
  toDF("user_id", "song_id", "date_id")

// Odczytywanie listy piosenek
val songs = spark.read.
  option("sep",",").
  csv("../Lab_1/original/songs_final.txt").
  toDF("song_id", "old_song_id", "track_id", "artist", "title")

// Zapytanie
triplets.select("song_id").
  join(songs, "song_id").
  groupBy("artist").
  count().
  orderBy(desc("count")).
  select("artist", "count").
  show(1)
