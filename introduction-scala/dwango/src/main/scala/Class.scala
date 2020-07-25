class Point(val x: Int, val y: Int){
  def +(p: Point): Point = {
    new Point(x + p.x, y + p.y)
  }

  override def toString: String = "(" + x + ", " + y + ")"
}

val p1 = new Point(1, 1)

val p2 = new Point(2, 2)

println(p1 + p2)

class Adder {
  def add(x: Int, y: Int): Int = x + y
}

val adder = new Adder()
// adder: Adder = repl.Session$App$Adder$2@3bb183ca

adder.add(2, 3)
// res3: Int = 5

val fun: Int => Int = adder.add(2, _)
// fun: Int => Int = <function1>
println(fun(3))
// res4: Int = 5

abstract class XY {
  def x: Int
  def y: Int
}

class APrinter() {
  def print(): Unit = {
    println("A")
  }
}

class BPrinter() extends APrinter {
  override def print(): Unit = {
    println("B")
  }
}

new APrinter().print
// A

new BPrinter().print
// B

class Point3D(val x: Int, val y:Int, val z:Int)

val p = new Point3D(10, 20, 30)

println(p.x) // 10
println(p.y) // 20
println(p.z) // 30


abstract class Shape {
  def area: Double
}

class Rectangle(val x: Double, val y: Double) extends Shape {
  override def area: Double = x * y
}

class Circle(val r: Double) extends Shape {
  override def area: Double = r * r * math.Pi
}


var shape: Shape = new Rectangle(10.0, 20.0)
println(shape.area)
shape = new Circle(2.0)
println(shape.area)