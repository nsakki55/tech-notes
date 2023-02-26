package main

import "fmt"

type MyErr struct{}

func (me *MyErr) Error() string { return "" }

func Apply() error {
	var err *MyErr = nil
	return err
}

func Apply2() error {
	var err error = nil
	return err
}

func main() {
	fmt.Println(Apply() == nil)
	fmt.Println(Apply2() == nil)
}
