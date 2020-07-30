class Point(val x: Int, val y: Int) {
  def distance(that: Point): Int = {
    val xdiff = math.abs(this.x - that.x)
    val ydiff = math.abs(this.y - that.y)
    math.sqrt(xdiff * xdiff + ydiff * ydiff).toInt
  }

  def +(that: Point): Point = {
    new Point(this.x + that.x, this.y + that.y)
  }
}

val p1: Point = new Point(3, 4)
val p2: Point = new Point(5, 6)
println(p1.distance(p2))
println(p1+p2)

abstract class Shape {
  def draw(): Unit = {
    println("nazo")
  }
}

class Triangle extends Shape {
  override def draw(): Unit = {
    println("triange")
  }
}

class Rectangle extends Shape {
  override def draw(): Unit = {
    println("rectangle")
  }
}

class UnknownShape extends Shape

val tri = new Triangle
tri.draw()
val unknown = new UnknownShape
unknown.draw()

object Foo {
  def foo(): Unit = println("foo")
}

Foo.foo()

object Add {
  def apply(x: Int, y: Int): Int = x + y
}

println(Add(1, 3))

class Point2(val x: Int, val y: Int) {
  override def hashCode(): Int = x + y
  override def equals(that: Any): Boolean = that match {
    case that: Point => x == that.x && y == that.y
    case _ => false
  }
  override def toString(): String = "Point(" + x + "," + y +")"
}

object Point2 {
  def apply(x: Int, y: Int): Point2 = new Point2(x, y)
}

println(Point2(3, 4))

class Super {
   protected def puts(message: String): Unit = println(message)
}

class Sub extends Super {
  def sub(): Unit = puts("sub()")
}
val sub = new Sub()
sub.sub()

class Cell[A](var value: A) {
    def put(newValue: A): Unit =
      value = newValue

    def get: A = value
}

val cell = new Cell[String]("Hello")

println(cell.get)

// Threadクラスを継承
/*
new Thread {
  override def run(): Unit = {
    for(i <- 1 to 10) println(i)
  }
}.start()
*/

implicit val context = 18
def printContext(implicit ctx: Int): Unit = {
  println(ctx)
}
printContext

trait Adder[T] {
  def zero: T
  def plus(x: T, y: T): T
}

implicit object IntAdder extends Adder[Int] {
  def zero: Int = 0
  def plus(x:Int, y:Int): Int = x + y
}

implicit object StringAdder extends Adder[String] {
  def zero: String = ""
  def plus(x:String, y: String): String = x + y
}

def sum[T](list: List[T])(implicit adder: Adder[T]): T = {
  list.foldLeft(adder.zero){(x, y) => adder.plus(x, y)}
}

println(sum(List(1, 2, 3)))
println(sum(List("1", "2", "3")))
