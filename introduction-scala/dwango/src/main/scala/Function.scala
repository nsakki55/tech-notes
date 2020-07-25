//val add = (x: Int, y: Int) => x + y
//println(add(1, 2))

val addCurried = (x: Int) => (y: Int) => x + y

println(addCurried)
println(addCurried(1)(2))

def add(x: Int, y: Int): Int = x + y
println(add _)

def addMultiParameterList(x: Int)(y: Int): Int = x + y

println(addMultiParameterList _)

def double(n: Int, f: Int => Int): Int = {
  f(f(n))
}

println(double(1, m => m * 2))
// res4: Int = 4

println(double(2, m => m * 3))
// res5: Int = 18

println(double(3, m => m * 4))
// res6: Int = 48

def around(init: () => Unit, body: () => Any, fin: () => Unit): Any = {
  init()
  try {
    body()
  } finally {
    fin()
  }
}

around(
  () => println("ファイルを開く"),
  () => println("ファイルに対する処理"),
  () => println("ファイルを閉じる")
)

/*
around(
  () => println("ファイルを開く"),
  () => throw new Exception("例外発生！"),
  () => println("ファイルを閉じる")
)
*/

import scala.io.Source
def withFile[A](filename: String)(f: Source => A): A = {
  val s = Source.fromFile(filename)
  try {
    f(s)
  } finally {
    s.close()
  }
}

def printFile(filename: String): Unit = {
  withFile(filename) {
    file => file.getLines.foreach(println)
  }
}