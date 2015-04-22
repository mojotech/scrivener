defmodule Mix.Tasks.Db.Reset do
  use Mix.Task

  def run(_args) do
    Logger.configure(level: :error)

    Mix.Task.run("ecto.drop", [])
    Mix.Task.run("ecto.create", [])
    Mix.Task.run("ecto.migrate", [])
  end
end
