defmodule Innovities.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string
      add :email, :string
      add :password, :string
      add :country, :string
      add :logo_uri, :string, default: ""
      add :complete_ideas_count, :integer, default: 0
      add :innovator_connection_count, :integer, default: 0

      timestamps()
    end

  end
end
