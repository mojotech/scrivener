defmodule Scrivener.Page do
  @moduledoc """
  A `Scrivener.Page` has 5 fields that can be accessed: `entries`, `page_number`, `page_size`, `total_entries` and `total_pages`.

      page = MyApp.Module.paginate(params)

      page.entries
      page.page_number
      page.page_size
      page.total_entries
      page.total_pages
  """

  defstruct [:page_number, :page_size, :total_entries, :total_pages, entries: []]

  @type t :: %__MODULE__{
          entries: list(),
          page_number: pos_integer(),
          page_size: integer(),
          total_entries: integer(),
          total_pages: pos_integer()
        }
  @type t(entry) :: %__MODULE__{
          entries: list(entry),
          page_number: pos_integer(),
          page_size: integer(),
          total_entries: integer(),
          total_pages: pos_integer()
        }

  defimpl Enumerable do
    @spec count(Scrivener.Page.t()) :: {:error, Enumerable.Scrivener.Page}
    def count(_page), do: {:error, __MODULE__}

    @spec member?(Scrivener.Page.t(), term) :: {:error, Enumerable.Scrivener.Page}
    def member?(_page, _value), do: {:error, __MODULE__}

    @spec reduce(Scrivener.Page.t(), Enumerable.acc(), Enumerable.reducer()) ::
            Enumerable.result()
    def reduce(%Scrivener.Page{entries: entries}, acc, fun) do
      Enumerable.reduce(entries, acc, fun)
    end

    @spec slice(Scrivener.Page.t()) :: {:error, Enumerable.Scrivener.Page}
    def slice(_page), do: {:error, __MODULE__}
  end

  defimpl Collectable do
    @spec into(Scrivener.Page.t()) ::
            {term, (term, Collectable.command() -> Scrivener.Page.t() | term)}
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
