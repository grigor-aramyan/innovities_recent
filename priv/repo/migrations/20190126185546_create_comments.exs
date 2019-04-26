defmodule Innovities.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :author_id, :integer
      add :author_is_org, :boolean, default: false, null: false
      add :author_name, :string
      add :post_id, :integer
      add :input_date, :string
      add :body, :string

      timestamps()
    end

  end
end
