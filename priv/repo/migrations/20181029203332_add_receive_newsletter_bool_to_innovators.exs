defmodule Innovities.Repo.Migrations.AddReceiveNewsletterBoolToInnovators do
  use Ecto.Migration

  def change do
    alter table(:innovators) do
      add :receive_newsletter, :boolean, null: false, default: false
    end
  end
end
