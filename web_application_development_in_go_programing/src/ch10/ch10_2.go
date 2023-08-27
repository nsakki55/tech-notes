package main

import (
	"fmt"
	"github.com/caarlos0/env"
)

type Config struct {
	Env  string `env:"TODO_ENV" envDefault:"dev"`
	Port int    `env:"PORT" envDefault:"80"`
}

func New() (*Config, error) {
	cfg := &Config{}
	if err := env.Parse(cfg); err != nil {
		return nil, err
	}
	fmt.Printf("%+v", cfg)
	return cfg, nil
}

func main() {
	cfg, err := New()
	if err != nil {
		fmt.Errorf("w", err)
	}
	fmt.Printf("%s\n", cfg.Env)
	fmt.Printf("%d\n", cfg.Port)
}
