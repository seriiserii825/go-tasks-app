package core_http_server

import (
	"context"
	"errors"
	"net/http"

	core_logger "github.com/seriiserii825/go-tasks-app/internal/core/logger"
)

type HTTPServer struct {
	mux    *http.ServeMux
	config Config
	log    *core_logger.Logger
}

func NewHTTPServer(config Config, log *core_logger.Logger) *HTTPServer {
	return &HTTPServer{
		mux:    http.NewServeMux(),
		config: config,
	}
}

func (h *HTTPServer) Run(ctx context.Context) error {
	server := &http.Server{
		Addr:    h.config.Addr,
		Handler: h.mux,
	}

	ch := make(chan error, 1)

	go func() {
		defer close(ch)

		err := server.ListenAndServe()
		if !errors.Is(err, http.ErrServerClosed) {
			ch <- err
		}
	}()
}
