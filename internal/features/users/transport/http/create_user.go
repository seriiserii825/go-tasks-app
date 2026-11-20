package users_transport_http

import (
	"encoding/json"
	"fmt"
	"net/http"

	core_logger "github.com/seriiserii825/go-tasks-app/internal/core/logger"
)

type CreateUserRequest struct {
	FullName    string  `json:"full_name" validate:"required,min=3,max=100"`
	PhoneNumber *string `json:"phone_number" validate:"omitempty,min=10,max=15,startswith=+"`
}

type CreateUserResponse struct {
	ID          string `json:"id"`
	Version     int    `json:"version"`
	FullName    string `json:"full_name"`
	PhoneNumber string `json:"phone_number"`
}

func (h *UserHTTPHandler) CreateUser(rw http.ResponseWriter, r *http.Request) {
	ctx := r.Context()
	log := core_logger.FromContext(ctx)
	log.Debug("CreateUser called")
	var request CreateUserRequest
	if err := json.NewDecoder(r.Body).Decode(&request); err != nil {
		fmt.Println("Failed to decode request body:")
	}

	rw.WriteHeader(http.StatusCreated)
}
