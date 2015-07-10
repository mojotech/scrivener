if Code.ensure_loaded?(Phoenix.HTML) do
  defmodule Scrivener.Paginator do
    use Phoenix.HTML

    def paginate(paginator) do
      paginate(paginator, :bootstrap)
    end

    def paginate(paginator, :bootstrap = style) do
      # Currently nesting content_tag's is broken...
      links = convert_to_links(paginator)
      |> Enum.map fn (link)->
        l = link_for(link, paginator, style)
        content_tag(:li, l)
      end
      ul = content_tag(:ul, links, class: "pagination")
      content_tag(:nav, ul)
    end

    defp link_for({text, page_number}, paginator, :bootstrap) do
      classes = []
      if paginator.page_number == page_number do
        classes = ["active"]
      end
      link("#{text}", to: "?page=#{page_number}", class: Enum.join(classes, " "))
    end

    @distance 5
    @next ">>"
    @previous "<<"
    defp convert_to_links(paginator) do
      page_number_list(paginator.page_number, paginator.total_pages, @distance)
      |> Enum.to_list
      |> Enum.map fn
        :next -> {@next, paginator.page_number + 1}
        :previous -> {@previous, paginator.page_number - 1}
        num -> {num, num}
      end
    end

    defp page_number_list(page, total, distance) when page == 1 do
      Enum.to_list(1..(page + distance)) ++ [total, :next]
    end
    defp page_number_list(page, total, distance) when page - distance <= 0 do
      [:previous] ++ Enum.to_list(1..page) ++ Enum.to_list((page + 1)..(page + distance)) ++ [total, :next]
    end
    defp page_number_list(page, total, distance) when page + distance >= total do
      [:previoius, 1] ++ Enum.to_list((page - distance)..page) ++ Enum.to_list((page + 1)..total) ++ [:next]
    end
    defp page_number_list(page, total, distance) when page == total do
      [:previoius, 1] ++ Enum.to_list((page - distance)..page)
    end
    defp page_number_list(page, total, distance) do
      [:previous, 1] ++ Enum.to_list((page - distance)..page) ++ Enum.to_list((page + 1)..(page + distance)) ++ [total, :next]
    end

  end
end
