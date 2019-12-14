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
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/", CloudsWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/users", UserController
    get "/users/:id/inbox", UserController, :inbox
  end

  scope "/.well-known", CloudsWeb do
    get "/webfinger", WebfingerController, :index
  end
end
