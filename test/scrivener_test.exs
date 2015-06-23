defmodule ScrivenerTest do
  use Scrivener.TestCase

  alias Scrivener.Post
  alias Scrivener.KeyValue

  defp create_posts do
    %Post{
      title: "Title unpublished",
      body: "Body unpublished",
      published: false
    } |> Scrivener.Repo.insert!

    Enum.map(1..6, fn i ->
      %Post{
        title: "Title #{i}",
        body: "Body #{i}",
        published: true
      } |> Scrivener.Repo.insert!
    end)
  end

  defp create_key_values do
    Enum.map(1..10, fn i ->
      %KeyValue{
        key: "key_#{i}",
        value: (rem(i, 2) |> to_string)
      } |> Scrivener.Repo.insert!
    end)
  end

  describe "paginate" do
    it "uses defaults from the repo" do
      posts = create_posts

      page = Post
      |> Post.published
      |> Scrivener.Repo.paginate

      assert page.page_size == 5
      assert page.page_number == 1
      assert page.entries == Enum.take(posts, 5)
      assert page.total_entries == 6
      assert page.total_pages == 2
    end

    it "removes invalid clauses before counting total pages" do
      posts = create_posts

      page = Post
      |> Post.published
      |> order_by([p], desc: p.inserted_at)
      |> Scrivener.Repo.paginate

      assert page.page_size == 5
      assert page.page_number == 1
      assert page.entries == Enum.take(posts, 5)
      assert page.total_pages == 2
    end

    it "can be provided the current page and page size as a params map" do
      posts = create_posts

      page = Post
      |> Post.published
      |> Scrivener.Repo.paginate(%{"page" => "2", "page_size" => "3"})

      assert page.page_size == 3
      assert page.page_number == 2
      assert page.entries == Enum.drop(posts, 3)
      assert page.total_pages == 2
    end

    it "can be provided the current page and page size as options" do
      posts = create_posts

      page = Post
      |> Post.published
      |> Scrivener.Repo.paginate(page: 2, page_size: 3)

      assert page.page_size == 3
      assert page.page_number == 2
      assert page.entries == Enum.drop(posts, 3)
      assert page.total_pages == 2
    end

    it "can be provided a Scrivener.Config directly" do
      posts = create_posts

      config = %Scrivener.Config{
        page_number: 2,
        page_size: 4,
        repo: Scrivener.Repo
      }

      page = Post
      |> Post.published
      |> Scrivener.paginate(config)

      assert page.page_size == 4
      assert page.page_number == 2
      assert page.entries == Enum.drop(posts, 4)
      assert page.total_pages == 2
    end

    it "can be used on a table with any primary key" do
      create_key_values

      page = KeyValue
      |> KeyValue.zero
      |> Scrivener.Repo.paginate(page_size: 2)

      assert page.total_entries == 5
      assert page.total_pages == 3
    end
  end
end
