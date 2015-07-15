defmodule Scrivener.Support.HTML do
  alias Scrivener.HTML
  
  def pages(range), do: Enum.to_list(range) |> Enum.map &({&1, &1})
  def pages_with_first(first, range), do: [{first, first}] ++ pages(range)
  def pages_with_last(range, last), do: pages(range) ++ [{last, last}]
  def pages_with_next(range, next), do: pages(range) ++ [{">>", next}]
  def pages_with_previous(previous, range), do: [{"<<", previous}] ++ pages(range)
  def links_with_opts(paginator, opts \\ []), do: HTML.raw_pagination_links(paginator, Dict.merge([next: false, previous: false, first: false, last: false], opts))

end
