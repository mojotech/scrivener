defmodule Scrivener.TestCase do
  use ExUnit.CaseTemplate

  using(opts) do
    quote do
      use ExSpec, unquote(opts)
      import Ecto.Query
    end
  end

  setup do
    Ecto.Adapters.SQL.begin_test_transaction(Scrivener.Repo)

    ExUnit.Callbacks.on_exit(fn ->
      Ecto.Adapters.SQL.rollback_test_transaction(Scrivener.Repo)
    end)
  end
end

Scrivener.Repo.start_link
ExUnit.start()
