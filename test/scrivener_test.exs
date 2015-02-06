defmodule Scrivener.FakeRepo do
  use Scrivener, page_size: 10

  def one(_), do: 12
  def all(query), do: query
end

defmodule Scrivener.AnotherFakeRepo do
  use Scrivener, page_size: 10

  def one(_), do: 8
  def all(query), do: query
end

defmodule Scrivener.NoOptsRepo do
  use Scrivener

  def one(_), do: 12
  def all(query), do: query
end

defmodule Scrivener.Person do
  use Ecto.Model

  schema "people" do
    field :name, :string
    field :age, :integer

    has_many :friends, Scrivener.Person
  end
end

defmodule ScrivenerTest do
  use ExSpec
  import Ecto.Query

  alias Scrivener.Person

  describe "paginate" do
    it "users defaults from the repo" do
      query = Person |> where([p], p.age > 30)

      page = Scrivener.FakeRepo.paginate(query)

      assert page.page_size == 10
      assert page.page_number == 1

      assert inspect(page.entries) == inspect(query |> limit([_], ^10) |> offset([_], ^0))
      assert page.total_pages == 2
    end

    it "defaults to a page size of 10 if none is provided" do
      query = Person |> where([p], p.age > 30)

      page = Scrivener.NoOptsRepo.paginate(query)

      assert page.page_size == 10
      assert page.page_number == 1

      assert inspect(page.entries) == inspect(query |> limit([_], ^10) |> offset([_], ^0))
      assert page.total_pages == 2
    end

    it "removes invalid clauses before counting total pages" do
      query = Person
      |> where([p], p.age > 30)
      |> order_by([p], desc: p.age)
      |> preload(:friends)
      |> select([p], {p.name})

      page = Scrivener.FakeRepo.paginate(query)

      assert page.page_size == 10
      assert page.page_number == 1

      assert inspect(page.entries) == inspect(query |> limit([_], ^10) |> offset([_], ^0))
      assert page.total_pages == 2
    end

    it "can be provided the current page and page size as a params map" do
      query = Person |> where([p], p.age > 30)

      page = Scrivener.FakeRepo.paginate(query, %{"page" => "2", "page_size" => "3"})

      assert page.page_size == 3
      assert page.page_number == 2

      assert inspect(page.entries) == inspect(query |> limit([_], ^3) |> offset([_], ^3))
      assert page.total_pages == 4
    end

    it "can be provided the current page and page size as options" do
      query = Person |> where([p], p.age > 30)

      page = Scrivener.FakeRepo.paginate(query, page: 2, page_size: 3)

      assert page.page_size == 3
      assert page.page_number == 2

      assert inspect(page.entries) == inspect(query |> limit([_], ^3) |> offset([_], ^3))
      assert page.total_pages == 4
    end

    it "can be provided a Scrivener.Config directly" do
      query = Person |> where([p], p.age > 30)
      config = %Scrivener.Config{
        page_number: 3,
        page_size: 4,
        repo: Scrivener.AnotherFakeRepo
      }

      page = Scrivener.paginate(query, config)

      assert page.page_size == 4
      assert page.page_number == 3

      assert inspect(page.entries) == inspect(query |> limit([_], ^4) |> offset([_], ^8))
      assert page.total_pages == 2
    end
  end
end
