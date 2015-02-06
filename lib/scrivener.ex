defmodule Scrivener do
  import Ecto.Query

  def paginate(query) do
    %Scrivener.Page{
      page_size: page_size,
      number: page_number,
      records: records(query, repo, page_number, page_size),
      total_pages: total_pages(query, repo, page_size)
    }
  end

  defp ceiling(float) do
    t = trunc(float)

    case float - t do
      neg when neg < 0 ->
        t
      pos when pos > 0 ->
        t + 1
      _ -> t
    end
  end

  defp defaults do
    Application.get_env(:scrivener, :defaults)
  end

  defp page_number, do: 1

  defp page_size, do: defaults[:page_size]

  defp records(query, repo, page_number, page_size) do
    offset = page_size * (page_number - 1)

    query
    |> limit([_], ^page_size)
    |> offset([_], ^offset)
    |> repo.all
  end

  defp repo, do: defaults[:repo]

  def total_pages(query, repo, page_size) do
    count = query
    |> select([e], count(e.id))
    |> repo.one

    ceiling(count / page_size)
  end
end
