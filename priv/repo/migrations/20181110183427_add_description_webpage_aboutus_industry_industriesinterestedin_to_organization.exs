defmodule Innovities.Repo.Migrations.AddDescriptionWebpageAboutusIndustryIndustriesinterestedinToOrganization do
  use Ecto.Migration

  def change do
    alter table(:organizations) do
      add :description, :string, null: false, default: ""
      add :webpage, :string, null: false, default: ""
      add :about_us, :string, null: false, default: ""
      add :industry, :string, null: false, default: ""
      add :interested_industries, :string, null: false, default: ""
    end
  end
end
