defmodule Scrivener do
  import Ecto.Query

  alias Scrivener.Config

  defmacro __using__(opts) do
    quote do
      @scrivener_defaults unquote(opts)
      def paginate(query, options \\ []) do
        Scrivener.paginate(__MODULE__, @scrivener_defaults, query, options)
      end
    end
  end

  def paginate(query, %Config{} = config) do
    %Scrivener.Page{
      page_size: config.page_size,
      page_number: config.page_number,
      records: records(query, config.repo, config.page_number, config.page_size),
      total_pages: total_pages(query, config.repo, config.page_size)
    }
  end

  def paginate(repo, defaults, query, opts) do
    paginate(query, Config.new(repo, defaults, query, opts))
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

  defp records(query, repo, page_number, page_size) do
    offset = page_size * (page_number - 1)

    query
    |> limit([_], ^page_size)
    |> offset([_], ^offset)
    |> repo.all
  end

  def total_pages(query, repo, page_size) do
    count = query
    |> exclude(:order_by)
    |> exclude(:preload)
    |> exclude(:select)
    |> select([e], count(e.id))
    |> repo.one

    ceiling(count / page_size)
  end
end
