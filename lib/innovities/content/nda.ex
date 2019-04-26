defmodule Innovities.Content.Nda do
  use Ecto.Schema
  import Ecto.Changeset


  schema "ndas" do
    field :author_id, :integer
    field :author_is_org, :boolean, default: false
    field :idea_id, :integer
    field :recipient_id, :integer
    field :recipient_is_org, :boolean, default: false
    field :signing_date, :string
    field :is_default_nda, :boolean

    timestamps()
  end

  @doc false
  def changeset(nda, attrs) do
    nda
    |> cast(attrs, [:idea_id, :author_id, :author_is_org, :recipient_id, :recipient_is_org, :signing_date, :is_default_nda])
    |> validate_required([:idea_id, :author_id, :author_is_org, :recipient_id, :recipient_is_org, :signing_date])
  end
end
