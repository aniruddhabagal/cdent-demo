package main

import (
	"cdent/users"
	"fmt"
	"github.com/gorilla/mux"
	"github.com/sirupsen/logrus"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"net/http"
)

type Server struct {
	PORT    int
	Address string
	config  *AppConfig
	router  *mux.Router
	logger  *logrus.Logger
	DB      *gorm.DB
}

func NewServer(logger *logrus.Logger, config *AppConfig) *Server {
	return &Server{
		logger:  logger,
		PORT:    config.PORT,
		Address: config.Address,
		router:  mux.NewRouter(),
		config:  config,
	}
}

func (s *Server) Initialize() {
	s.addRoute()
	dsn := fmt.Sprintf(
		"host=%s user=%s password=%s dbname=%s port=%d sslmode=disable TimeZone=Asia/Kolkata",
		s.config.DBHost,
		s.config.DBUser,
		s.config.DBPassword,
		s.config.DBName,
		s.config.DBPort,
	)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		s.logger.WithError(err).Error("Failed to Connect to DataBase")
	}
	s.logger.Infof("Connected to DataBase: %s", dsn)
	s.DB = db

	err = runMigration(s.logger,s.config)

	if err != nil {
		s.logger.WithError(err).Panic("Failed to run Migrations")
	}
	s.addRoute()


}

func (s *Server) addRoute() {
	s.router.StrictSlash(true)

	ur := users.NewRepository(s.DB)
	uh := users.NewHandler(s.logger, ur)

	s.router.HandleFunc("/users", uh.Create).Methods(http.MethodPost)
	s.router.HandleFunc("/users", uh.GetAll).Methods(http.MethodGet)
	s.router.HandleFunc("/user/{id}", uh.Update).Methods(http.MethodPost)
	s.router.HandleFunc("/user/{id}", uh.Delete).Methods(http.MethodDelete)
	s.router.HandleFunc("/user/{id}", uh.Get).Methods(http.MethodGet)
}

func (s *Server) Listen() {
	addr := fmt.Sprintf("%s:%d", s.Address, s.PORT)

	s.logger.Infof("Starting server on: %s", addr)

	//fmt.Printf("Starting server on: %s", addr)

	err := http.ListenAndServe(addr, s.router)
	if err != nil {
		panic(err)
	}
}
