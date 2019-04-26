defmodule Innovities.Repo.Migrations.AddHasNdaIsDefaultNdaCustomNdaToIdea do
  use Ecto.Migration

  def change do
    alter table(:ideas) do
      add :has_nda, :boolean, default: false, null: false
      add :is_default_nda, :boolean, default: true, null: false
      add :custom_nda, :string, default: "", null: false
    end
  end
end
