defmodule Innovities.Repo.Migrations.AddDescriptionAboutEducationExperienceToInnovator do
  use Ecto.Migration

  def change do
    alter table(:innovators) do
      add :description, :string, null: false, default: ""
      add :about_me, :string, null: false, default: ""
      add :education, :string, null: false, default: ""
      add :experience, :string, null: false, default: ""
    end
  end
end
