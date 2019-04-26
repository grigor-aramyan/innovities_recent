defmodule Innovities.Repo.Migrations.AddReferenceToInnovatorsPlanToInnovators do
  use Ecto.Migration

  def change do
    alter table("innovators") do
      add :innovators_plan_id, references(:innovators_plans, on_delete: :nothing)
    end

    create index(:innovators, [:innovators_plan_id])
  end
end
