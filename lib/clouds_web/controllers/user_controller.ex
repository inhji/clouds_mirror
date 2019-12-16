defmodule CloudsWeb.UserController do
  use CloudsWeb, :controller

  alias Clouds.Users
  alias Clouds.Users.User

  def actor(conn, params) do
  end

  def get_inbox(conn, params) do
  end

  def get_outbox(conn, _params) do
    objects =
      Clouds.Objects.list_objects()
      |> Enum.map(&Clouds.Objects.Object.to_json/1)

    conn
    |> json(%{
      "@context" => "https://www.w3.org/ns/activitystreams",
      "summary" => "Outbox",
      "type" => "OrderedCollection",
      "totalItems" => Enum.count(objects),
      "orderedItems" => objects
    })
  end
end
