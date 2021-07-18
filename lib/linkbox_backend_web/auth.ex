defmodule LinkboxBackend.Guardian.Auth do
  use Guardian.Plug.Pipeline,
    otp_app: :linkbox_backend,
    module: LinkboxBackend.Guardian,
    error_handler: LinkboxBackend.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
