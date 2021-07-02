package main

import (
	"github.com/sirupsen/logrus"
	"net/http"
)

func main() {

	config := NewAppConfig()
	logger := logrus.New()

	logger.SetLevel(logrus.DebugLevel)

	s := NewServer(logger, config)
	s.Initialize()
	s.Listen()
}

func hello(w http.ResponseWriter, r *http.Request) {

	w.Write([]byte("Hello World!"))
}
