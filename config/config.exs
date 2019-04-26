# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :innovities, Innovities.Mailing.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: "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"

# General application configuration
config :innovities,
  ecto_repos: [Innovities.Repo]

# Configures the endpoint
config :innovities, InnovitiesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yNGGwF/+9+5+iiUqZZGBPdARlvsvfdZ5B1QnId5RPjYbiz9TMLEWgtoRDv60t/jp",
  render_errors: [view: InnovitiesWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Innovities.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
