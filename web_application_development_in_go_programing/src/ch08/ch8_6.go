package main

import (
	"database/sql"
	"errors"
	"fmt"
)

var db *sql.DB

func (r *Repo) GetBook(t BookTitle) (*Book, error) {
	rows, err := db.QueryContext(ctx,
		"SELECT id, title, author_id FROM books WHERE title = ?", title)

	if err != nil {
		return nil, fmt.Errorf("GetBook: %v", err)
	}
	defer rows.Close()
}

func GetAuthorName(t BookTitle) (string, error) {
	b, err := r.GetBook()
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return "", fmt.Errorf("GetAuthor: unknown book %v", err)
		}
	}
}
