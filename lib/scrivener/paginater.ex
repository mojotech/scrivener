defprotocol Scrivener.Paginater do
  @moduledoc """
  The `Scrivener.Paginater` protocol should be implemented for any type that requires pagination.
  """

  @doc """
  The paginate function will be invoked with the item to paginate along with a `Scrivener.Config`. It is expected to return a `Scrivener.Page`.
  """
  @spec paginate(any, Scrivener.Config.t()) :: Scrivener.Page.t()
  def paginate(pageable, config)
end
