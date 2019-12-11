defmodule CloudsWeb.PageController do
  use CloudsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
