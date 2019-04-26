defmodule Innovities.Repo.Migrations.AddTariffExpiryDateToInnovator do
  use Ecto.Migration

  def change do
    alter table(:innovators) do
      add :tariff_expiry_date, :string, null: false, default: ""
    end
  end
end
