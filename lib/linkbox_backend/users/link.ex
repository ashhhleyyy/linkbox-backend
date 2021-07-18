defmodule LinkboxBackend.Users.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :note, :string
    field :url, :string
    field :owner_id, :id

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :note])
    |> validate_required([:url, :note])
  end
end
