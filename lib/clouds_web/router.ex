defmodule CloudsWeb.Router do
  use CloudsWeb, :router

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

  scope "/", CloudsWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/users", UserController
    get "/users/:id/inbox", UserController, :inbox
  end

  # Other scopes may use custom stacks.
  # scope "/api", CloudsWeb do
  #   pipe_through :api
  # end
end
