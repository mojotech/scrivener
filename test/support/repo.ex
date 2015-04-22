defmodule Scrivener.Repo do
  use Ecto.Repo, otp_app: :scrivener
  use Scrivener, page_size: 5
end
