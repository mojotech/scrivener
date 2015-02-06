# Scrivener

[![Build Status](https://travis-ci.org/drewolson/scrivener.svg)](https://travis-ci.org/drewolson/scrivener) [![Hex Version](http://img.shields.io/hexpm/v/scrivener.svg?style=flat)](https://hex.pm/packages/scrivener)

Scrivener allows you to paginate your Ecto queries. It gives you useful information such as the total number of pages, the current page, and the current page's entries. It works nicely with Phoenix as well.

Scrivener expects you to call `paginate` with, at a minimum, an unevaluated Ecto query. It will then paginate this query and execute it, returning a `Scrivener.Page`. Defaults for `page_size` are configued when you `use` Scrivener.

You may also want to call paginate with a params map along with your query. If provided with a params map, Scrivener will use the values in the keys `"page"` and `"page_size"` before using any configured defaults.

## Example

```elixir
defmodule MyApp.Repo do
  use Ecto.Repo, otp_app: :my_app, adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 10
end
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
  |> MyApp.Repo.paginate(params)

  render conn, :index,
    people: page.entries,
    page_number: page.page_number,
    page_size: page.page_size,
    total_pages: page.total_pages
end
```
