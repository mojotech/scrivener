use Mix.Config

config :scrivener, Scrivener.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "scrivener_test",
  username: System.get_env("SCRIVENER_DB_USER") || System.get_env("USER")

config :logger, :console,
  level: :error
