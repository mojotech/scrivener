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
    def reduce(%{entries: entries}, acc, fun) when is_list(entries) do
      do_reduce(entries, acc, fun)
    end
    def reduce(_, acc, fun), do: do_reduce([], acc, fun)

    defp do_reduce(_,       {:halt, acc}, _fun),   do: {:halted, acc}
    defp do_reduce(entries, {:suspend, acc}, fun), do: {:suspended, acc, &do_reduce(entries, &1, fun)}
    defp do_reduce([],      {:cont, acc}, _fun),   do: {:done, acc}
    defp do_reduce([h|t],   {:cont, acc}, fun),    do: do_reduce(t, fun.(h, acc), fun)

    def member?(_page, _value),
      do: {:error, __MODULE__}
    def count(_page),
      do: {:error, __MODULE__}
  end
end
