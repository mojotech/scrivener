defmodule ScrivenerTest do
  use Scrivener.TestCase

  test "should returns default values" do
    defmodule TestModule do
      use Scrivener, page_size: 10, max_page_size: 20
    end

    assert [page_size: 10, max_page_size: 20] = TestModule.scrivener_defaults()
  end
end
