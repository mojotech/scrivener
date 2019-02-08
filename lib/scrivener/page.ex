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
end
