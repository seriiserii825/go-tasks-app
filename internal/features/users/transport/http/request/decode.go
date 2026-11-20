package core_http_request

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func DecodeAndValidateRequest(r *http.Request, dest any) error {
	if err: = json.NewDecoder(r.Body).Decode(dest); err != nil {
		return fmt.Errorf("failed to decode request body: %w", err)
	}

}
