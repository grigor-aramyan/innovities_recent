defmodule Innovities.Repo.Migrations.ChangeTypeOfCustomNdaFieldOfIdea do
  use Ecto.Migration

  def change do
    alter table(:ideas) do
      remove :custom_nda
      add :custom_nda, :text, null: false, default: ""
    end
  end
end
