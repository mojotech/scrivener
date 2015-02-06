defmodule Scrivener.Config do
  defstruct [:page_number, :page_size, :repo]

  def new(repo, defaults, query, opts) when is_list(opts) do
    page_number = opts[:page] |> to_int(1)
    page_size = opts[:page_size] |> to_int(defaults[:page_size])

    %Scrivener.Config{
      page_number: page_number,
      page_size: page_size,
      repo: repo
    }
  end

  def new(repo, defaults, query, %{} = params) do
    page_number = params["page"] |> to_int(1)
    page_size = params["page_size"] |> to_int(defaults[:page_size])

    %Scrivener.Config{
      page_number: page_number,
      page_size: page_size,
      repo: repo
    }
  end

  defp to_int(:error, default), do: default
  defp to_int(nil, default), do: default
  defp to_int({i, _}, _), do: i
  defp to_int(i, _) when is_integer(i), do: i
  defp to_int(s, default) when is_binary(s), do: Integer.parse(s) |> to_int(default)
end
