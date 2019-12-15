defmodule CloudsWeb.PageController do
  use CloudsWeb, :controller
  alias Clouds.Content

  def index(conn, _params) do
    notes = Content.list_notes()

    render(conn, "index.html", notes: notes)
  end
end
