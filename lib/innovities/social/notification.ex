defmodule Innovities.Social.Notification do
  use Ecto.Schema
  import Ecto.Changeset


  schema "notifications" do
    field :body, :string
    # COMPLETE_DESC_REQ, DESC_REQ_ACCEPTED, DESC_REQ_REJECTED, 7_DAY_TF_EXPIRY_NOTIF, 2_DAY_TF_EXPIRY_NOTIF
    field :notification_type, :string
    field :requested_idea_id, :integer
    field :title, :string
    field :red, :boolean
    field :addressed_to, :integer
    field :addressed_to_is_org, :boolean
    field :for_expiry_date, :string
    field :requested_from, :integer
    field :requested_from_is_org, :boolean

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:title, :body, :notification_type, :addressed_to, :addressed_to_is_org, :requested_idea_id, :red, :for_expiry_date, :requested_from, :requested_from_is_org])
    |> validate_required([:title, :body, :notification_type, :addressed_to, :addressed_to_is_org])
  end
end
