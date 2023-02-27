package main

import "fmt"

type ErrCode int

type MyError struct {
	Code ErrCode
}

func (e *MyError) Error() string {
	return fmt.Sprintf("code: %d", e.Code)
}

func (e *MyError) Unwrap() error
func (e *MyError) As(target interface{}) bool
func (e *MyError) Is(target error) bool
