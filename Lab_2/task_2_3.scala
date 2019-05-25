// Zadanie 2.3: Przyblizenie PI

var n = 100000
var x = 1 to n
var iterations = 10

for (iteration <- 1 to iterations) {
  val pi_by_4 = sc.parallelize(x).filter { _ =>
    val x = math.random
    val y = math.random
    x*x + y*y < 1
}.count()

  var text = f"$iteration%2.0f: π value is ~ " + 4.0 * pi_by_4 / n
  println(text)
}
