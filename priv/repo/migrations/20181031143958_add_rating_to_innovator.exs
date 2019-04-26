defmodule Innovities.Repo.Migrations.AddRatingToInnovator do
  use Ecto.Migration

  def change do
    alter table(:innovators) do
      add :rating, :integer, null: false, default: 0
    end
  end
end
