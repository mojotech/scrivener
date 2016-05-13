defmodule Scrivener.Page do
  @moduledoc """
  A `Scrivener.Page` has 5 fields that can be accessed: `entries`, `page_number`, `page_size`, `total_entries` and `total_pages`.

      page = MyApp.Person |> where([p], p.age > 30) |> MyApp.Repo.paginate(params)

      page.entries
      page.page_number
      page.page_size
      page.total_entries
      page.total_pages
  """

  defstruct [:entries, :page_number, :page_size, :total_entries, :total_pages]

  @type t :: %__MODULE__{}

  defimpl Enumerable, for: __MODULE__ do
    alias Scrivener.Page

    def reduce(%Page{entries: entries}, acc, fun) when is_list(entries) do
      Enumerable.reduce(entries, acc, fun)
    end

    def member?(%Page{entries: entries}, value),
      do: {:ok, Enum.member?(entries, value)}
    def count(%Page{entries: entries}),
      do: {:ok, Enum.count(entries)}
  end
end
