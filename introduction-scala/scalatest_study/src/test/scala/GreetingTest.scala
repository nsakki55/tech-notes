import org.scalatest._

class GreetingTest extends FunSuite {
  test("引数の人物名に対する挨拶が生成"){
    val msg = Greeting.createMessage("John")
    assert(msg == "Hello, John")
  }

  test("引数が空文の場合、エラーが吐かれる") {
    assertThrows[IllegalArgumentException] {
      Greeting.createMessage("")
    }
  }
}
