defmodule Scrivener.Config do
  @moduledoc """
  A `Scrivener.Config` can be created with a `page_number`, a `page_size` and a `module`. An optional `max_page_size` can also be included.

      %Scrivener.Config{
        page_number: 2,
        page_size: 5,
        max_page_size: 50,
        module: MyApp.Repo
      }
  """

  defstruct [:module, :page_number, :page_size]

  @type t :: %__MODULE__{}

  @doc false
  def new(module, defaults, nil) do
    new(module, defaults, %{})
  end

  @doc false
  def new(module, defaults, options) do
    options = normalize_options(options)
    page_number = options["page"] |> to_int(1)

    %Scrivener.Config{
      module: module,
      page_number: page_number,
      page_size: page_size(defaults, options)
    }
  end

  @doc false
  def new(options) do
    options = normalize_options(options)

    new(options["module"], [], options)
  end

  defp default_page_size(defaults) do
    defaults[:page_size] || 10
  end

  defp normalize_options(options) do
    Enum.reduce(options, %{}, fn {k, v}, map ->
      Map.put(map, to_string(k), v)
    end)
  end

  def page_size(defaults, opts) do
    default_page_size = default_page_size(defaults)
    requested_page_size = opts["page_size"] |> to_int(default_page_size)

    min(requested_page_size, defaults[:max_page_size])
  end

  defp to_int(:error, default), do: default
  defp to_int(nil, default), do: default
  defp to_int(i, default) when is_integer(i), do: to_int({i, nil}, default)
  defp to_int(s, default) when is_binary(s), do: s |> Integer.parse |> to_int(default)
  defp to_int({i, _}, default) when is_integer(i) and i < 1, do: default
  defp to_int({i, _}, _) when is_integer(i), do: i
  defp to_int(_, default), do: default
end
