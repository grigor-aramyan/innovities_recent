defmodule Innovities.Repo.Migrations.AddRegionContinentToInnovator do
  use Ecto.Migration

  def change do
    alter table(:innovators) do
      add :region, :string
      add :continent, :string
    end
  end
end
