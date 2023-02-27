package main

import "fmt"

func main() {
	defer func() {
		if r := recover(); r != nil {
			fmt.Printf("補足したpanic: %v", r)
		}
	}()
	fmt.Println("出力される")
	panic("happening!")
	fmt.Println("出力されません")
}
