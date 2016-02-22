defmodule Octopus do
  use Application

  def start(_type, _args) do
    IO.puts("Hello Octopus")

    ds = DataServer.start

    IO.puts inspect(ds)

    send(ds, {:ping, self, "Hallo"})

    DataServer.get_response

    Task.start(fn -> :timer.sleep(10000); IO.puts("done sleeping") end)
  end
end


defmodule Fac do
  def fac(0), do: 1
  def fac(n), do: n*fac(n-1)
end


defmodule TodoList do
  def new do
    HashDict.new
  end
end


defimpl String.Chars, for: HashDict do
  def to_string(todo_list) do
    "lala"
  end
end


defmodule DataServer do

  def start do
    spawn(&loop/0)
  end

  defp loop do
    receive do
      {:ping, caller, message} -> send(caller, {:pong, message})
    end

    loop
  end

  def get_response do
    receive do
      {:pong, message} -> IO.puts(message)
      after 5000 -> IO.puts("timeout")
    end
  end

end
