defprotocol Scrivener.Paginater do
  @spec paginate(any, Scrivener.Config.t) :: Scrivener.Page.t
  def paginate(pageable, config)
end
