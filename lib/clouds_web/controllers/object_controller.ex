defmodule CloudsWeb.ObjectController do
  use CloudsWeb, :controller
  alias Clouds.Objects

  def show(conn, %{"id" => object_id}) do
    object = Objects.get_object(object_id)

    render(conn, "show.json", object: object)
  end
end
