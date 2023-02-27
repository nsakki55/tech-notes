package main

import (
	"errors"
	"fmt"
)

func GetAuthor(id AuthorID) (*Author, error) {
	if !id.Valid() {
		return errors.New("getAuthor: id is invalid")
	}
}

func GetAuthorName(b *Book) (string, error) {
	a, err := GetAuthor(b.AuthorID)
	if err != nil {
		return "", fmt.Errorf("GetAuthor: %v", err)
	}
	return a.Name(), nil
}
