defmodule LinkboxBackendWeb.Router do
  use LinkboxBackendWeb, :router

  alias LinkboxBackend.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_auth do
    plug Guardian.Auth
  end

  scope "/api/v1", LinkboxBackendWeb do
    pipe_through :api

    get "/_lb-discover", DiscoveryController, :discover

    post "/signup", UserController, :create
    post "/signin", UserController, :sign_in
  end

  scope "/api/v1", LinkboxBackendWeb do
    pipe_through [:api, :jwt_auth]

    get "/me", UserController, :show
    resources "/links", LinkController
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: LinkboxBackendWeb.Telemetry
    end
  end
end
