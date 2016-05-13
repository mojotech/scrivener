defmodule Scrivener.PageTest do
  use Scrivener.TestCase

  alias Scrivener.Post
  alias Scrivener.Page

  describe "enumerable" do
    it "implements enumerable" do
      post1 = %Post{title: "post 1"}
      post2 = %Post{title: "post 2"}
      page = %Page{entries: [post1, post2]}

      titles = Enum.map(page, fn entry -> entry.title end)

      assert titles == ["post 1", "post 2"]
    end
  end
end
