defmodule Innovities.Social.Connection do
  use Ecto.Schema
  import Ecto.Changeset


  schema "connections" do
    field :receiver_id, :integer
    field :receiver_is_organization, :boolean, default: false
    field :sender_id, :integer
    field :sender_is_organization, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(connection, attrs) do
    connection
    |> cast(attrs, [:sender_id, :receiver_id, :sender_is_organization, :receiver_is_organization])
    |> validate_required([:sender_id, :receiver_id, :sender_is_organization, :receiver_is_organization])
  end
end
