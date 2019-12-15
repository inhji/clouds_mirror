defmodule Clouds.Activities do
  @moduledoc """
  The Objects context.
  """

  import Ecto.Query, warn: false

  alias Clouds.Repo
  alias Clouds.Activities.Activity

  def create_activity(attrs \\ {}) do
    %Activity{}
    |> Activity.changeset(attrs)
    |> Repo.insert()
  end

  def get_activity(id) do
    Activity
    |> Repo.get(id)
    |> Repo.preload(:object)
  end
end
