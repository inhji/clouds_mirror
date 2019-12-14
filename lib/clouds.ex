defmodule Clouds do
  @moduledoc """
  Clouds keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias CloudsWeb.Router.Helpers, as: Routes
  alias CloudsWeb.Endpoint

  @doc """
  Returns the absolute url of the site.

  ## Examples

    iex> Clouds.url()
    "http://localhost:4002"

    iex> Clouds.url("/api")
    "http://localhost:4002/api"

    iex> Clouds.url("/api/")
    "http://localhost:4002/api"

    iex> Clouds.url("/api?foo=bar")
    "http://localhost:4002/api?foo=bar"

  """
  def url(path \\ "") do
    Endpoint
    |> Routes.url()
    |> URI.merge(path)
    |> to_string()
    |> String.trim_trailing("/")
  end

  @doc """
  Returns the domain, including port of the site.

  # Examples

    iex> Clouds.domain()
    "localhost:4002"

  """
  def domain() do
    Endpoint
    |> Routes.url()
    |> URI.parse()
    |> Map.get(:authority)
  end
end
