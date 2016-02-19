defmodule Octopus do
  use Application

  def start(_type, _args) do
    IO.puts("Hello Octopus")
    Task.start(fn -> :timer.sleep(1000); IO.puts("done sleeping") end)
  end

end
