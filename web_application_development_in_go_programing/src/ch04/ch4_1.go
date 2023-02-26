package domain

import "fmt"

type Person struct {
	firstName string
	lastName  string
}

func (p *Person) GetFirstName() string { return p.firstName }

type Book struct {
	Author *Person
}

func (b *Book) AuthorName() string {
	return fmt.Sprintf("%s %s", b.Author.firstName, b.Author.lastName)
}
