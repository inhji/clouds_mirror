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
      attrs = %{
        type: "Create",
        to: receipients,
        actor: User.actor_url()
      }

      with {:ok, activity} <- Clouds.Activities.create_activity(attrs),
           {:ok, note} <-
             Clouds.Objects.create_object(%{
               attributed_to: User.actor_url(),
               type: "Note",
               content: content_html,
               to: receipients,
               activity_id: activity.id
             }) do
        {:ok, note}
      else
        {:error, changeset} ->
          Repo.rollback(changeset)
      end
    end)
  end
end
