defmodule Scrivener.Page do
  use Scrivener.TestCase

  alias Scrivener.Page
  alias Scrivener.Post

  describe "enumerable protocol implementation" do
    context "when entries field is missing" do
      it "considers page to be an empty collection" do
        page = Map.delete(%Page{}, :entries)

        assert Enum.count(page) == 0
      end
    end

    context "when entries field is nil" do
      it "considers page to be an empty collection" do
        assert Enum.count(%Page{}) == 0
      end
    end

    context "when entries field is a list" do
      it "considers page to be a collection" do
        page = %Page{entries: [%Post{}, %Post{}]}

        assert Enum.count(page) == 2
      end
    end
  end
end
