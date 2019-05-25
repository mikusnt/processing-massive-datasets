// Task 4: Mnozenie macierz
// Odczyt
val matrix_m = sc.textFile("files/matrix_multiplication/M.txt").map(line => {
  val value = line.split("\\s+")
  (value(0).trim.toInt, value(1).trim.toInt, value(2).trim.toInt)
})
val matrix_n = sc.textFile("files/matrix_multiplication/N.txt").map(line => {
  val value = line.split("\\s+")
  (value(0).trim.toInt, value(1).trim.toInt, value(2).trim.toInt)
})

// Obliczenia
val result = (matrix_m
  .map(r => (r._2, (r._1, r._3)))
  .join(matrix_n.map(r => (r._1, (r._2, r._3))))
  .map({case (it, ((row, m_val), (column, n_val))) => ((row.toString, column.toString), m_val * n_val)})
  .reduceByKey(_ + _)
  .sortByKey(true)
)

// Wypisanie
result.collect.foreach({case ((row, column), value) => println(f"${row} ${column}\t${value}")})
