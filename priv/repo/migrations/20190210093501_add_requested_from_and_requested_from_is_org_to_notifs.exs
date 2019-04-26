defmodule Innovities.Repo.Migrations.AddRequestedFromAndRequestedFromIsOrgToNotifs do
  use Ecto.Migration

  def change do
    alter table(:notifications) do
      add :requested_from, :integer
      add :requested_from_is_org, :boolean
    end
  end
end
