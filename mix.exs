defmodule Scrivener.Mixfile do
  use Mix.Project

  def project do
    [
      app: :scrivener,
      version: "2.4.0-dev",
      elixir: "~> 1.2",
      package: package(),
      description: "Pagination for the Elixir ecosystem",
      deps: deps(),
      aliases: aliases(),
      docs: [
        main: "readme",
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  defp aliases do
    [
      "ci": [
        "test",
        "credo"
      ]
    ]
  end

  def application do
    [
      applications: [:logger]
    ]
  end

  defp deps do
    [
      {:earmark, ">= 0.0.0", only: :dev},
      {:ex_doc, "~> 0.16.0", only: :dev},
      {:credo, "~> 0.7.4", only: [:dev, :test]},
    ]
  end

  defp package do
    [
      maintainers: ["Drew Olson"],
      licenses: ["MIT"],
      links: %{"github" => "https://github.com/drewolson/scrivener"},
      files: [
        "lib/scrivener.ex",
        "lib/scrivener",
        "mix.exs",
        "README.md"
      ]
    ]
  end
end
