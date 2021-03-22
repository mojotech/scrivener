defmodule Scrivener.Mixfile do
  use Mix.Project

  def project do
    [
      app: :scrivener,
      version: "2.7.2",
      elixir: "~> 1.2",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      description: "Pagination for the Elixir ecosystem",
      deps: deps(),
      dialyzer: [ignore_warnings: ".dialyzer_ignore.exs"],
      docs: [
        main: "readme",
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:earmark, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false}
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
