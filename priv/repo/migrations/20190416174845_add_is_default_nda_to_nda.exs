defmodule Innovities.Repo.Migrations.AddIsDefaultNdaToNda do
  use Ecto.Migration

  def change do
    alter table(:ndas) do
      add :is_default_nda, :boolean, default: true, null: false
    end
  end
end
