implicit def intToBoolean(arg: Int): Boolean = arg != 0

if(1){
  println("1は真なり")
}

class RichString(val src: String){
  def smile: String = src + ":)"
}

implicit def enrichString(arg: String): RichString = new RichString(arg)

println("Hi, ".smile)

object Taps {
  implicit class Tap[T](self: T) {
    def tap[U](block: T => U): T = {
      block(self) //値は捨てる
      self
    }
  }

  def main(args: Array[String]): Unit = {
    "Hello, World".tap{s => println(s)}.reverse.tap{s => println(s)}
  }
}

Taps.main(Array())

trait Additive[A]{
  def plus(a: A, b: A): A
  def zero: A
}

implicit object StringAdditive extends Additive[String] {
  def plus(a: String, b: String): String = a + b
  def zero: String = ""
}

implicit object IntAdditive extends Additive[Int] {
  def plus(a: Int, b: Int): Int = a + b
  def zero: Int = 0
}

def sum[A](lst: List[A])(implicit m: Additive[A]) = lst.foldLeft(m.zero)((x, y) => m.plus(x, y))

println(sum(List(1, 2, 3)))
println(sum(List("A", "B", "C")))

println(List[Int]().sum)
println(List(1, 2, 3, 4).sum)