defmodule Scrivener.Config do
  defstruct [:page_number, :page_size, :repo]

  def new(repo, defaults, opts) when is_list(opts) do
    default_page_size = default_page_size(defaults)
    page_number = opts[:page] |> to_int(1)
    page_size = opts[:page_size] |> to_int(default_page_size)

    %Scrivener.Config{
      page_number: page_number,
      page_size: page_size,
      repo: repo
    }
  end

  def new(repo, defaults, %{} = params) do
    page_number = params["page"] |> to_int(1)
    page_size = params["page_size"] |> to_int(defaults[:page_size])

    %Scrivener.Config{
      page_number: page_number,
      page_size: page_size,
      repo: repo
    }
  end

  defp default_page_size(page_size: page_size), do: page_size
  defp default_page_size(_), do: 10

  defp to_int(:error, default), do: default
  defp to_int(nil, default), do: default
  defp to_int({i, _}, _), do: i
  defp to_int(i, _) when is_integer(i), do: i
  defp to_int(s, default) when is_binary(s), do: Integer.parse(s) |> to_int(default)
end
