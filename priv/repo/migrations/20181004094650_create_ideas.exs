defmodule Innovities.Repo.Migrations.CreateIdeas do
  use Ecto.Migration

  def change do
    create table(:ideas) do
      add :short_description, :string
      add :long_description, :string
      add :innovator_id, references(:innovators, on_delete: :nothing)
      add :organization_id, references(:organizations, on_delete: :nothing)

      timestamps()
    end

    create index(:ideas, [:innovator_id])
    create index(:ideas, [:organization_id])
  end
end
