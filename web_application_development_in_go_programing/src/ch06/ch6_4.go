package main

import "fmt"

type Person struct {
	Name string
	Age  int
}

type Japanese struct {
	Person
	MyNumber int
}

func Hello(p Person) {
	fmt.Println("Hello " + p.Name)
}
