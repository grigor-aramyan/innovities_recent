defmodule Innovities.Repo.Migrations.CreateNdas do
  use Ecto.Migration

  def change do
    create table(:ndas) do
      add :idea_id, :integer
      add :author_id, :integer
      add :author_is_org, :boolean, default: false, null: false
      add :recipient_id, :integer
      add :recipient_is_org, :boolean, default: false, null: false

      timestamps()
    end

  end
end
