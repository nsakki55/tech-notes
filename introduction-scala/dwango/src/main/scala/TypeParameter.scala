class Cell[A](var value: A) {
  def put(newValue: A): Unit = {
    value = newValue
  }
  def get(): A = value
}

val cell = new Cell[Int](1)
cell.put(2)
println(cell.get())

//cell.put("something")

class Pair[A, B](val a: A, val b: B) {
  override def toString(): String = "(" + a + "," + b + ")"
}

def divide(m: Int, n: Int): Pair[Int, Int] = new Pair[Int, Int](m / n , m  % n)
println(divide(7 ,3))

println((2, 3))

class PairCov[+A, +B](val a: A, val b: B) {
  override def toString(): String = "(" + a + "," + b + ")"
}

val pair: PairCov[AnyRef, AnyRef] = new PairCov[String, String]("foo", "bar")