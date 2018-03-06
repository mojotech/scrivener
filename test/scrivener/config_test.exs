defmodule Scrivener.ConfigTest do
  use Scrivener.TestCase

  alias Scrivener.Config

  describe "new" do
    test "can be provided options as nil" do
      config = Config.new(:module, [], nil)

      assert config.module == :module
      assert config.page_number == 1
      assert config.page_size == 10
    end

    test "can be provided options as a keyword" do
      config = Config.new(:module, [], page: 2, page_size: 15)

      assert config.module == :module
      assert config.page_number == 2
      assert config.page_size == 15
    end

    test "can be provided options as a map" do
      config = Config.new(:module, [], %{"page" => 2, "page_size" => 15})

      assert config.module == :module
      assert config.page_number == 2
      assert config.page_size == 15
    end

    test "converts page number, page size and offset to integers" do
      config = Config.new(:module, [], %{"page" => "2", "page_size" => "15", "offset" => "2"})

      assert config.module == :module
      assert config.page_number == 2
      assert config.page_size == 15
      assert config.offset == 2
    end

    test "can be created without offset and offset will be nil" do
      config = Config.new(:module, [], %{"page" => "2", "page_size" => "15"})

      assert config.module == :module
      assert config.page_number == 2
      assert config.page_size == 15
      assert config.offset == nil
    end

    test "can be provided page size via defaults" do
      config = Config.new(:module, [page_size: 15], %{"page" => "2"})

      assert config.module == :module
      assert config.page_number == 2
      assert config.page_size == 15
    end

    test "can be created without defaults" do
      config = Config.new(%{"module" => :module, "page" => "2", "page_size" => "15"})

      assert config.module == :module
      assert config.page_number == 2
      assert config.page_size == 15
    end

    test "can provide max_page_size option as a keyword" do
      config = Config.new(:module, [max_page_size: 10], %{"page_size" => "15"})

      assert config.module == :module
      assert config.page_number == 1
      assert config.page_size == 10
    end

    test "caller is `self` if not provided" do
      config = Config.new(:module, [], %{})

      assert config.caller == self()
    end

    test "can be provided caller as an option" do
      config1 = Config.new(:module, [], caller: "caller")
      config2 = Config.new(:module, [], %{"caller" => "caller"})

      assert config1.caller == "caller"
      assert config2.caller == "caller"
    end

    test "can provide arbitrary custom options in defaults" do
      config = Config.new(:module, [options: [foo: "bar"]], %{})

      assert config.options == [foo: "bar"]
    end

    test "can provide arbitrary custom options" do
      config = Config.new(:module, [options: [foo: "bar", baz: "boom"]], %{options: [foo: "qux"]})

      assert Enum.sort(config.options) == [baz: "boom", foo: "qux"]
    end

    test "can provide arbitrary custom as a map" do
      config =
        Config.new(:module, [options: [foo: "bar", baz: "boom"]], %{options: %{foo: "qux"}})

      assert Enum.sort(config.options) == [baz: "boom", foo: "qux"]
    end

    test "defaults negative page size and page number appropriately" do
      config = Config.new(%{"module" => :module, "page" => "-15", "page_size" => "-15"})

      assert config.module == :module
      assert config.page_number == 1
      assert config.page_size == 10
    end
  end
end
