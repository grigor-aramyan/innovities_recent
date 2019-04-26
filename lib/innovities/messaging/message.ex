defmodule Innovities.Messaging.Message do
  use Ecto.Schema
  import Ecto.Changeset


  schema "messages" do
    field :body, :string
    field :from, :integer
    field :receiver_is_organization, :boolean, default: false
    field :red, :boolean, default: false
    field :sender_is_organization, :boolean, default: false
    field :to, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :to, :from, :sender_is_organization, :receiver_is_organization, :red])
    |> validate_required([:body, :to, :from, :sender_is_organization, :receiver_is_organization])
  end
end
