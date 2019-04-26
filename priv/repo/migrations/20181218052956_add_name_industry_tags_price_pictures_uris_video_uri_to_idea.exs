defmodule Innovities.Repo.Migrations.AddNameIndustryTagsPricePicturesUrisVideoUriToIdea do
  use Ecto.Migration

  def change do
    alter table(:ideas) do
      add :idea_name, :string, null: false, default: ""
      add :industry, :string, null: false, default: ""
      add :tags, :string, null: false, default: ""
      add :price, :string, null: false, default: ""
      add :picture_uris, :string, null: false, default: ""
      add :video_uri, :string, null: false, default: ""
    end
  end
end
