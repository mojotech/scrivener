defmodule Scrivener.PageTest do
  use Scrivener.TestCase

  alias Scrivener.Page

  describe "enumerable" do
    test "implements enumerable" do
      post1 = %{title: "post 1"}
      post2 = %{title: "post 2"}
      page = %Page{entries: [post1, post2]}

      titles = Enum.map(page, &Map.get(&1, :title))

      assert titles == ["post 1", "post 2"]
    end

    test "behaviour when empty" do
      assert [] = Enum.map(%Page{}, &Map.get(&1, :title))
    end
  end

  describe "collectable" do
    post1 = %{title: "post 1"}
    post2 = %{title: "post 2"}

    assert %Page{entries: [^post1, ^post2]} = Enum.into([post1, post2], %Page{})
  end
end
