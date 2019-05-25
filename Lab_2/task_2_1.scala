// Zadanie 2.1: Liczenies słów
 
val source = sc.textFile("files/all-shakespeare.txt")
val counts = (source.flatMap(line => line.split("\\s+"))
              .map(word => (word, 1))
              .reduceByKey(_ + _)
              .sortBy(- _._2))
counts.toDF.show
counts.saveAsTextFile("output/task_2_1")
