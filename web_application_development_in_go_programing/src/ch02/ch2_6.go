package main

import (
	"context"
	"fmt"
	"time"
)

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	task := make(chan int)
	go func() {
		select {
		case <-ctx.Done():
			return
		case i := <-task:
			fmt.Println("get", i)
		default:
			fmt.Println("キャンセルされていない")
		}
		time.Sleep(300 * time.Millisecond)
	}()
	time.Sleep(time.Second)
	for i := 0; 5 > i; i++ {
		task <- i
	}
	cancel()
}
