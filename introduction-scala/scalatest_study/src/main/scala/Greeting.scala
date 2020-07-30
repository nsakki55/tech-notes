class Greeting {
  def createMessage(targetName: String): String = {
    require(targetName.nonEmpty)
    "Hello" + targetName
  }
}
