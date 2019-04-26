defmodule Innovities.Repo.Migrations.CreateConnections do
  use Ecto.Migration

  def change do
    create table(:connections) do
      add :sender_id, :integer, null: false
      add :receiver_id, :integer, null: false
      add :sender_is_organization, :boolean, default: false, null: false
      add :receiver_is_organization, :boolean, default: false, null: false

      timestamps()
    end

  end
end
