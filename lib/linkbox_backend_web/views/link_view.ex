defmodule LinkboxBackendWeb.LinkView do
  use LinkboxBackendWeb, :view
  alias LinkboxBackendWeb.LinkView

  def render("index.json", %{links: links}) do
    %{data: render_many(links, LinkView, "link.json")}
  end

  def render("show.json", %{link: link}) do
    %{data: render_one(link, LinkView, "link.json")}
  end

  def render("link.json", %{link: link}) do
    %{id: link.id,
      url: link.url,
      note: link.note}
  end
end
