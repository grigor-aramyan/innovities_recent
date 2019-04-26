defmodule Innovities.Repo.Migrations.CreateInnovators do
  use Ecto.Migration

  def change do
    create table(:innovators) do
      add :full_name, :string
      add :email, :string
      add :password, :string
      add :country, :string, default: ""
      add :picture_uri, :string, default: ""
      add :generated_ideas_count, :integer, default: 0
      add :organization_connection_count, :integer, default: 0
      add :prefered_organization, :string, default: ""

      timestamps()
    end

  end
end
