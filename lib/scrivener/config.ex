defmodule Scrivener.Config do
  @moduledoc """
  A `Scrivener.Config` can be created with a `caller`, a `page_number`, a `page_size` and a `module`. It can optionally be provided a `Keyword` of `options`.

  The `page_type` can be set to `:simple`(default: `:normal`) to return a `Scrivener.SimplePage` instead of a `Scrivener.Page`.

      %Scrivener.Config{
        caller: self(),
        page_number: 2,
        page_size: 5,
        page_type: :simple,
        module: MyApp.Repo,
        options: [
          foo: "bar"
        ]
      }
  """

  defstruct [:caller, :module, :options, :page_number, :page_size, page_type: :normal]

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
      caller: Map.get(options, "caller", self()),
      module: module,
      options: merged_options(defaults, options),
      page_number: page_number,
      page_size: page_size(defaults, options),
      page_type: page_type(defaults, options)
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

  defp default_page_type(defaults) do
    defaults[:page_type] || :normal
  end

  defp normalize_options(options) do
    Enum.reduce(options, %{}, fn {k, v}, map ->
      Map.put(map, to_string(k), v)
    end)
  end

  defp merged_options(defaults, options) do
    default_opts = Keyword.get(defaults, :options, [])

    opts =
      options
      |> Map.get("options", [])
      |> Keyword.new()

    Keyword.merge(default_opts, opts)
  end

  def page_size(defaults, opts) do
    default_page_size = default_page_size(defaults)
    requested_page_size = opts["page_size"] |> to_int(default_page_size)

    min(requested_page_size, defaults[:max_page_size])
  end

  def page_type(defaults, opts) do
    opts["page_type"] || default_page_type(defaults)
  end

  defp to_int(:error, default), do: default
  defp to_int(nil, default), do: default
  defp to_int(b, default) when is_binary(b), do: b |> Integer.parse() |> to_int(default)
  defp to_int(i, default) when is_integer(i), do: to_int({i, nil}, default)
  defp to_int({i, _}, default) when is_integer(i) and i < 1, do: default
  defp to_int({i, _}, _) when is_integer(i), do: i
  defp to_int(_, default), do: default
end
