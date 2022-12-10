defmodule SuperDuper.Server do
  use GenServer
  alias SuperDuper.Core

  def start_link({character, _says}=info) do
    GenServer.start_link(__MODULE__, info, name: character)
  end
  def start_link(character) do
    GenServer.start_link(__MODULE__, character, name: character)
  end

  def child_spec({name, says}) do
    %{id: name, start: {__MODULE__, :start_link, [{name, says}]}}
  end
  def child_spec(name) do
    %{id: name, start: {__MODULE__, :start_link, [name]}}
  end

  def die(server), do: GenServer.cast server, :die
  def say(server), do: GenServer.call server, :say

  def init({character, _says}=info) do
    IO.puts "Starting #{character}"
    {:ok, info}
  end
  def init(character) do
    IO.puts "Starting #{character}"
    {:ok, Core.info(character)}
  end

  def handle_cast(:die, state) do
    raise "Boom"
    {:no_reply, state}
  end

  def handle_call(:say, _from, {_name, says}=state) do
    {:reply, says, state}
  end

  def terminate(_reason, {name, _says} = state) do
    IO.puts("Mayday! Mayday! #{name} going down...")
    {:error, "oh noes", state}
  end
end
