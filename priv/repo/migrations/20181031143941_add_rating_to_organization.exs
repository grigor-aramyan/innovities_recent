defmodule Innovities.Repo.Migrations.AddRatingToOrganization do
  use Ecto.Migration

  def change do
    alter table(:organizations) do
      add :rating, :integer, null: false, default: 0
    end
  end
end
