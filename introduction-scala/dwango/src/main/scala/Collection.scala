val arr = Array(1, 2, 3, 4)
arr(0) = 49
println(arr)
println(arr.length)

def swapArray[T] (arr: Array[T])(i: Int, j: Int): Array[T] = {
  val i_num = arr(i)
  val j_num = arr(j)
  arr(i) = j_num
  arr(j) = i_num
  arr
}

swapArray(arr)(0, 2)

println(arr)

println(1 to 4)

println((1 to 5).toList)
println((1 until 5).toList)

val lst = List(1 to 9)

val a1 = 1 :: Nil
println(a1)
val a2 = 2 :: a1
println(a2)
val a3 = 3 :: a2
println(a3)

val a4 = 4 :: a3
println(a4)


println(List(1, 2) ++ List(3, 4))
// res14: List[Int] = List(1, 2, 3, 4)

println(List(1) ++ List(3, 4, 5))
// res15: List[Int] = List(1, 3, 4, 5)

println(List(3, 4, 5) ++ List(1))
// res16: List[Int] = List(3, 4, 5, 1)

println(List(1, 2, 3, 4, 5).mkString)

println(List(1, 2, 3, 4, 5).mkString(","))
println(List(1, 2, 3, 4, 5).mkString("[", ",", "]"))

def joinByComma(start: Int, end: Int): String = {
  (start to end).mkString(",")
}

val join = joinByComma(1, 5)
println(join)


println(List(1, 2, 3).foldLeft(0)((x, y) => x + y))
println(List(1, 2, 3).foldLeft(1)((x, y) => x * y))

var lstFold = List(List(1), List(2, 3), List(1, 2, 3)).foldLeft(Nil: List[Int])(_ ++ _)
println(lstFold)

def reverse[T](list: List[T]): List[T] = {
  list.foldLeft(Nil: List[T])((a, b) => b :: a)
}
println(reverse(List(1, 2, 3, 4)))


def sum(list: List[Int]): Int = {
  list.foldRight(0)((y, x) => y + x)
}

println(sum(List(1, 2, 3, 4)))

def mul(list: List[Int]): Int = {
  list.foldRight(1)((y, x) => y * x)
}

println(mul(List(1, 2, 3, 4)))

def mkString[T](list: List[T])(sep: String): String = list match {
  case Nil => ""
  case x::xs => xs.foldLeft(x.toString){(x, y) => x + sep + y}
}

println(mkString(List(1, 2, 3, 4))(", "))

println(List(1, 2, 3, 4, 5).map(x => x*2))

def map[T, U](list: List[T])(f: T => U): List[U] = {
  list.foldLeft(Nil: List[U]){(x, y) => f(y) :: x}.reverse
}

println( map(List(1, 2, 3))(x => x + 1))

println(List(1, 2, 3, 4, 5).filter(x => x % 2 == 1))

def filter[T](list: List[T])(f: T => Boolean): List[T] = {
  list.foldLeft(Nil: List[T]){(x, y) => if(f(y)) y:: x  else x }.reverse
}

println(filter(List(1, 2, 3))(x => x % 2 == 0))

println(List(1, 2, 3, 4, 5).find(x => x % 2 == 1))

def find[T](list: List[T])(f: T => Boolean): Option[T] = list match {
  case x::xs if f(x) => Some(x)
  case x::xs => find(xs)(f)
  case _ => None
}

println(find(List(1, 2, 3))(x => x == 2))
println(find(List(1, 2, 3))(x => x > 3))

println(List(1, 2, 3, 4, 5).takeWhile(x => x != 5))

def takeWhile[T](list: List[T])(f: T => Boolean): List[T] = {
  list match {
    case x::xs if f(x) =>
      x::takeWhile(xs)(f)
    case _ => Nil
  }
}
println(takeWhile(List(1, 2, 3, 4, 5))(x => x <= 3))

println(List(1, 2, 3, 4, 5).count(x => x % 2 == 0))

def count[T](list: List[T])(f: T => Boolean): Int = {
  list.foldLeft(0)((x, y) => if(f(y)) x+1 else x)
}
println(count(List(1, 2, 3, 3, 2, 2))(x => x == 2))
println(count(List(1, 2, 3, 3, 2, 2))(x => x == 1))


println(List(List(1, 2, 3), List(4, 5)).flatMap(e => e.map{g => g + 1}))
println(List(1, 2, 3).flatMap{e => List(4, 5).map(g => e * g)})


def flatMap[T, U](list: List[T])(f: T => List[U]): List[U] = {
  list match {
    case Nil => Nil
    case x::xs => f(x) ::: flatMap(xs)(f)
  }
}
println(flatMap(List(1, 2))(x =>
  map(List(3, 4))(y => x * y)
))


println(5 :: List(1, 2, 3, 4))
println(List(1, 2, 3, 4) :+ 5)

println(Vector(1, 2, 3, 4, 5))

println(6 +: Vector(1, 2, 3, 4, 5))
println(Vector(1, 2, 3, 4, 5) :+ 4)
println(Vector(1, 2, 3, 4, 5).updated(2, 4))

val m = Map("A" -> 1, "B" -> 2, "C" -> 3)
println(m.updated("B", 4))
println(m)

import scala.collection.mutable

val m2 = mutable.Map("A" -> 1, "B" -> 2, "C" -> 3)
m2("B") = 5
println(m2)

val s = Set(1, 1, 2, 3, 4, 5)
println(s - 5)


val s2 = mutable.Set(1, 1, 2, 3, 4, 5)
s2 -= 5
println(s2)