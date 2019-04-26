defmodule Innovities.Repo.Migrations.AddReferenceToOrganizationsPlanToOrganizations do
  use Ecto.Migration

  def change do
    alter table("organizations") do
      add :organizations_plan_id, references(:organizations_plans, on_delete: :nothing)
    end

    create index(:organizations, [:organizations_plan_id])
  end
end
