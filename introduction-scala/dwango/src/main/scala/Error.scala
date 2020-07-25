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

