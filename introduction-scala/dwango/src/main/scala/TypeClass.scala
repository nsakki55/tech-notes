object Nums {
  trait Num[A]{
    def plus(a: A, b: A): A
    def minus(a: A, b: A): A
    def multiply(a: A, b: A): A
    def divide(a: A, b: A): A
    def zero: A
  }
  object Num{
    implicit object IntNum extends Num[Int]{
      def plus(a: Int, b: Int): Int = a + b
      def minus(a: Int, b: Int): Int = a - b
      def multiply(a: Int, b: Int): Int = a * b
      def divide(a: Int, b: Int): Int = a / b
      def zero: Int = 0
    }

    implicit object DoubleNum extends  Num[Double] {
      def plus(a: Double, b: Double):  Double = a + b
      def minus(a: Double, b: Double): Double = a - b
      def multiply(a: Double, b: Double): Double = a * b
      def divide(a: Double, b: Double): Double = a / b
      def zero: Double = 0
    }
  }
}

object FromInts {
  trait FromInt[A]{
    def to(from: Int): A
  }
  object FromInt {
    implicit object FromIntToInt extends FromInt[Int] {
      def to(from: Int): Int = from
    }
    implicit object FromIntToDouble extends FromInt[Double] {
      def to(from: Int): Double = from
    }
  }
}
import Nums._
import FromInts._

def average[A](lst: List[A])(implicit a: Num[A], b: FromInt[A]): A = {
  val length: Int = lst.length
  val sum: A  = lst.foldLeft(a.zero)((x, y) => a.plus(x, y))
  a.divide(sum, b.to(length))
}

println(average(List(1, 3, 5)))
// res0: Int = 3
println(average(List(1.5, 2.5, 3.5)))

println(List(1, 2, 3, 4).max)
println(List(1, 2, 3, 4).min)

def median[A:Num:Ordering:FromInt](lst: List[A]): A = {
  val num = implicitly[Num[A]]
  val ord = implicitly[Ordering[A]]
  val int = implicitly[FromInt[A]]
  val size = lst.size
  require(size > 0)
  val sorted = lst.sorted
  if(size % 2 == 1) {
    sorted(size / 2)
  } else {
    val fst = sorted((size / 2) - 1)
    val snd = sorted((size / 2))
    num.divide(num.plus(fst, snd), int.to(2))
  }
}


println(median(List(1, 3, 2)))

object Serializers {
  trait Serializer[A] {
    def serialize(obj: A): String
  }
  def string[A:Serializer](obj: A): String = {
    implicitly[Serializer[A]].serialize(obj)
  }
  implicit object IntSerializer extends Serializer[Int] {
    def serialize(obj: Int): String = obj.toString
  }
  implicit object StringSerializer extends Serializer[String] {
    def serialize(obj: String): String = obj
  }
  implicit def ListSerializer[A](implicit serializer: Serializer[A]): Serializer[List[A]] = new Serializer[List[A]]{
    def serialize(obj: List[A]): String = {
      val serializedList = obj.map{o => serializer.serialize(o)}
      serializedList.mkString("[",",","]")
    }
  }
}
import Serializers._
println(string(List(1, 2, 3))) // [1,2,3]
println(string(List(List(1),List(2),List(3))))

class MyKlass(val x: Int)
implicit object MyKlassSerializer extends Serializer[MyKlass] {
  def serialize(klass: MyKlass): String = s"MyKlass(${klass.x})"
}
println(string(new MyKlass(1)))