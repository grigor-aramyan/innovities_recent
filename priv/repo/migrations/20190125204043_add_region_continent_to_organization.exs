defmodule Innovities.Repo.Migrations.AddRegionContinentToOrganization do
  use Ecto.Migration

  def change do
    alter table(:organizations) do
      add :region, :string
      add :continent, :string
    end
  end
end
