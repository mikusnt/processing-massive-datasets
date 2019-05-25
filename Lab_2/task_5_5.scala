// Zadanie 5.5: 10 Użytkownicy odsłuchujący 3 najpopularniejsze utwory zespołu Queen

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
  
// Odczytywanie listy użytkowników
val users = spark.read.
  option("sep",",").
  csv("../Lab_1/original/users_final.txt").
  toDF("user_id", "old_user_id")

// najpopularniejsze utwory Queen
val most_queen_songs = triplets.groupBy("song_id").
  count().
  join(songs, "song_id").
  filter(col("artist") === "Queen").
  orderBy(desc("count")).
  select("title", "song_id").
  limit(3)

// użytkownicy odsłuchujący 3 najpopularniejsze utwory
triplets.select("song_id", "user_id").
  join(most_queen_songs, "song_id").
  groupBy("user_id", "song_id").
  count().
  select("user_id").
  groupBy("user_id").
  count().
  filter(col("count") === 3).
  join(users, "user_id").
  orderBy(asc("old_user_id")).
  select("old_user_id").
  show(10, false)
