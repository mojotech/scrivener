use Mix.Config

config :scrivener, :defaults,
  page_size: 10

import_config "#{Mix.env}.exs"
