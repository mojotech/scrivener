defmodule Scrivener.TestCase do
  use ExUnit.CaseTemplate

  using opts do
    quote do
      use ExUnit.Case, unquote(opts)
    end
  end
end

ExUnit.start()
