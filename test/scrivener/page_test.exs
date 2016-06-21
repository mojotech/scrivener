defmodule Scrivener.PageTest do
  use Scrivener.TestCase

  alias Scrivener.Page

  describe "enumerable" do
    it "implements enumerable" do
      post1 = %{title: "post 1"}
      post2 = %{title: "post 2"}
      page = %Page{entries: [post1, post2]}

      titles = Enum.map(page, &Map.get(&1, :title))

      assert titles == ["post 1", "post 2"]
    end
  end
end
