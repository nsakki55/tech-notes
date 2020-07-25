var age = 17

if (age < 18) {
  "18歳未満です"
} else {
  "18歳以上です"
}

age = 18

if(age < 18) {
  "18歳未満です"
} else {
  "18歳以上です"
}

// 練習問題
var age2: Int = 5
var isSchoolStarted: Boolean = false

if (1 <= age2 && age2 <= 6 && !isSchoolStarted) {
  println("幼児です")
} else {
  println("幼児ではありません")
}

var i = 1
// i: Int = 1

while(i <= 10) {
  println("i = " + i)
  i = i + 1
}


def loopFrom0To9(): Unit = {
  var i = 0
  do {
    println(i)
    i += 1
  } while(i < 10)
}

loopFrom0To9()


def indexOf(array: Array[String], target: String): Int = {
  var index = -1
  var found = false
  var i = 0
  while (i < array.length && !found) {
    if (array(i) == target) {
      index = i
      found = true
    }
    i += 1
}
  index
}

val index = indexOf(Array("2", "5", "6"), "5")
println(index)

def indexOfGood(array: Array[String], target: String): Int = {
  var i = 0
  while (i < array.length) {
    if (array(i) == target) return i
      i += 1
  }
  -1
}

for(x <- 1 to 5; y <- 1 until 5){
  println("x = " + x + "y = " + y)
}

for(x <- 1 to 5; y <- 1 until 5 if x != y){
  println("x = " + x + "y = " + y)
}

for (e <- List("A", "B", "C", "D", "E")) println(e)

val Pre_list = for (e <- List("A", "B", "C", "D", "E")) yield {
  "Pre" + e
}

println(Pre_list)

/*
for (a <- 1 to 1000; b <- 1 to 1000; c <- 1 to 1000 if Math.pow(a, 2) == Math.pow(b, 2) + Math.pow(c, 2)) {
  println("a = " + a + "b = " + b + "c = " + c)
}
 */

val taro = "Taro"

val result = taro match {
  case "Taro" => "Nale"
  case "Jiro" => "Male"
  case "Hanako" => "Female"
}

println(result)

val one = 2

val result2 = one match {
  case 1 => "one"
  case 2 => "two"
  case _ => "other"
}

val lst = List("A", "E", "C")
// lst: List[String] = List("A", "B", "C")

lst match {
  case "A" :: b :: c ::  _ =>
    println("b = " + b)
    println("c = " + c)
  case _ =>
    println("nothing")
}

val lst2 = List(List("A"), List("B", "C"))
// lst: List[List[String]] = List(List("A"), List("B", "C"))

lst2 match {
  case List(a@List("A"), x) =>
    println(a)
    println(x)
  case _ => println("nothing")
}

(List("a"): Any) match {
  case List(_) | Some(_) =>
    println("ok")
}

import java.util.Locale
val obj: AnyRef = "String Literal"

obj match {
  case v:java.lang.Integer =>
    println("Integer")
  case v:String =>
    println(v.toUpperCase(Locale.ENGLISH))
}

for (i <- 1 to 1000){
  val s = new scala.util.Random(new java.security.SecureRandom()).alphanumeric.take(5).toList match {
    case List(a, b, c, d, _) => List(a, b, c, d, a).mkString
  }
  println(s)
}

