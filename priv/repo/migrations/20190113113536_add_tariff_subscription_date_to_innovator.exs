defmodule Innovities.Repo.Migrations.AddTariffSubscriptionDateToInnovator do
  use Ecto.Migration

  def change do
    alter table(:innovators) do
      add :tariff_subscription_date, :string, null: false, default: ""
    end
  end
end
