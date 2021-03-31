defmodule Scrivener.Mixfile do
  use Mix.Project

  @source_url "https://github.com/drewolson/scrivener"
  @version "2.7.2"

  def project do
    [
      app: :scrivener,
      version: @version,
      elixir: "~> 1.2",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      deps: deps(),
      docs: docs(),
      dialyzer: [ignore_warnings: ".dialyzer_ignore.exs"]
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
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      description: "Pagination for the Elixir ecosystem",
      maintainers: ["Drew Olson"],
      licenses: ["MIT"],
      files: [
        "lib/scrivener.ex",
        "lib/scrivener",
        "mix.exs",
        "CHANGELOG.md",
        "README.md"
      ],
      links: %{
        "Changelog" => "https://hexdocs.pm/scrivener/changelog.html",
        "GitHub" => @source_url
      }
    ]
  end

  defp docs do
    [
      extras: ["CHANGELOG.md", "README.md"],
      main: "readme",
      source_url: @source_url,
      source_ref: @version,
      formatters: ["html"]
    ]
  end
end
