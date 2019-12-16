defmodule Clouds.Repo.Migrations.CreateObjects do
  use Ecto.Migration

  def change do
    create table(:objects) do
      add :content, :text
      add :content_html, :text
      add :content_sanitized, :text

      add :type, :string
      add :attributed_to, :string
      add :in_reply_to, :string
      add :to, {:array, :string}

      add :activity_id, references "activities"

      timestamps()
    end

  end
end
