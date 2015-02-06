defmodule Scrivener.Config do
  defstruct [:page_number, :page_size, :repo]

  def new do
    %Scrivener.Config{
      page_number: 1,
      page_size: defaults[:page_size],
      repo: defaults[:repo]
    }
  end

  def new(%{} = params, opts) do
    page_number = params["page"] |> to_int(1)
    page_size = params["page_size"] |> to_int(defaults[:page_size])
    repo = Dict.get(opts, :repo, defaults[:repo])

    %Scrivener.Config{
      page_number: page_number,
      page_size: page_size,
      repo: repo
    }
  end

  defp defaults do
    Application.get_env(:scrivener, :defaults)
  end

  defp to_int(:error, default), do: default
  defp to_int(nil, default), do: default
  defp to_int({i, _}, _), do: i
  defp to_int(i, _) when is_integer(i), do: i
  defp to_int(s, default) when is_binary(s), do: Integer.parse(s) |> to_int(default)
end
