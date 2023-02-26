package main

type Modem struct{}

func (Modem) Dial()   {}
func (Modem) Hangup() {}
func (Modem) Sender() {}
func (Modem) Recv()   {}

type Receiver interface {
	Recv()
}
