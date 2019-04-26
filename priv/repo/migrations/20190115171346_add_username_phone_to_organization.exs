defmodule Innovities.Repo.Migrations.AddUsernamePhoneToOrganization do
  use Ecto.Migration

  def change do
    alter table(:organizations) do
      add :username, :string, null: false, default: ""
      add :phone, :string, null: false, default: ""
    end
  end
end
