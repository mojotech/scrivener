defmodule Scrivener.FakeRepo do
  def one(_), do: 12
  def all(query), do: query
end

defmodule Scrivener.Person do
  use Ecto.Model

  schema "people" do
    field :name, :string
    field :age, :integer
  end
end

defmodule ScrivenerTest do
  use ExSpec
  import Ecto.Query

  alias Scrivener.Person

  describe "paginate" do
    it "paginates the provided query with provided defaults" do
      query = Person |> where([p], p.age > 30)

      page = Scrivener.paginate(query)

      assert page.page_size == 10
      assert page.number == 1

      assert inspect(page.records) == inspect(query |> limit([_], ^10) |> offset([_], ^0))
      assert page.total_pages == 2
    end

    it "can be provided the current page and page size as a params map" do
      query = Person |> where([p], p.age > 30)

      page = Scrivener.paginate(query, %{"page" => "2", "page_size" => "3"})

      assert page.page_size == 3
      assert page.number == 2

      assert inspect(page.records) == inspect(query |> limit([_], ^3) |> offset([_], ^3))
      assert page.total_pages == 4
    end
  end
end
