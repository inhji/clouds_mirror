defmodule CloudsWeb.PostController do
  use CloudsWeb, :controller
  alias Clouds.Content

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"id" => note_id} = _params) do
    note = Content.get_note(note_id)

    render(conn, "show.html", post: note)
  end

  def new(conn, _params) do
    changeset = Clouds.Objects.change_object()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"object" => %{"content" => content}} = params) do
    receipients = ["https://www.w3.org/ns/activitystreams#Public"]

    case Content.create_note(content, receipients) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note created!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
