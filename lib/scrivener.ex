defmodule Scrivener do
  @moduledoc """
  Scrivener is a pagination library for the Elixir ecosystem. You most likely won't use Scrivener directly, but rather a library that implements Scrivener's Paginater protocol for the object you're trying to paginate.
  """

  @doc """
  Scrivener is meant to be `use`d by a module.

  When `use`d, an optional default for `page_size` can be provided. If `page_size` is not provided a default of 10 will be used.

  A `max_page_size` can also optionally can be provided. This enforces a hard ceiling for the page size, even if you allow users of your application to specify `page_size` via query parameters. If not provided, there will be no limit to page size.

      defmodule MyApp.Module do
        use Scrivener
      end

      defmodule MyApp.Module do
        use Scrivener, page_size: 5, max_page_size: 100
      end

    When `use` is called, a `paginate` function is defined in the module. See the `Scrivener.Paginater` protocol documentation for more information.
  """
  defmacro __using__(opts) do
    quote do
      @scrivener_defaults unquote(opts)

      @spec scrivener_defaults() :: Keyword.t()
      def scrivener_defaults, do: @scrivener_defaults

      @spec paginate(any, map | Keyword.t()) :: Scrivener.Page.t()
      def paginate(pageable, options \\ []) do
        Scrivener.paginate(
          pageable,
          Scrivener.Config.new(__MODULE__, @scrivener_defaults, options)
        )
      end
    end
  end

  @typep convertable_to_config :: map | Keyword.t()

  @doc false
  @spec paginate(any, Scrivener.Config.t() | convertable_to_config()) :: Scrivener.Page.t()
  def paginate(pageable, %Scrivener.Config{} = config) do
    Scrivener.Paginater.paginate(pageable, config)
  end

  @doc false
  def paginate(pageable, options) do
    Scrivener.paginate(pageable, Scrivener.Config.new(options))
  end
end
