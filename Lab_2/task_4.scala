/*
 * -- Task 4: Matrix multiplication --
 */

// Read matrices and prepare format
val matrix_m = sc.textFile("files/matrix_multiplication/M.txt").map(line => {
  val value = line.split("\\s+")
  (value(0).trim.toInt, value(1).trim.toInt, value(2).trim.toInt)
})
val matrix_n = sc.textFile("files/matrix_multiplication/N.txt").map(line => {
  val value = line.split("\\s+")
  (value(0).trim.toInt, value(1).trim.toInt, value(2).trim.toInt)
})

// At the beginning map data to correct format - column in one, rows in second (required by multiplication action)
// Next calculate value and reduce by key to sum elements
// As last operation - sort by key with ascending enabled
val result = (matrix_m
  .map(r => (r._2, (r._1, r._3)))
  .join(matrix_n.map(r => (r._1, (r._2, r._3))))
  .map({case (it, ((m_index, m_val), (n_index, n_val))) => ((m_index.toString, n_index.toString), m_val * n_val)})
  .reduceByKey(_ + _)
  .sortByKey(true)
)

// Print result of multiplication action
result.collect.foreach({case ((index_i, index_j), value) => println(f"${index_i} ${index_j}\t${value}")})
