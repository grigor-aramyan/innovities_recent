defmodule Innovities.Accounts.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  alias Innovities.Content.{Idea, Post}

  schema "organizations" do
    field :complete_ideas_count, :integer
    field :country, :string
    field :email, :string
    field :innovator_connection_count, :integer
    field :logo_uri, :string
    field :name, :string
    field :password, :string
    field :organizations_plan_id, :id
    field :receive_newsletter, :boolean
    field :rating, :integer
    field :description, :string
    field :webpage, :string
    field :about_us, :string
    field :industry, :string
    field :interested_industries, :string
    field :username, :string
    field :phone, :string
    field :tariff_subscription_date, :string
    field :tariff_expiry_date, :string
    field :region, :string
    field :continent, :string

    has_many :ideas, Idea
    has_many :posts, Post

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    attrs =
      attrs
      |> stringify_value(:logo_uri)
      |> stringify_value(:description)
      |> stringify_value(:webpage)
      |> stringify_value(:about_us)
      |> stringify_value(:industry)
      |> stringify_value(:interested_industries)
      |> stringify_value(:username)
      |> stringify_value(:phone)

    organization
    |> change()
    |> allow_empty_strings()
    |> cast(attrs, [:name, :email, :password, :country, :logo_uri, :complete_ideas_count, :innovator_connection_count, :organizations_plan_id, :receive_newsletter, :rating, :description, :webpage, :about_us, :industry, :interested_industries, :username, :phone, :tariff_subscription_date, :tariff_expiry_date, :region, :continent])
    |> validate_required([:name, :email, :password, :country, :organizations_plan_id, :region, :continent])
    |> unique_constraint(:email)
    |> hash_user_password
  end

  defp hash_user_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp hash_user_password(changeset) do
    changeset
  end

  defp stringify_value(attrs, key) do
    if Map.has_key?(attrs, key) do
      Map.put(attrs, key, to_string(attrs.key))
    else
      attrs
    end
  end

  defp allow_empty_strings(%Ecto.Changeset{valid?: false}) do
    raise ArgumentError, "Cannot allow empty strings on a Changeset after cast has been called"
  end
  defp allow_empty_strings(%Ecto.Changeset{changes: %{}} = changeset) do
    Map.put(changeset, :empty_values, [])
  end
  defp allow_empty_strings(_changeset) do
    raise ArgumentError, "Cannot allow empty strings on a Changeset after cast has been called"
  end
end
