defmodule Clouds.Objects.Object do
  use Ecto.Schema
  import Ecto.Changeset
  alias CloudsWeb.Router.Helpers, as: Routes

  schema "objects" do
    field :content, :string
    field :content_html, :string
    field :content_sanitized, :string

    field :attributed_to, :string
    field :in_reply_to, :string
    field :to, {:array, :string}
    field :type, :string

    belongs_to :activity, Clouds.Activities.Activity

    timestamps()
  end

  @doc false
  def changeset(object, attrs) do
    object
    |> cast(attrs, [
      :content,
      :content_html,
      :content_sanitized,
      :type,
      :in_reply_to,
      :attributed_to,
      :to,
      :activity_id
    ])
    |> maybe_render_markdown()
    |> maybe_sanitize_html()
    |> validate_required([:content, :content_html, :content_sanitized, :type, :attributed_to, :to])
    |> validate_inclusion(:type, ["Note"])
  end

  def maybe_render_markdown(changeset) do
    case get_change(changeset, :content) do
      nil ->
        changeset

      value ->
        {:ok, html} =
          value
          |> Earmark.as_html!()
          |> IO.inspect()
          |> FastSanitize.basic_html()

        put_change(changeset, :content_html, html)
    end
  end

  def maybe_sanitize_html(changeset) do
    case get_change(changeset, :content_html) do
      nil ->
        changeset

      value ->
        {:ok, sanitized} =
          value
          |> IO.inspect()
          |> FastSanitize.strip_tags()

        put_change(changeset, :content_sanitized, sanitized)
    end
  end

  def id(object) do
    Routes.object_url(CloudsWeb.Endpoint, :show, object)
  end

  def to_json(%Clouds.Objects.Object{} = object) do
    %{
      "@context" => "https://www.w3.org/ns/activitystreams",
      "id" => id(object),
      "type" => object.type,
      "to" => object.to,
      "attributedTo" => object.attributed_to,
      "published" => object.inserted_at,
      "inReplyTo" => object.in_reply_to,
      "content" => object.content_html,
      "source" => %{
        "content" => object.content,
        "mediaType" => "text/markdown"
      }
    }
  end
end
