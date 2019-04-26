defmodule Innovities.Repo.Migrations.ChangeTypeOfPicturesUriFieldOfIdea do
  use Ecto.Migration

  def change do
    alter table(:ideas) do
      remove :picture_uris
      add :picture_uris, :text, null: false, default: ""
    end
  end
end
