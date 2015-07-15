if Code.ensure_loaded?(Phoenix.HTML) do
  defmodule Scrivener.HTML do
    use Phoenix.HTML

    defmodule Default do
      def path(opts), do: "?page=#{opts[:page]}"
    end

    @defaults [view_style: :bootstrap, path: &Default.path/1, path_args: []]
    @doc """
    Generates the HTML pagination links for a given paginator returned by Scrivener.

    The default options are:

        #{inspect @defaults}

    The `view_style` indicates which CSS framework you are using. The default is
    `:bootstrap`, but you can add your own using the `Scrivener.HTML.raw_pagination_links/2` function
    if desired. The `path` option is a function which can be used to generate the link URL.
    `path_args` are all the arguments to supply to `path`. An example of the output data:

        iex> Scrivener.HTML.pagination_links(%{total_pages: 10, page_number: 5})
        {:safe,
          ["<nav>",
           ["<ul class=\"pagination\">",
            [["<li>", ["<a class=\"\" href=\"?page=4\">", "&lt;&lt;", "</a>"], "</li>"],
             ["<li>", ["<a class=\"\" href=\"?page=1\">", "1", "</a>"], "</li>"],
             ["<li>", ["<a class=\"\" href=\"?page=2\">", "2", "</a>"], "</li>"],
             ["<li>", ["<a class=\"\" href=\"?page=3\">", "3", "</a>"], "</li>"],
             ["<li>", ["<a class=\"\" href=\"?page=4\">", "4", "</a>"], "</li>"],
             ["<li>", ["<a class=\"active\" href=\"?page=5\">", "5", "</a>"], "</li>"],
             ["<li>", ["<a class=\"\" href=\"?page=6\">", "6", "</a>"], "</li>"],
             ["<li>", ["<a class=\"\" href=\"?page=7\">", "7", "</a>"], "</li>"],
             ["<li>", ["<a class=\"\" href=\"?page=8\">", "8", "</a>"], "</li>"],
             ["<li>", ["<a class=\"\" href=\"?page=9\">", "9", "</a>"], "</li>"],
             ["<li>", ["<a class=\"\" href=\"?page=10\">", "10", "</a>"], "</li>"],
             ["<li>", ["<a class=\"\" href=\"?page=6\">", "&gt;&gt;", "</a>"], "</li>"]],
            "</ul>"], "</nav>"]}
    """
    def pagination_links(paginator, opts \\ []) do
      # TODO: Get view_style from config for default
      options = Dict.merge @defaults, opts
      # Ensure ordering so pattern matching is reliable
      _pagination_links paginator,
        view_style: options[:view_style],
        path: options[:path],
        path_args: options[:path_args]
    end

    # Bootstrap implementation
    defp _pagination_links(paginator, [view_style: :bootstrap, path: path, path_args: path_args]) do
      # Currently nesting content_tag's is broken...
      links = raw_pagination_links(paginator)
      |> Enum.map fn ({text, page_number})->
        classes = []
        if paginator[:page_number] == page_number do
          classes = ["active"]
        end
        l = link("#{text}", to: apply(path, path_args ++ [[page: page_number]]), class: Enum.join(classes, " "))
        content_tag(:li, l)
      end
      ul = content_tag(:ul, links, class: "pagination")
      content_tag(:nav, ul)
    end

    @defaults [distance: 5, next: ">>", previous: "<<", first: true, last: true]
    @doc """
    Returns the raw data in order to generate the proper HTML for pagination links. Data
    is returned in a `{text, page_number}` format where `text` is intended to be the text
    of the link and `page_number` is the page it should go to. Defaults are already supplied
    and they are as follows:

        #{inspect @defaults}

    `distance` must be a positive non-zero integer or an exception is raised. `next` and `previous` should be
    strings but can be anything you want as long as it is truthy, falsey values will remove
    them from the output. `first` and `last` are only booleans, and they just include/remove
    their respective link from output. An example of the data returned:

        iex> Scrivener.HTML.raw_pagination_links(%{total_pages: 10, page_number: 5})
        [{"<<", 4}, {1, 1}, {2, 2}, {3, 3}, {4, 4}, {5, 5}, {6, 6}, {7, 7}, {8, 8}, {9, 9}, {10, 10}, {">>", 6}]

    Simply loop and pattern match over each item and transform it to your custom HTML.
    """
    def raw_pagination_links(paginator, options \\ []) do
      options = Dict.merge @defaults, options
      page_number_list(paginator[:page_number], paginator[:total_pages], options[:distance])
      |> add_first(paginator[:page_number], options[:distance], options[:first])
      |> add_previous(paginator[:page_number])
      |> add_last(paginator[:page_number], paginator[:total_pages], options[:distance], options[:last])
      |> add_next(paginator[:page_number], paginator[:total_pages])
      |> Enum.map(fn
        :next -> if options[:next], do: {options[:next], paginator[:page_number] + 1}
        :previous -> if options[:previous], do: {options[:previous], paginator[:page_number] - 1}
        num -> {num, num}
      end) |> Enum.filter(&(&1))
    end


    # Computing page number ranges
    defp page_number_list(page, total, distance) when is_integer(distance) and distance >= 1 do
      Enum.to_list((page - beginning_distance(page, distance))..(page + end_distance(page, total, distance)))
    end
    defp page_number_list(_page, _total, _distance) do
      raise "Scrivener.HTML: Distance cannot be less than one."
    end

    defp beginning_distance(page, distance) when page - distance < 1 do
      distance + (page - distance - 1)
    end
    defp beginning_distance(_page, distance) do
      distance
    end

    defp end_distance(page, total, distance) when page + distance >= total do
      total - page
    end
    defp end_distance(_page, _total, distance) do
      distance
    end

    # Adding next/prev/first/last links
    defp add_previous(list, page) when page != 1 do
      [:previous] ++ list
    end
    defp add_previous(list, _page) do
      list
    end

    defp add_first(list, page, distance, true) when page - distance > 1 do
      [1] ++ list
    end
    defp add_first(list, _page, _distance, _included) do
      list
    end

    defp add_last(list, page, total, distance, true) when page + distance < total do
      list ++ [total]
    end
    defp add_last(list, _page, _total, _distance, _included) do
      list
    end

    defp add_next(list, page, total) when page != total do
      list ++ [:next]
    end
    defp add_next(list, _page, _total) do
      list
    end

  end
end
