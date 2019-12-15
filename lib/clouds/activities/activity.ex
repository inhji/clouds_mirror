defmodule Clouds.Activities.Activity do
  use Ecto.Schema
  import Ecto.Changeset
  alias Clouds.Users.User
  alias Clouds.Objects.Object
  alias CloudsWeb.Router.Helpers, as: Routes

  schema "activities" do
    field :actor, :string
    field :local, :boolean, default: true
    field :to, {:array, :string}
    field :type, :string

    has_one :object, Clouds.Objects.Object

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:type, :actor, :to, :local])
    |> validate_required([:type, :actor, :to, :local])
    |> validate_inclusion(:type, ["Create"])
  end

  def id(activity) do
    Routes.activity_url(CloudsWeb.Endpoint, :show, activity)
  end

  def to_json(activity) do
    %{
      "@context" => "https://www.w3.org/ns/activitystreams",
      "type" => activity.type,
      "id" => id(activity),
      "to" => activity.to,
      "actor" => User.actor_url(),
      "object" => Object.to_json(activity.object)
    }
  end
end
