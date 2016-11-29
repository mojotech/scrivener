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

    test "converts page number and page size to integers" do
      config = Config.new(:module, [], %{"page" => "2", "page_size" => "15"})

      assert config.module == :module
      assert config.page_number == 2
      assert config.page_size == 15
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

    test "defaults negative page size and page number appropriately" do
      config = Config.new(%{"module" => :module, "page" => "-15", "page_size" => "-15"})

      assert config.module == :module
      assert config.page_number == 1
      assert config.page_size == 10
    end

    test "can provide show_totals option as a keyword" do
      config = Config.new(:module, [show_totals: true], %{"show_totals" => false})

      assert config.module == :module
      assert config.page_number == 1
      assert config.page_size == 10
      assert config.show_totals == false
    end

      test "defaults show_totals to true" do
      config = Config.new(%{"module" => :module})

      assert config.module == :module
      assert config.show_totals == true
    end

    test "defaults non-boolean show_totals option appropriately" do
      config = Config.new(%{"module" => :module, "show_totals" => "-15"})

      assert config.module == :module
      assert config.show_totals == true
    end
  end
end
