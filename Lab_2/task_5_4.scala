// Zadanie 5.4: Odsłuchania piosenek w poszczególnych miesiącach

// Odczytywanie listy odtworzen
 val triplets = spark.read.
  option("sep",",").
  csv("../Lab_1/original/triplets_final.txt").
  toDF("user_id", "song_id", "date_id")
  
// Odczytywanie dat
val dates = spark.read.
  option("sep",",").
  csv("../Lab_1/original/dates_final.txt").
  toDF("date_id","year","month","day")

// Zapytanie
triplets.select("date_id").
  join(dates, "date_id").
  groupBy("month").
  count().
  orderBy(asc("month")).
  select("month", "count").
  show(false)
