defmodule Innovities.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :text, null: false, default: ""
      add :to, :integer
      add :from, :integer
      add :sender_is_organization, :boolean, default: false, null: false
      add :receiver_is_organization, :boolean, default: false, null: false
      add :red, :boolean, default: false, null: false

      timestamps()
    end

  end
end
