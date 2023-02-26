package main

import "context"

type UserID int
type Company struct{}
type User struct{}

func GetCompanyUsecase(userID UserID) (*Company, error) {
	u, _ := GetUser(context.TODO(), userID)
	c, _ := GetCompanyByUser(u)
	return c
}

func GetUser(ctx context.Context, id UserID) (*User, error) {

}

func GetCompanyByUserID(u *User) (*Company, error) {

}
