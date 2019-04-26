defmodule Innovities.Repo.Migrations.AddForExpiryDateToNotification do
  use Ecto.Migration

  def change do
    alter table(:notifications) do
      add :for_expiry_date, :string
    end
  end
end
