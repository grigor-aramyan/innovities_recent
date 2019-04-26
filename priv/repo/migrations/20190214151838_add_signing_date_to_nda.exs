defmodule Innovities.Repo.Migrations.AddSigningDateToNda do
  use Ecto.Migration

  def change do
    alter table(:ndas) do
      add :signing_date, :string
    end
  end
end
