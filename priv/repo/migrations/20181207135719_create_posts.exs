defmodule Innovities.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :likes, :integer, null: false, default: 0
      add :message, :string, null: false, default: ""
      add :media_file_uri, :string, null: false, default: ""
      add :innovator_id, references(:innovators, on_delete: :nothing)
      add :organization_id, references(:organizations, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:innovator_id])
    create index(:posts, [:organization_id])
  end
end
