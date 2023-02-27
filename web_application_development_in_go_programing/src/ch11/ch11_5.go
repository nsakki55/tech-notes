package main

type OrderService interface {
	Apply(int) error
}

type ServiceImpl struct{}

func (s *ServiceImpl) Apply(id int) error { return nil }

type Application struct {
	OrderService
}

func (app *Application) Run(id int) error {
	return app.Apply(id)
}

func main() {
	app := &Application{OrderService: &ServiceImpl{}}
	app.Apply(19)
}
