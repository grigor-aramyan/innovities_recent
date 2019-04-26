defmodule Innovities.Auth.Token do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tokens" do
    field :token, :string

    timestamps()
  end

  @doc false
  def update_changeset(token, attrs) do
    token
    |> cast(attrs, [:token])
    |> update_attrs(attrs)
    #|> createToken()
    #|> validate_required([:token])
  end

  def update_attrs(%Ecto.Changeset{valid?: true} = changeset, attrs) do
    change(changeset, attrs)
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:token])
    |> createToken()
    #|> validate_required([:token])
  end

  defp createToken(%Ecto.Changeset{valid?: true} = changeset) do
    change(changeset, token: Bcrypt.hash_pwd_salt(to_string(:os.system_time(:millisecond))))
  end

  defp createToken(changeset) do
    changeset
  end
end
