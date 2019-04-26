defmodule Innovities.Repo.Migrations.ChangeRequestedIdeaIdInNotif do
  use Ecto.Migration

  def change do
    alter table(:notifications) do
      remove :requested_idea_id
      add :requested_idea_id, :integer, null: false, default: 0
    end
  end
end
