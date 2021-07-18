defmodule LinkboxBackend.Repo do
  use Ecto.Repo,
    otp_app: :linkbox_backend,
    adapter: Ecto.Adapters.Postgres
end
