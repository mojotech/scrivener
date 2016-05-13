defmodule Scrivener.PageTest do
  use Scrivener.TestCase

  alias Scrivener.Page
  alias Scrivener.Post

  describe "reduce" do
    it "reduces the entries" do
      post1 = %Post{published: false}
      post2 = %Post{published: true}
      page = %Page{entries: [post1, post2]}

      [post] = Enum.filter(page, fn post -> post.published end)

      assert post == post2
    end
  end

  describe "count" do
    it "returns size of entries" do
      assert Enum.count(%Page{entries: [%Post{}]}) == 1
      assert Enum.count(%Page{entries: []}) == 0
    end
  end

  describe "member?" do
    it "checks if value exists within entries" do
      post = %Post{title: "Hola"}
      page = %Page{entries: [post]}

      assert Enum.member?(page, post)
      refute Enum.member?(page, %Post{title: "Hello"})
    end
  end
end
