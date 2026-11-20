package core_http_response

import (
	"encoding/json"
	"fmt"
	"net/http"

	core_logger "github.com/seriiserii825/go-tasks-app/internal/core/logger"
	"go.uber.org/zap"
)

type HTTPResponse struct {
	log *core_logger.Logger
	rw  http.ResponseWriter
}

func NewHTTPResponseHandler(log *core_logger.Logger, rw http.ResponseWriter) *HTTPResponse {
	return &HTTPResponse{
		log: log,
		rw:  rw,
	}
}

func (h *HTTPResponse) PanicResponse(p any, msg string) {
	statusCode := http.StatusInternalServerError
	err := fmt.Errorf("panic: %v, message: %s", p, msg)

	h.log.Error(msg, zap.Error(err))
	h.rw.WriteHeader(statusCode)
	response := map[string]string{
		"message": msg,
		"error":   err.Error(),
	}

	if err := json.NewEncoder(h.rw).Encode(response); err != nil {
		h.log.Error("failed to encode panic response", zap.Error(err))
	}
}
