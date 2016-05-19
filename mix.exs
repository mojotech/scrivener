defmodule Scrivener.Mixfile do
  use Mix.Project

  def project do
    [
      app: :scrivener,
      version: "2.0.0-dev",
      elixir: "~> 1.2",
      package: package,
      description: "Pagination for the Elixir ecosystem",
      deps: deps,
      docs: [
        main: Scrivener,
        readme: "README.md"
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
      {:dialyxir, "~> 0.3.0", only: :dev},
      {:earmark, ">= 0.0.0", only: :dev},
      {:ex_doc, "~> 0.11.0", only: :dev},
      {:ex_spec, "~> 1.0", only: :test}
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
