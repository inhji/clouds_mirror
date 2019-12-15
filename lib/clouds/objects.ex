defmodule Clouds.Objects do
  @moduledoc """
  The Objects context.
  """

  import Ecto.Query, warn: false

  alias Clouds.Repo
  alias Clouds.Objects.Object

  def create_object(attrs \\ {}) do
    %Object{}
    |> Object.changeset(attrs)
    |> Repo.insert()
  end

  def get_object(id) do
    Object
    |> Repo.get(id)
    |> Repo.preload(:activity)
  end
end
