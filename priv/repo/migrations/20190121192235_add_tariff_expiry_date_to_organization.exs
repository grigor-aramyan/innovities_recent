defmodule Innovities.Repo.Migrations.AddTariffExpiryDateToOrganization do
  use Ecto.Migration

  def change do
    alter table(:organizations) do
      add :tariff_expiry_date, :string, null: false, default: ""
    end
  end
end
