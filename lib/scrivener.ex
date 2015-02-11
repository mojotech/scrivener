defmodule Scrivener do
  @moduledoc """
  Scrivener allows you to paginate your Ecto queries. It gives you useful information such as the total number of pages, the current page, and the current page's entries. It works nicely with Phoenix as well.

  First, you'll want to `use` Scrivener in your application's Repo. This will add a `paginate` function to your Repo. This `paginate` function expects to be called with, at a minimum, an Ecto query. It will then paginate the query and execute it, returning a `Scrivener.Page`. Defaults for `page_size` can be configued when you `use` Scrivener. If no `page_size` is provided, Scrivener will use `10` by default.

  You may also want to call `paginate` with a params map along with your query. If provided with a params map, Scrivener will use the values in the keys `"page"` and `"page_size"` before using any configured defaults.

      defmodule MyApp.Repo do
        use Ecto.Repo, otp_app: :my_app, adapter: Ecto.Adapters.Postgres
        use Scrivener, page_size: 10
      end

      defmodule MyApp.Person do
        use Ecto.Model

        schema "people" do
          field :name, :string
          field :age, :integer

          has_many :friends, MyApp.Person
        end
      end

      def index(conn, params) do
        page = MyApp.Person
        |> where([p], p.age > 30)
        |> order_by([p], desc: p.age)
        |> preload(:friends)
        |> MyApp.Repo.paginate(params)

        render conn, :index,
          people: page.entries,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages
      end

      page = MyApp.Person
      |> where([p], p.age > 30)
      |> order_by([p], desc: p.age)
      |> preload(:friends)
      |> MyApp.Repo.paginate(page: 2, page_size: 5)
  """

  import Ecto.Query

  alias Scrivener.Config
  alias Scrivener.Page

  @doc """
  Scrivener is meant to be `use`d by an Ecto repository. When `use`d, an optional default for `page_size` can be provided. If `page_size` is not provided a default of 10 will be used.

      defmodule MyApp.Repo do
        use Ecto.Repo, ...
        use Scrivener
      end

      defmodule MyApp.Repo do
        use Ecto.Repo, ...
        use Scrivener, page_size: 5
      end

    When `use` is called a `paginate` function is defined in the Ecto repo. See the `paginate` documentation for more information.
  """
  defmacro __using__(opts) do
    quote do
      @scrivener_defaults unquote(opts)
      def paginate(query, options \\ []) do
        Scrivener.paginate(__MODULE__, @scrivener_defaults, query, options)
      end
    end
  end

  @doc """
  The `paginate` function can also be called with a `Scrivener.Config` for more fine-grained configuration. In this case, it is called directly on the `Scrivener` module.

      config = %Scrivener.Config{
        page_size: 5,
        page_number: 2,
        repo: MyApp.Repo
      }

      MyApp.Model
      |> where([m], m.field == "value")
      |> Scrivener.paginate(config)
  """
  def paginate(query, %Config{page_size: page_size, page_number: page_number, repo: repo}) do
    %Page{
      page_size: page_size,
      page_number: page_number,
      entries: entries(query, repo, page_number, page_size),
      total_pages: total_pages(query, repo, page_size)
    }
  end

  @doc """
  This method is not meant to be called directly, but rather will be delegated to by calling `paginate/2` on the repository that `use`s Scrivener.

      defmodule MyApp.Repo do
        use Ecto.Repo, ...
        use Scrivener
      end

      MyApp.Model |> where([m], m.field == "value") |> MyApp.Repo.paginate

  When calling your repo's `paginate` function, you may optionally specify `page` and `page_size`. These values can be specified either as a Keyword or map. The values should be integers or string representations of integers.

      MyApp.Model |> where([m], m.field == "value") |> MyApp.Repo.paginate(page: 2, page_size: 10)

      MyApp.Model |> where([m], m.field == "value") |> MyApp.Repo.paginate(%{"page" => "2", "page_size" => "10"})

  The ability to call paginate with a map with string key/values is convenient because you can pass your Phoenix params map to paginate.
  """
  def paginate(repo, defaults, query, opts) do
    paginate(query, Config.new(repo, defaults, opts))
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

  defp entries(query, repo, page_number, page_size) do
    offset = page_size * (page_number - 1)

    query
    |> limit([_], ^page_size)
    |> offset([_], ^offset)
    |> repo.all
  end

  defp total_pages(query, repo, page_size) do
    count = query
    |> exclude(:order_by)
    |> exclude(:preload)
    |> exclude(:select)
    |> select([e], count(e.id))
    |> repo.one

    ceiling(count / page_size)
  end
end
