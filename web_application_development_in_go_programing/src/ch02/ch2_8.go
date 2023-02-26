package main

import (
	"context"
	"database/sql"
	"errors"

	"example.com/auth"
)

type MyDB struct {
	db *sql.DB
}

func (mydb *MyDB) ExecContext(ctx context.Context, query string, args ...any) (Result, error) {
	if !auth.Writable(ctx) {
		return errors.New("書き込み権限がないユーザーによる実行です")
	}
	return mydb.db.ExecContext(ctx, query, args)
}
