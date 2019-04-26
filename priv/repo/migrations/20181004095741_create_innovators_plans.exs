defmodule Innovities.Repo.Migrations.CreateInnovatorsPlans do
  use Ecto.Migration

  def change do
    create table(:innovators_plans) do
      add :name, :string
      add :monthly_pay, :integer
      add :yearly_pay, :integer
      add :ideas_count, :integer
      add :organization_connection_count, :integer
      add :region, :string

      timestamps()
    end

  end
end
