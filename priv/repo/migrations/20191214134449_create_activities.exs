defmodule Clouds.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :type, :string
      add :actor, :string
      add :to, {:array, :string}
      add :local, :boolean, default: false, null: false

      timestamps()
    end

  end
end
