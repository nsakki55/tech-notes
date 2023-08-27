package main

type ServiceImpl struct{}

func (s *ServiceImpl) Apply(id int) error { return nil }

type OrderService interface {
	Apply(int) error
}

type Application struct {
	os OrderService
}

func (app *Application) Apply(os OrderService, id int) error {
	return os.Apply(id)
}

func main() {
	app := &Application{}
	app.Apply(&ServiceImpl{}, 19)
}
