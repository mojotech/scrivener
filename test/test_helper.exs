defmodule Scrivener.TestCase do
  use ExUnit.CaseTemplate

  using(opts) do
    quote do
      use ExSpec, unquote(opts)
      import Ecto.Query
    end
  end

  setup do
    Ecto.Adapters.SQL.Sandbox.mode(Scrivener.Repo, :manual)

    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Scrivener.Repo)
  end
end

Scrivener.Repo.start_link
ExUnit.start()
