# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :linkbox_backend,
  ecto_repos: [LinkboxBackend.Repo]

# Configures the endpoint
config :linkbox_backend, LinkboxBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "z3aG1JaZkrLptJ1/XOGmQwh5eNGb3mXAuCiIvCoa+hGS3pw53eIxvJbe9RY7naHj",
  render_errors: [view: LinkboxBackendWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: LinkboxBackend.PubSub,
  live_view: [signing_salt: "P30cAo5G"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :linkbox_backend, LinkboxBackend.Guardian,
  issuer: "linkbox-backend",
  secret_key: "dR+IBQ+hF6G4us6Fo/axQUQGJCh+ARxbRWaQzivJDqYkCDAAby54fUbuvlLKb1Hl"
