defmodule Innovities.Repo.Migrations.AddAddressedToIsOrgToNotifs do
  use Ecto.Migration

  def change do
    alter table(:notifications) do
      add :addressed_to_is_org, :boolean, default: false, null: false
    end
  end
end
