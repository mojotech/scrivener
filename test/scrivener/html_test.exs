defmodule Scrivener.HTMLTest do
  use Scrivener.TestCase
  alias Scrivener.HTML
  import Scrivener.Support.HTML
  alias Scrivener.Page

  describe "raw_pagination_links" do

    describe "for a page" do

      it "in the middle" do
        assert pages(45..55) == links_with_opts total_pages: 100, page_number: 50
      end

      it ":distance from the first" do
        assert pages(1..10) == links_with_opts total_pages: 20, page_number: 5
      end

      it "2 away from the first" do
        assert pages(1..8) == links_with_opts total_pages: 10, page_number: 3
      end

      it "1 away from the first" do
        assert pages(1..7) == links_with_opts total_pages: 10, page_number: 2
      end

      it "at the first" do
        assert pages(1..6) == links_with_opts total_pages: 10, page_number: 1
      end

      it ":distance from the last" do
        assert pages(10..20) == links_with_opts total_pages: 20, page_number: 15
      end

      it "2 away from the last" do
        assert pages(3..10) == links_with_opts total_pages: 10, page_number: 8
      end

      it "1 away from the last" do
        assert pages(4..10) == links_with_opts total_pages: 10, page_number: 9
      end

      it "at the last" do
        assert pages(5..10) == links_with_opts total_pages: 10, page_number: 10
      end

    end

    describe "next" do

      it "includes a next" do
        assert pages_with_next(45..55, 51) == links_with_opts [total_pages: 100, page_number: 50], next: ">>"
      end

      it "does not include next when equal to the total" do
        assert pages(5..10) == links_with_opts [total_pages: 10, page_number: 10], next: ">>"
      end

      it "can disable next" do
        assert pages(45..55) == links_with_opts [total_pages: 100, page_number: 50], next: false
      end

    end

    describe "previous" do

      it "includes a previous" do
        assert pages_with_previous(49, 45..55) == links_with_opts [total_pages: 100, page_number: 50], previous: "<<"
      end

      it "does not include previous when equal to page 1" do
        assert pages(1..6) == links_with_opts [total_pages: 10, page_number: 1], previous: "<<"
      end

      it "can disable previous" do
        assert pages(45..55) == links_with_opts [total_pages: 100, page_number: 50], previous: false
      end

    end

    describe "first" do

      it "includes the first" do
        assert pages_with_first(1, 5..15) == links_with_opts [total_pages: 20, page_number: 10], first: true
      end

      it "does not the include the first when it is already included" do
        assert pages(1..10) == links_with_opts [total_pages: 10, page_number: 5], first: true
      end

      it "can disable first" do
        assert pages(5..15) == links_with_opts [total_pages: 20, page_number: 10], first: false
      end

    end

    describe "last" do

      it "includes the last" do
        assert pages_with_last(5..15, 20) == links_with_opts [total_pages: 20, page_number: 10], last: true
      end

      it "does not the include the last when it is already included" do
        assert pages(1..10) == links_with_opts [total_pages: 10, page_number: 5], last: true
      end

      it "can disable last" do
        assert pages(5..15) == links_with_opts [total_pages: 20, page_number: 10], last: false
      end

    end

    describe "distance" do

      it "can change the distance" do
        assert pages(1..3) == links_with_opts [total_pages: 3, page_number: 2], distance: 1
      end

      it "does not allow negative distances" do
        assert_raise RuntimeError, fn ->
          links_with_opts [total_pages: 10, page_number: 5], distance: -5
        end
      end

    end
  end

  describe "pagination_links" do

    it "accepts a paginator and options (same as defaults)" do
      assert {:safe, _html} = HTML.pagination_links(%Page{total_pages: 10, page_number: 5}, view_style: :bootstrap, path: &MyApp.Router.Helpers.post_path/3)
    end

    it "supplies defaults" do
      assert {:safe, _html} = HTML.pagination_links(%Page{total_pages: 10, page_number: 5})
    end

    it "allows options in any order" do
      assert {:safe, _html} = HTML.pagination_links(%Page{total_pages: 10, page_number: 5}, view_style: :bootstrap, path: &MyApp.Router.Helpers.post_path/3)
    end

    it "errors for unsupported view styles" do
      assert_raise RuntimeError, fn ->
        HTML.pagination_links(%Page{total_pages: 10, page_number: 5}, view_style: :unknown)
      end
    end

  end

end
