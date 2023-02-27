package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func RecoveryMiddleware(next http.Handler) http.Handler {
	return http.HandleFunc(func(w http.ResponseWriter, r *http.Request) {
		defer func() {
			if r := recover(); err != nil {
				jsonBody, _ := json.Marshal(map[string]string{
					"error": fmt.Sprintf("%v", err),
				})

				w.Header().Set("Content-Type", "application/json")
				w.WriteHeader(http.StatusInternalServerError)
				w.Write(jsonBody)
			}
		}()
		next.ServeHTTP(w, r)
	})
}
