import java.util
import java.util.ArrayList
import java.util._
import java.util.HashSet

val set = new HashSet[String]
println(set)

val list = new util.ArrayList[String]()
println(list)

list.add("Hello")
list.add("World")
println(list)

val map = new util.HashMap[String, Int]()

map.put("A", 1)
println(Option(map.get("A")))
println(Option(map.get("D")))

import scala.jdk.CollectionConverters._
val lst = new ArrayList[String]()
lst.add("A")
lst.add("B")

println(lst)
val scalalst = lst.asScala
println(scalalst)

val bulList = scala.collection.mutable.ArrayBuffer(1 ,2 , 3)

println(bulList)
val javaList = bulList.asJava
println(javaList)



