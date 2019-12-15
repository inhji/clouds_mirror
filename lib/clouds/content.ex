defmodule Clouds.Content do
  import Ecto.Query
  alias Clouds.Repo
  alias Clouds.Objects.Object
  alias Clouds.Users.User

  def list_notes() do
    Object
    |> where(type: "Note")
    |> order_by(desc: :inserted_at)
    |> Repo.all()
    |> Repo.preload(:activity)
  end

  def get_note(id) do
    Repo.get(Object, id)
    |> Repo.preload(:activity)
  end

  def create_note(content_html, receipients) do
    Repo.transaction(fn ->
      {:ok, activity} =
        Clouds.Activities.create_activity(%{
          type: "Create",
          to: receipients,
          actor: User.actor_url()
        })

      result =
        Clouds.Objects.create_object(%{
          attributedTo: User.actor_url(),
          type: "Note",
          content: content_html,
          to: receipients,
          activity_id: activity.id
        })

      case result do
        {:ok, note} ->
          {:ok, note}

        {:error, changeset} ->
          Repo.rollback(changeset)
      end
    end)
  end
end
