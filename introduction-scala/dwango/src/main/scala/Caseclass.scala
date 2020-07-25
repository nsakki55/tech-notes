sealed abstract class DayOfWeek
case object Sunday extends DayOfWeek
case object Monday extends DayOfWeek
case object Tuesday extends DayOfWeek
case object Wednesday extends DayOfWeek
case object Thursday extends DayOfWeek
case object Friday extends DayOfWeek
case object Saturday extends DayOfWeek

val x: DayOfWeek = Sunday

x match {
  case Sunday => 1
  case Monday => 2
  case Tuesday => 3
  case Wednesday => 4
  case Thursday => 5
  case Friday => 6
  case Saturday => 7
}

sealed abstract class Exp
case class Add(lhs: Exp, rhs: Exp) extends Exp
case class Sub(lhs: Exp, rhs: Exp) extends Exp
case class Mul(lhs: Exp, rhs: Exp) extends Exp
case class Div(lhs: Exp, rhs: Exp) extends Exp
case class Lit(value: Int) extends Exp

val example = Add(Lit(1), Div(Mul(Lit(2), Lit(3)), Lit(2)))

def eval(exp: Exp): Int = exp match {
  case Add(l, r) => eval(l) + eval(r)
  case Sub(l, r) => eval(l) - eval(r)
  case Mul(l, r) => eval(l) * eval(r)
  case Div(l, r) => eval(l) / eval(r)
  case Lit(v) => v
}

println(eval(example))

case class Point(x: Int, y: Int)
val p = Point(10, 20)

println(p.x, p.y)

def nextDayOfWeek(d: DayOfWeek): DayOfWeek = {
  d match {
    case Sunday => Monday
    case Monday => Tuesday
    case Tuesday => Wednesday
    case Wednesday => Thursday
    case Thursday => Friday
    case Friday => Saturday
    case Saturday => Monday
  }
}

println(nextDayOfWeek(Monday))

sealed abstract class Tree
case class Branch(value: Int, left:Tree, right:Tree) extends Tree
case object Empty extends Tree

val tree: Tree = Branch(1, Branch(2, Empty, Empty), Branch(3, Empty, Empty))

val co = List(1, 2, 3, 4, 5).collect{ case i if i % 2 == 1 => i * 2 }
println(co)

val even: Int => Boolean = (x => x match {
  case i % 2 == 0 => true
  case _ => false
})

