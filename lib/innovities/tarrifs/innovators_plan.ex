defmodule Innovities.Tarrifs.InnovatorsPlan do
  use Ecto.Schema
  import Ecto.Changeset

  alias Innovities.Accounts.Innovator

  schema "innovators_plans" do
    field :ideas_count, :integer
    field :monthly_pay, :integer
    field :name, :string
    field :organization_connection_count, :integer
    field :region, :string
    field :yearly_pay, :integer

    has_many :innovators, Innovator

    timestamps()
  end

  @doc false
  def changeset(innovators_plan, attrs) do
    innovators_plan
    |> cast(attrs, [:name, :monthly_pay, :yearly_pay, :ideas_count, :organization_connection_count, :region])
    |> validate_required([:name, :monthly_pay, :yearly_pay, :ideas_count, :organization_connection_count, :region])
  end
end
