# Scrivener

Scrivener allows you to paginate your Ecto queries. It gives you useful information such as the total number of pages, the current page, and the current page's records. It works nicely with Phoenix as well.

Scrivener expects you to call `paginate` with, at a minimum, an unevaluated Ecto query. It will then paginate this query and execute it, returning a `Scrivener.Page`. Defaults for `page_size` and `repo` are configued in your `config.exs`.

You may also want to call paginate with a params map along with your query. If provided with a params map, Scrivener will use the values in the keys `"page"` and `"page_size"` before using any configured defaults.

## Example

```elixir
use Mix.Config

config :scrivener, :defaults,
  page_size: 10,
  repo: MyApp.Repo
```

```elixir
defmodule MyApp.Person do
  use Ecto.Model

  schema "people" do
    field :name, :string
    field :age, :integer

    has_many :friends, MyApp.Person
  end
end
```

```elixir
def index(conn, params) do
  page = MyApp.Person
  |> where([p], p.age > 30)
  |> order_by([p], desc: p.age)
  |> preload(:friends)
  |> Scrivener.paginate(params)

  render conn, :index,
    people: page.records,
    page: page.page_number,
    page_size: page.page_size,
    total_pages: page.total_pages
end
```
