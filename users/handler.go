package users

import (
	"encoding/json"
	"errors"
	"github.com/gorilla/mux"
	"github.com/sirupsen/logrus"
	"gorm.io/gorm"
	"net/http"
	"strconv"
)

type Handler struct {
	logger     *logrus.Logger
	repository *Repository
}

func NewHandler(logger *logrus.Logger, repository *Repository) *Handler {
	return &Handler{logger: logger, repository: repository}
}

func (h *Handler) Create(w http.ResponseWriter, r *http.Request) {
	user := &User{}

	err := json.NewDecoder(r.Body).Decode(user)
	if err != nil {
		http.Error(w, "Invalid JSON", http.StatusUnprocessableEntity)
		return
	}

	err = h.repository.Create(user)
	if err != nil {
		h.logger.WithError(err).Error("error in creating users")
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
	w.Write([]byte("User Created"))

}

func (h *Handler) Get(w http.ResponseWriter, r *http.Request) {
	pathVariables := mux.Vars(r)
	idStr := pathVariables["id"]

	h.logger.Debugf("ID: %v", idStr)

	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "ID must be an integer", http.StatusBadRequest)
		return
	}

	user, err := h.repository.Get(id)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		http.Error(w, "User doesn't exists", http.StatusNotFound)
		return
	}

	if err != nil {
		h.logger.WithError(err).Error("error in fetching users")
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	err = json.NewEncoder(w).Encode(user)
	if err != nil {

	}
}

func (h *Handler) GetAll(w http.ResponseWriter, r *http.Request) {
	users, err := h.repository.GetAll()

	if err != nil {
		h.logger.WithError(err).Error("error is fetching users")
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	err = json.NewEncoder(w).Encode(users)
	if err != nil {
		h.logger.WithError(err).Error("Error is here")
	}
}

func (h *Handler) Delete(w http.ResponseWriter, r *http.Request) {
	// TODO:
	// 1. Read json request to a user variable
	// 2. Call the repository Delete function

}

func (h *Handler) Update(w http.ResponseWriter, r *http.Request) {

	// TODO:
	// 1. Read json request to a user variable
	// 2. Call the repository Update function
}
