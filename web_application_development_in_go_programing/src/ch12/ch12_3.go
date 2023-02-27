package main

import "net/http"

func VersionAdder(v AppVersion) func(http.Header) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			r.Header.Add("App-Version", v)
			next.ServeHTTP(w, r)
		})
	}
}
