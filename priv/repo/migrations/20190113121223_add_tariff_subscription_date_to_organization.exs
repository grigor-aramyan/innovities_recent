defmodule Innovities.Repo.Migrations.AddTariffSubscriptionDateToOrganization do
  use Ecto.Migration

  def change do
    alter table(:organizations) do
      add :tariff_subscription_date, :string, null: false, default: ""
    end
  end
end
