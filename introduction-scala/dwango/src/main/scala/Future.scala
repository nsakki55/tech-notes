import scala.concurrent.{Await, Future}
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.Future
import scala.util.{Failure, Random, Success}


/*
object FutureSample extends App {
  val s = "Hello"
  val f: Future[String] = Future {
    Thread.sleep(1000)
    println(s"[ThreadName] In Future: ${Thread.currentThread.getName}")
    s + " future!"
  }

  f.foreach {case s: String =>
    println(s"[ThreadName] In Success: ${Thread.currentThread.getName}")
    println(s)
  }

  println(f.isCompleted)
  Await.ready(f, 5000.millisecond)

  println(s"[ThreadName] In App: ${Thread.currentThread.getName}")
  println(f.isCompleted)

  val f2: Future[String] = Future {
    Thread.sleep(1000)
    throw new RuntimeException("わざと失敗")
  }

  f2.failed.foreach { case e: Throwable =>
    println(e.getMessage)
  }

  println(f2.isCompleted) // false

  Thread.sleep(5000) // わざと失敗

  println(f2.isCompleted)

}


object FutureOptionUsageSample extends App {
  val random = new Random()
  val waitMaxMulliSec = 3000

  val futureMilliSec: Future[Int] = Future {
    val waitMilliSec = random.nextInt(waitMaxMulliSec)
    if(waitMilliSec < 10000) throw new RuntimeException(s"waitMilliSec is ${waitMilliSec}")
    Thread.sleep(waitMilliSec)
    waitMilliSec
  }

  val futureSec: Future[Double] = futureMilliSec.map(i => i.toDouble / 1000)

  futureSec onComplete {
    case Success(waitSec) => println(s"Success! ${waitSec} sec")
    case Failure(t) =>  println(s"Failure: ${t.getMessage}")
  }

  Thread.sleep(3000)
}

object CompositeFutureSample extends App {
  val random = new Random()
  val waitMaxMilliSec = 3000

  def waitRandom(futureName: String): Int = {
    val waitMilliSec = random.nextInt(waitMaxMilliSec)
    if(waitMilliSec < 500) throw new RuntimeException(s"${futureName} waitMilliSec is ${waitMilliSec}" )
    Thread.sleep(waitMilliSec)
    waitMilliSec
  }

  val futureFirst: Future[Int] = Future { waitRandom("first") }
  val futureSecond: Future[Int] = Future { waitRandom("second") }

  val compositeFuture: Future[(Int, Int)] = for {
    first <- futureFirst
    second <- futureSecond
  } yield (first, second)

  compositeFuture onComplete  {
    case Success((first, second)) => println(s"Success! first:${first} second:${second}")
    case Failure(t) => println(s"Failure: ${t.getMessage}")
  }

  Thread.sleep(5000)
}

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.{Await, Promise, Future}
import scala.concurrent.duration._
import scala.util.{Success, Failure}



object PromiseSample extends App {
  val promiseGetInt: Promise[Int] = Promise[Int]
  val futureByPromise: Future[Int] = promiseGetInt.future // PromiseからFutureを作ることが出来る

  // Promiseが解決されたときに実行される処理をFutureを使って書くことが出来る
  val mappedFuture = futureByPromise.map { i =>
    println(s"Success! i: ${i}")
  }

  // 別スレッドで何か重い処理をして、終わったらPromiseに値を渡す
  Future {
    Thread.sleep(300)
    promiseGetInt.success(1)
  }

  Await.ready(mappedFuture, 5000.millisecond)
}
*/

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.{Await, Future, Promise}
import scala.concurrent.duration._
import scala.util.{Failure, Random, Success}

class CallbackSomething {
  val random = new Random()

  def doSomething(onSuccess: Int => Unit, onFailure: Throwable => Unit): Unit = {
    val i = random.nextInt(10)
    if(i < 5) onSuccess(i) else onFailure(new RuntimeException(i.toString))
  }
}

class FutureSomething {
  val callbackSomething = new CallbackSomething

  def doSomething(): Future[Int] = {
    val promise = Promise[Int]
    callbackSomething.doSomething(i => promise.success(i), t => promise.failure(t))
    promise.future
  }
}

/*
object CallbackFuture extends App {
  val futureSomething = new FutureSomething

  val iFuture = futureSomething.doSomething()
  val jFuture = futureSomething.doSomething()

  val iplusj = for {
    i <- iFuture
    j <- jFuture
  } yield i + j

  val result = Await.result(iplusj, Duration.Inf)
  println(result)
}

 */