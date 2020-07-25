class Point(val x:Int, val y:Int)

object Point {
  def apply(x: Int, y: Int): Point = new Point(x, y)
}

case class Point2(x: Int, y:Int)

class Person(name: String, age: Int, private val weight: Int)

object Hoge {
  def printWeight(): Unit = {

   val taro = new Person("Taro", 20, 70)
    println(taro.weight)
  }}

object Person {
  def printWeight(): Unit = {

    val taro = new Person("Taro", 20, 70)
    println(taro.weight)
  }
}

class Dog(age: Int, owner: String, private[this] val price: Int)

object Fuga {
  def printPrice(): Unit = {
    val besu = new Dog(2, "Jiro", 200)
    println(besu.price)
  }
}

object Dog {
  def printPrice(): Unit = {
    val besu = new Dog(2, "Jiro", 200)
    println(besu.price)
  }
}



