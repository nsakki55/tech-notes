package main

import (
	"log"
	"net/http"
	"time"
)

func MyMiddleware(h http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		s := time.Now()
		h.ServeHTTP(w, r)
		d := time.Now().Sub(s).Milliseconds()
		log.Printf("end %s(%d ms)\n", t.Format(time.RFC3339), d)
	})
}
