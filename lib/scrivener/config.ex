defmodule Scrivener.Config do
  @moduledoc """
  A `Scrivener.Config` can be created with a `page_number`, a `page_size` and a `repo`.

      %Scrivener.Config{
        page_number: 2,
        page_size: 5,
        repo: MyApp.Repo
      }
  """

  defstruct [:page_number, :page_size, :repo]

  @type t :: %__MODULE__{}

  @doc false
  def new(repo, defaults, opts) when is_list(opts) do
    opts = Enum.reduce(opts, %{}, fn {k, v}, map ->
      Map.put(map, to_string(k), v)
    end)

    new(repo, defaults, opts)
  end

  @doc false
  def new(repo, defaults, %{} = opts) do
    default_page_size = default_page_size(defaults)
    page_number = opts["page"] |> to_int(1)
    page_size = opts["page_size"] |> to_int(default_page_size)

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
  defp to_int({i, _}, _) when is_integer(i), do: i
  defp to_int(i, _) when is_integer(i), do: i
  defp to_int(s, default) when is_binary(s), do: Integer.parse(s) |> to_int(default)
  defp to_int(_, default), do: default
end
