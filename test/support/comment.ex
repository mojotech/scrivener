defmodule Scrivener.Comment do
  use Ecto.Model

  schema "comments" do
    field :body, :string

    belongs_to :post, Scrivener.Post

    timestamps
  end
end
