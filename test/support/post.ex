defmodule Scrivener.Post do
  use Ecto.Model

  schema "posts" do
    field :title, :string
    field :body, :string
    field :published, :boolean

    has_many :comments, Scrivener.Comment

    timestamps
  end

  def published(query) do
    query |> where([p], p.published == true)
  end
end
