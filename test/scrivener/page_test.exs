defmodule Scrivener.PageTest do
  use Scrivener.TestCase

  alias Scrivener.Page
  alias Scrivener.Post

  describe "enumerable protocol implementation" do
    describe "reduce" do
      it "reduces entries collection" do
        page = %Page{entries: [%Post{published: false}, %Post{published: true}]}

        posts = Enum.reduce(page, [], fn
          (%{published: true} = post, acc) -> [post|acc]
          (%{published: false}, acc) -> acc
        end)

        assert Enum.all?(posts, fn(post) -> post.published end)
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
end
