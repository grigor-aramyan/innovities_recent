defmodule Innovities.Repo.Migrations.AddReceiveNewsletterBoolToOrganizations do
  use Ecto.Migration

  def change do
    alter table(:organizations) do
      add :receive_newsletter, :boolean, null: false, default: false
    end
  end
end
