// Zadanie 3: Agregacja danych

// Generowanie grup i losowych danych
import scala.util.Random
val m = 1000
val random = Random
val groups = Map((for (i <- 0 to m) yield {
    val mu = random.nextDouble()*10-5
    val std = random.nextDouble()*10-5
        (i -> (mu, std))
}): _*)
        
val n = 1000000

val data = for(i <- 1 to n) yield {
    val g = random.nextInt(m);
    val (mu, sigma) = groups(g); 
        (g, mu + sigma*random.nextGaussian())
}

val dataRDD = sc.parallelize(data)
dataRDD.cache()


// Rekordy (GROUP_ID, (Licznik, Suma wartości, Wartość^2))
val records = (dataRDD
  .map(t => (t._1, (1, t._2, t._2 * t._2)))
  .reduceByKey((a, b) => (a._1 + b._1, a._2 + b._2, a._3 + b._3))
)
records.cache()

// Statystyki dla grup (Group ID, (licznik, średnia, wariancja))
val groups_stats = records.map(r => (r._1, (r._2._1, r._2._2 / r._2._1, ((r._2._3 - ((r._2._2 * r._2._2) / r._2._1)) / r._2._1))))
groups_stats.collect().foreach(println)

// statystyki z grup
val all_records_group = records.reduce((a, b) => (0, (a._2._1 + b._2._1, a._2._2 + b._2._2, a._2._3 + b._2._3)))
val results_group = (all_records_group._2._1, all_records_group._2._2 / all_records_group._2._1, ((all_records_group._2._3 - ((all_records_group._2._2 * all_records_group._2._2) / all_records_group._2._1)) / all_records_group._2._1))


// Rekordy (GROUP_ID == 0, (Licznik, Suma wartości, Wartość^2))
val all_records = (dataRDD
  .map(t => (0, (1, t._2, t._2 * t._2)))
  .reduceByKey((a, b) => (a._1 + b._1, a._2 + b._2, a._3 + b._3))
)
all_records.cache()

// Statystyki z oryginalnych danych(Group ID == 0, (licznik, średnia, wariancja))
val results = all_records.map(r => (r._1, (r._2._1, r._2._2 / r._2._1, ((r._2._3 - ((r._2._2 * r._2._2) / r._2._1)) / r._2._1))))
results.collect().foreach(println)




