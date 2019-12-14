defmodule Clouds.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string
      add :name, :string
      add :username, :string
      add :pub_key, :text
      add :priv_key, :text
      add :summary, :text

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
