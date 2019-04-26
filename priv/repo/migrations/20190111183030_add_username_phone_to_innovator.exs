defmodule Innovities.Repo.Migrations.AddUsernamePhoneToInnovator do
  use Ecto.Migration

  def change do
    alter table(:innovators) do
      add :username, :string, null: false, default: ""
      add :phone, :string, null: false, default: ""
    end
  end
end
