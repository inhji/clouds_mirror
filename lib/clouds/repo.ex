defmodule Clouds.Repo do
  use Ecto.Repo,
    otp_app: :clouds,
    adapter: Ecto.Adapters.Postgres
end
