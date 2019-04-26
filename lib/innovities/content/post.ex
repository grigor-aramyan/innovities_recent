defmodule Innovities.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset


  schema "posts" do
    field :likes, :integer
    field :media_file_uri, :string
    field :message, :string
    field :innovator_id, :id
    field :organization_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:likes, :message, :media_file_uri, :innovator_id, :organization_id])
    #|> validate_required([:likes, :message, :media_file_uri])
  end
end
