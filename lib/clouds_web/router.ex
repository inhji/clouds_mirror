defmodule CloudsWeb.Router do
  use CloudsWeb, :router
  use Pow.Phoenix.Router

  use Pow.Extension.Phoenix.Router,
    extensions: [PowPersistentSession]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_owner
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  def put_owner(conn, _params) do
    user = Clouds.Users.get_user()

    conn
    |> assign(:owner, user)
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/", CloudsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/actor", UserController, :actor
    get "/inbox", UserController, :inbox
    get "/outbox", UserController, :outbox

    resources "/posts", PostController, only: [:show]
  end

  scope "/api", CloudsWeb do
    pipe_through :api

    resources "/objects", ObjectController, only: [:show]
    resources "/activities", ActivityController, only: [:show]
  end

  scope "/admin", CloudsWeb do
    pipe_through [:browser, :protected]

    resources "/posts", PostController, only: [:new, :create]
  end

  scope "/.well-known", CloudsWeb do
    get "/webfinger", WebfingerController, :index
  end
end
