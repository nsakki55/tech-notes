val o: Option[String] = Option("hoge")

println(o.get)

println(o.isEmpty)

println(o.isDefined)
println(o.getOrElse(""))

println(o.getOrElse(throw new RuntimeException("null はだめだよ")))

println(Some(3).map(_ * 3))

val n: Option[Int] = None
println(n.map(_ * 3))

//n.fold(throw new RuntimeException)(_ * 3)
println(Some(3).fold(throw new RuntimeException)(_ * 3))

val v1: Option[Int] = Some(3)
// v1: Option[Int] = Some(3)

val v2: Option[Int] = None
// v2: Option[Int] = Some(5)

println(v1.map(i1 => v2.map(i2 => i1 * i2)).flatten)

val s1: Option[Int] = Some(2)
val s2: Option[Int] = Some(3)
val s3: Option[Int] = Some(5)
val s4: Option[Int] = Some(7)
val s5: Option[Int] = Some(11)

val result = s1.map {i1 =>
  s2.map {i2 =>
    s3.map {i3 =>
      s4.map {i4 =>
        s5.map {i5 => i1 * i2 * i3 * i4 * i5}
      }.flatten
    }.flatten
  }.flatten
}.flatten

println(result)

val v3: Option[Int] = Some(4)
println(v1.flatMap(i1 => v1.map(i2 => v3.map(i3 => i1 * i2 * i3))))

val v4: Option[Int] = None
println(v1.flatMap(i1 => v1.map(i2 => v4.map(i4 => i1 * i2 * i4))))

val result2 = s1.flatMap (i1 =>
  s2.map {i2 =>
    s3.map {i3 =>
      s4.map {i4 =>
        s5.map {i5 => i1 * i2 * i3 * i4 * i5}
      }
    }
  }
)

val r2 = for {
  i1 <- s1
  i2 <- s2
  i3 <- s3
  i4 <- s4
  i5 <- s5} yield i1 * i2 * i3 * i4 * i5
println(r2)


val e1: Either[String, Int] = Right(123)
val e2: Either[String, Int] = Left("abc")

e1 match {
  case Right(i) => println(i)
  case Left(s) => println(s)
}

e2 match {
  case Right(i) => println(i)
  case Left(s) => println(s)
}

sealed trait LoginError
case object InvalidPassword extends LoginError
case object UserNotFound extends LoginError
case object PasswordLocked extends LoginError

case class User(id: Long, name: String, password: String)


/*
object LoginService{
  def login(name: String, password: String): Either[LoginError, User] = ???
}
LoginService.login(name="dwango", password = "password") match {
  case Right(user) => println(s"id: ${user.id}")
  case Left(InvalidPassword) => println(s"Invalid Paswword")
}
*/

val v: Either[String, Int] = Right(123)
println(v.map(_ * 2))

val V2: Either[String, Int] = Left("a")
println(v2.map(_ * 2))

/*
def f(x: Any): Unit = println("f")
def g(): Unit = println("g")
f(g())
 */

def g(): Unit = println("g")
def f(g: => Unit): Unit = {
  println("prologue f")
  g
  println("epilogue f")
}

f(g())

import scala.util.Try

val t: Try[Int] = Try(throw new RuntimeException("to be caught"))
val t1 = Try(3)
val t2 = Try(5)
val t3 = Try(7)

val mul = for {
  i1 <- t1
  i2 <- t2
  i3 <- t3
} yield i1 * i2 * i3

println(mul)

object Main {

  case class Address(id: Int, name: String, postalCode: Option[String])

  case class User(id: Int, name: String, addressId: Option[Int])

  val userDataBase: Map[Int, User] = Map(
    1 -> User(1, "太郎", Some(1)),
    2 -> User(2, "二郎", Some(2)),
    3 -> User(3, "プー太郎", None)
  )

  val addressDataBase: Map[Int, Address] = Map(
    1 -> Address(1, "渋谷", Some("150-0002")),
    2 -> Address(2, "国際宇宙ステーション", None)
  )

  sealed abstract class PostalCodeResult

  case class Success(postalCode: String) extends PostalCodeResult

  abstract class Failure extends PostalCodeResult

  case object UserNotFound extends Failure

  case object UserNotHasAddress extends Failure

  case object AddressNotFound extends Failure

  case object AddressNotHasPostalCode extends Failure

  def getPostalCodeResult(userId: Int): PostalCodeResult = {
    (for {
      user <- findUser(userId)
      address <- findAddress(user)
      postalCode <- findPostalCode(address)
    } yield Success(postalCode)).merge
  }

  def findUser(userId: Int): Either[Failure, User] = {
    userDataBase.get(userId).toRight(UserNotFound)
  }

  def findAddress(user: User): Either[Failure, Address] = {
    for {
      addressId <- user.addressId.toRight(UserNotHasAddress)
      address <- addressDataBase.get(addressId).toRight(AddressNotFound)
    } yield address
  }

  def findPostalCode(address: Address): Either[Failure, String] = {
    address.postalCode.toRight(AddressNotHasPostalCode)
  }

  def main(args: Array[String]): Unit = {
    println(getPostalCodeResult(1)) // Success(150-0002)
    println(getPostalCodeResult(2)) // AddressNotHasPostalCode
    println(getPostalCodeResult(3)) // UserNotHasAddress
    println(getPostalCodeResult(4)) // UserNotFound
  }
}

Main.main()