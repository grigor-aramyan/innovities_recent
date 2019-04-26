defmodule Innovities.Accounts.Innovator do
  use Ecto.Schema
  import Ecto.Changeset

  alias Innovities.Content.{Idea, Post}

  schema "innovators" do
    field :country, :string
    field :email, :string
    field :full_name, :string
    field :generated_ideas_count, :integer
    field :organization_connection_count, :integer
    field :password, :string
    field :picture_uri, :string
    field :prefered_organization, :string
    field :innovators_plan_id, :id
    field :receive_newsletter, :boolean
    field :rating, :integer
    field :description, :string
    field :about_me, :string
    field :education, :string
    field :experience, :string
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
  def changeset(innovator, attrs) do
    attrs =
      attrs
      |> stringify_value(:picture_uri)
      |> stringify_value(:description)
      |> stringify_value(:about_me)
      |> stringify_value(:education)
      |> stringify_value(:experience)
      |> stringify_value(:username)
      |> stringify_value(:phone)

    innovator
    |> change()
    |> allow_empty_strings()
    |> cast(attrs, [:full_name, :email, :password, :country, :picture_uri, :generated_ideas_count, :organization_connection_count, :prefered_organization, :innovators_plan_id, :receive_newsletter, :rating, :description, :about_me, :education, :experience, :username, :phone, :tariff_subscription_date, :tariff_expiry_date, :region, :continent])
    |> validate_required([:full_name, :email, :password, :country, :innovators_plan_id, :region, :continent])
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
