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

  defstruct [:entries, :page_number, :page_size, :total_entries, :total_pages]

  @type t :: %__MODULE__{}

  defimpl Enumerable, for: Scrivener.Page do
    def count(_page), do: {:error, __MODULE__}

    def member?(_page, _value), do: {:error, __MODULE__}

    def reduce(%Scrivener.Page{entries: entries}, acc, fun) do
      Enumerable.reduce(entries, acc, fun)
    end
  end
end
