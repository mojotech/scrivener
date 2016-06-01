defmodule Scrivener.Author do
  use Ecto.Schema

  schema "authors" do
    field :name, :string

    has_many :comments, Scrivener.Comment

    timestamps
  end
end
