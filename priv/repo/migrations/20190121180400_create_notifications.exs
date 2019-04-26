defmodule Innovities.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :title, :string, null: false, default: ""
      add :body, :string, null: false, default: ""
      add :notification_type, :string, null: false
      add :requested_idea_id, :integer
      add :red, :boolean, default: false, null: false
      add :addressed_to, :integer

      timestamps()
    end

  end
end
