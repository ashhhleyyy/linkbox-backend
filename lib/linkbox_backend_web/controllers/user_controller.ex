defmodule LinkboxBackendWeb.UserController do
  use LinkboxBackendWeb, :controller

  alias LinkboxBackend.Guardian

  alias LinkboxBackend.Accounts
  alias LinkboxBackend.Accounts.User

  action_fallback LinkboxBackendWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> render("jwt.json", jwt: token)
    end
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "user.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn, %{"username" => username, "password" => password}) do
    case Accounts.token_sign_in(username, password) do
      {:ok, token, _claims} -> conn |> render("jwt.json", jwt: token)
      _ -> {:error, :unauthorized}
    end
  end
end
