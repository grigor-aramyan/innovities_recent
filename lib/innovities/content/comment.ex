defmodule Innovities.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "comments" do
    field :author_id, :integer
    field :author_is_org, :boolean, default: false
    field :author_name, :string
    field :body, :string
    field :input_date, :string
    field :post_id, :integer

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:author_id, :author_is_org, :author_name, :post_id, :input_date, :body])
    |> validate_required([:author_id, :author_is_org, :author_name, :post_id, :input_date, :body])
  end
end
