defmodule Scrivener.Mixfile do
  use Mix.Project

  def project do
    [
      app: :scrivener,
      version: "0.1.0",
      elixir: "~> 1.0",
      deps: deps
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ecto, "~> 0.7.2"},
      {:ex_spec, "~> 0.3.0", only: :test}
    ]
  end
end
