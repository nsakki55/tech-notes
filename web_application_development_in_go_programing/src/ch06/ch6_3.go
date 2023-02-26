package main

import "fmt"

type Dog struct{}

func (d *Dog) Bark() string { return "bark" }

type BullDog struct{ Dog }

type ShibaInu struct{ Dog }

func (s *ShibaInu) Bark() string { return "ワン" }

func DogVoice(d *Dog) string { return d.Bark() }

func main() {
	bd := &BullDog{}
	fmt.Println(bd.Bark())

	si := &ShibaInu{}
	fmt.Println(si.Bark())

	// fmt.Println(DogVoice(si))
}
