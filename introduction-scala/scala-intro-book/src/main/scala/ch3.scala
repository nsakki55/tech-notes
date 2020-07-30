import scala.util.Try
def plus(opt1: Option[Int], opt2: Option[Int]): Option[Int] = {
  opt1.flatMap(i => opt2.map(j => i + j))
}

plus(Option(2), Option(4)).foreach(println)

def div(a: Int, b: Int): Try[Int] = Try(a / b)
div(10, 3).foreach(println)
div(10, 0).failed.foreach(println)
div(10, 3).map(_ * 4)
div(10, 3).flatMap(i => div(10, 2))

div(10, 3).getOrElse(-1)
