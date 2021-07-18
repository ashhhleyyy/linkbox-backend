defmodule LinkboxBackend.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :note, :string
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:links, [:owner_id])
  end
end
