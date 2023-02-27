package main

import (
	"bytes"
	"io"
	"log"
	"net/http"
)

type rwWrapper struct {
	rw     http.ResponseWriter
	mw     io.Writer
	status int
}

func NewRwWrapper(rw http.ResponseWriter, buf io.Writer) *rwWrapper {
	return &rwWrapper{
		rw: rw,
		mw: io.MultiWriter(rw, buf),
	}
}

func (r *rwWrapper) Header() http.Header {
	return r.rw.Header()
}

func (r *rwWrapper) Write(i []byte) (int, error) {
	if r.status == 0 {
		r.status = http.StatusOK
	}
	return r.rw.Write(i)
}

func (r *rwWrapper) WriteHeader(statusCode int) {
	r.status = statusCode
	r.rw.WriteHeader(statusCode)
}

func NewLogger(l *log.Logger) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			buf := &bytes.Buffer{}
			rww := NewRwWrapper(w, buf)
			next.ServeHTTP(rww, r)
			l.Printf("%s", buf)
			l.Printf("%d", rww.status)
		})
	}
}
