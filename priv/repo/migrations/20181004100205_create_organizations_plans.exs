defmodule Innovities.Repo.Migrations.CreateOrganizationsPlans do
  use Ecto.Migration

  def change do
    create table(:organizations_plans) do
      add :name, :string
      add :monthly_pay, :integer
      add :yearly_pay, :integer
      add :complete_ideas_count, :integer
      add :innovator_connection_count, :integer
      add :region, :string

      timestamps()
    end

  end
end
