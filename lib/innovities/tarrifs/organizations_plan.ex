defmodule Innovities.Tarrifs.OrganizationsPlan do
  use Ecto.Schema
  import Ecto.Changeset

  alias Innovities.Accounts.Organization

  schema "organizations_plans" do
    field :complete_ideas_count, :integer
    field :innovator_connection_count, :integer
    field :monthly_pay, :integer
    field :name, :string
    field :region, :string
    field :yearly_pay, :integer

    has_many :organizations, Organization

    timestamps()
  end

  @doc false
  def changeset(organizations_plan, attrs) do
    organizations_plan
    |> cast(attrs, [:name, :monthly_pay, :yearly_pay, :complete_ideas_count, :innovator_connection_count, :region])
    |> validate_required([:name, :monthly_pay, :yearly_pay, :complete_ideas_count, :innovator_connection_count, :region])
  end
end
