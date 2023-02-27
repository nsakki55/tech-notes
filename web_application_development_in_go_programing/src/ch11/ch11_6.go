package main

func CustomApply(id int) error { return nil }

type Application struct {
	Apply func(int) error
}

func (app *Application) Run(id int) error {
	return app.Apply(id)
}

func main() {
	app := &Application{Apply: CustomApply}
	app.Run(19)
}
