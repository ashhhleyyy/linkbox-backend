defmodule LinkboxBackendWeb.DiscoveryController do
  use LinkboxBackendWeb, :controller

  def discover(conn, _params) do
    render(conn, "discovery.json", %{})
  end
end
