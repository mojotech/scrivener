defmodule Scrivener.SimplePage do
  @moduledoc """
  Similar as `Scrivener.Page`, but without the `total_entries` and `total_pages` fields and with a `has_more` field instead.
  """

  defstruct [:page_number, :page_size, :has_more, entries: []]

  @type t :: %__MODULE__{
          entries: list(),
          page_number: pos_integer(),
          page_size: integer(),
          has_more: boolean()
        }
  @type t(entry) :: %__MODULE__{
          entries: list(entry),
          page_number: pos_integer(),
          page_size: integer(),
          has_more: boolean()
        }

  defimpl Enumerable do
    @spec count(Scrivener.SimplePage.t()) :: {:error, Enumerable.Scrivener.SimplePage}
    def count(_page), do: {:error, __MODULE__}

    @spec member?(Scrivener.SimplePage.t(), term) :: {:error, Enumerable.Scrivener.SimplePage}
    def member?(_page, _value), do: {:error, __MODULE__}

    @spec reduce(Scrivener.SimplePage.t(), Enumerable.acc(), Enumerable.reducer()) ::
            Enumerable.result()
    def reduce(%Scrivener.SimplePage{entries: entries}, acc, fun) do
      Enumerable.reduce(entries, acc, fun)
    end

    @spec slice(Scrivener.SimplePage.t()) :: {:error, Enumerable.Scrivener.SimplePage}
    def slice(_page), do: {:error, __MODULE__}
  end

  defimpl Collectable do
    @spec into(Scrivener.SimplePage.t()) ::
            {term, (term, Collectable.command() -> Scrivener.SimplePage.t() | term)}
    def into(original) do
      original_entries = original.entries
      impl = Collectable.impl_for(original_entries)
      {_, entries_fun} = impl.into(original_entries)

      fun = fn page, command ->
        %{page | entries: entries_fun.(page.entries, command)}
      end

      {original, fun}
    end
  end
end
