package main

import "context"

func (r *Repository) Update(ctx context.Context) error {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return err
	}
	defer tx.Rollback()

	_, err := tx.exec( /*更新処理1*/ )
	if err != nil {
		return err
	}

	_, err := tx.exec( /*更新処理2*/ )
	if err != nil {
		return err
	}

	_, err := tx.exec( /*更新処理3*/ )
	if err != nil {
		return err
	}

	return tx.Commit()
}
