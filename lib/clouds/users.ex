defmodule Clouds.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias Clouds.Repo
  alias Clouds.Users.User

  @doc """
  Returns the user.
  """
  def get_user do
    Repo.get(User, 1)
  end

  @doc """
  Checks if the user with `username` exists.
  """
  def user_exists?(username) do
    case get_user do
      nil -> false
      user -> user.username == username
    end
  end

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
