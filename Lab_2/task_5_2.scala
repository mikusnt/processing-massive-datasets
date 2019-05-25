// Zadanie 5.2: 10 użytkowników z największą liczbą odsłuchań unikalnych utworów

// Odczytywanie listy odtworzen
 val triplets = spark.read.
  option("sep",",").
  csv("../Lab_1/original/triplets_final.txt").
  toDF("user_id", "song_id", "date_id")

// Odczytywanie listy użytkowników
val users = spark.read.
  option("sep",",").
  csv("../Lab_1/original/users_final.txt").
  toDF("user_id", "old_user_id")
  
// Zapytanie
triplets.select("user_id", "song_id").
  groupBy("user_id", "song_id").
  count().
  filter(col("count") === 1).
  select("user_id").
  groupBy("user_id").
  count().
  orderBy(desc("count")).
  join(users, "user_id").
  select("old_user_id").
  show(10)
