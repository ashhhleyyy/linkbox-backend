defmodule LinkboxBackendWeb.DiscoveryView do
  use LinkboxBackendWeb, :view

  def render("discovery.json", %{}) do
    %{link: "box"}
  end
end
