# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :clouds,
  ecto_repos: [Clouds.Repo]

# Configures the endpoint
config :clouds, CloudsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9/uiGv3a9WHme4kr4Y2m1psCecd+vJS7E3DfB3n3QPBJb7vQPlOcheNBYNMRV4dR",
  render_errors: [view: CloudsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Clouds.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :clouds, :pow,
  user: Clouds.Users.User,
  repo: Clouds.Repo,
  web_module: CloudsWeb,
  extensions: [PowPersistentSession],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
