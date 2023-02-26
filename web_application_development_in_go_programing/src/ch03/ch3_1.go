package main

import (
	"database/sql"
	"errors"
)

func (r *Repository) GetUserByAge(age int) (Users, error) {
	var us Users

	rows, err := r.db.QueryContext(ctx, "SELECT name FROM users WHERE age = ?", age)
	if errors.Is(err, sql.ErrNoRows) {

	} else if err != nil {
		return nil, err
	}
}
