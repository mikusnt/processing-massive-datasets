// Zadanie 5.1: 10 najpopularniejszych piosenek

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
triplets.groupBy("song_id").
  count().
  join(songs, "song_id").
  select("title", "artist", "count").
  orderBy(desc("count")).
  show(10, false)
