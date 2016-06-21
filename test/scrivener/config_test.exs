defmodule Scrivener.ConfigTest do
  use Scrivener.TestCase

  alias Scrivener.Config

  describe "new" do
    test "can be provided options as a keyword" do
      config = Config.new(:module, [], page_number: 1, page_size: 10)

      assert config.module == :module
      assert config.page_number == 1
      assert config.page_size == 10
    end

    test "can be provided options as a map" do
      config = Config.new(:module, [], %{"page_number" => 1, "page_size" => 10})

      assert config.module == :module
      assert config.page_number == 1
      assert config.page_size == 10
    end

    test "converts page number and page size to integers" do
      config = Config.new(:module, [], %{"page_number" => "1", "page_size" => "10"})

      assert config.module == :module
      assert config.page_number == 1
      assert config.page_size == 10
    end

    test "can be provided page size via defaults" do
      config = Config.new(:module, [page_size: 10], %{"page_number" => "1"})

      assert config.module == :module
      assert config.page_number == 1
      assert config.page_size == 10
    end
  end
end
