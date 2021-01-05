defmodule Scrivener.PageTest do
  use Scrivener.TestCase

  alias Scrivener.Page
  alias Scrivener.Post

  describe "enumerable" do
    test "implements enumerable" do
      post1 = %Post{title: "post 1"}
      post2 = %Post{title: "post 2"}
      page = %Page{entries: [post1, post2]}

      titles = Enum.map(page, &Map.get(&1, :title))

      assert titles == ["post 1", "post 2"]
    end

    test "behaviour when empty" do
      assert [] = Enum.map(%Page{}, &Map.get(&1, :title))
    end
  end

  describe "collectable" do
    @spec build_post_page(list(Post.t())) :: Page.t(Post.t())
    def build_post_page(list), do: Enum.into(list, %Page{})

    test "implements collectable" do
      post1 = %Post{title: "post 1"}
      post2 = %Post{title: "post 2"}

      assert %Page{entries: [^post1, ^post2]} = build_post_page([post1, post2])
    end
  end
end
