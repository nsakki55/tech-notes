trait TraitA
trait TraitB
class ClassA
class ClassB

class ClassC extends ClassA with TraitA with TraitB
//class ClassD extends ClassA with ClassB

class ClassA_t extends TraitA
object ObjectA {
  val a = new ClassA_t
}

trait TraitD {
  val name: String
  def pritnName(): Unit = println(name)
}

class ClassD(val name: String) extends TraitD

object ObjectD {
  val a = new ClassD("downgo")
  val a2 = new TraitD {val name="kadokawa"}
}

trait TraitE {
  def greet(): Unit
}

trait TraitF extends TraitE {
  override def greet(): Unit = println("Good morning!")
}

trait TraitG extends TraitE {
  override def greet(): Unit = println("Good evening!")
}

class ClassE extends TraitF with TraitG {
  override def greet(): Unit = println("How are you!")
}

class ClassF extends TraitF with TraitG {
  override def greet(): Unit = {
    super[TraitF].greet()
    super[TraitG].greet()
  }
}

(new ClassE).greet()
(new ClassF).greet()

class ClassH extends TraitF with TraitG
(new ClassH).greet()

trait GreetA {
  def greet(): Unit = println("Hello")
}

trait GreetB extends GreetA {
  override def greet(): Unit = {
    super.greet()
    println("My name is Terebi")
  }
}

trait GreetC extends GreetA{
  override def greet(): Unit = {
    super.greet()
    println("I like niconico")
  }
}

class ClassGreetA extends GreetB with GreetC
class ClassGreetB extends GreetC with GreetB

(new ClassGreetA).greet()
(new ClassGreetB).greet()

trait A {
  val foo: String
}

trait B extends A {
  lazy val bar = foo + "World"
  // def bar = foo + "World"
}

class C extends B {
  val foo = "Hello"

  def printBar(): Unit = println(bar)
}

(new C).printBar()

class D extends {
  val foo = "Hello"
} with B {
  def printBar(): Unit=println(bar)
}

(new D).printBar()