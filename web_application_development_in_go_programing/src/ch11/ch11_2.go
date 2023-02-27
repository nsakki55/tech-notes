package main

type ServiceImpl struct{}

func (s *ServiceImpl) Apply(id int) error { return nil }

type OrderService interface {
	Apply(int) error
}

type Application struct {
	os OrderService
}

func NewApplication(os OrderService) *Application {
	return &Application{os: os}
}

func (app *Application) Apply(id int) error {
	return app.os.Apply(id)
}

func main() {
	app := NewApplication(&ServiceImpl{})
	app.Apply(19)
}
