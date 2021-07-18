defmodule LinkboxBackendWeb.LinkController do
  use LinkboxBackendWeb, :controller

  alias LinkboxBackend.Users
  alias LinkboxBackend.Users.Link

  action_fallback LinkboxBackendWeb.FallbackController

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    links = Users.list_links(user)
    render(conn, "index.json", links: links)
  end

  def create(conn, %{"link" => link_params}) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %Link{} = link} <- Users.create_link(user, link_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.link_path(conn, :show, link))
      |> render("show.json", link: link)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    link = Users.get_link!(id)
    if (link.owner_id == user.id) do
      render(conn, "show.json", link: link)
    else
      send_resp(conn, :not_found, "")
    end
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    user = Guardian.Plug.current_resource(conn)

    link = Users.get_link!(id)

    if (link.owner_id != user.id) do
      send_resp(conn, :not_found, "")
    else
      with {:ok, %Link{} = link} <- Users.update_link(link, link_params) do
        render(conn, "show.json", link: link)
      end
    end
 end

  def delete(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    link = Users.get_link!(id)

    if (link.owner_id != user.id) do
      send_resp(conn, :not_found, "")
    else
      with {:ok, %Link{}} <- Users.delete_link(link) do
        send_resp(conn, :no_content, "")
      end
    end
  end
end
