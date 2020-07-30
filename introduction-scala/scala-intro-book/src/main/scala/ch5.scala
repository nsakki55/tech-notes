//import com.sun.net.httpserver.Authenticator.Success
import scala.util.Success
import scala.util.Failure
import scala.io._
import scala.concurrent._
import ExecutionContext.Implicits.global

object HttpTextClient {
  def get(url: String): BufferedSource = Source.fromURL(url)
}

val source = HttpTextClient.get("http://www.ne.jp/asahi/hishidama/home/tech/scala/thread.html")

import scala.concurrent.Future
import scala.concurrent.ExecutionContext.Implicits.global // おまじないです *2
import scala.util._


val successFuture = Future[Int] { 100 }

val failFuture = Future {
  throw new RuntimeException("失敗じゃ")
}

successFuture.onComplete { // Futureの完了時にコールバックを渡せます
  case Success(intValue) => println(s"future success: ${intValue}")
  case Failure(_) => sys.error("ここに来ることはないだろう...")
}

failFuture.onComplete {
  case Success(_) => sys.error("ここに来ることはないだろう...")
  case Failure(exception) => println(s"future fail: ${exception}")
}

val future = Future.successful(2)
future.onComplete {
  case Success(result) => println(result)
  case Failure(t) =>
}


val responseFuture: Future[BufferedSource] =
  Future(HttpTextClient.get("http://scalamatsuri.org/"))
responseFuture.map(
  s =>
    try s.mkString
    finally s.close)
  .onComplete {
    case Success(body) => println(body)
    case Failure(t) => t.printStackTrace()
  }

import scala.concurrent.ExecutionContext.Implicits.global
val f = Future {
  throw new IllegalArgumentException()
}.recover {
  case e: IllegalArgumentException => 0
}

println(f)

import scala.concurrent._
import scala.concurrent.duration._
import scala.concurrent.ExecutionContext.Implicits.global
import scala.language.postfixOps

val f2: Future[Int] = Future((1 to 10).sum)
assert(Await.result(f2, 10 seconds) == 55)