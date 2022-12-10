defmodule Module1 do
  def start(initial_state \\ []) do
    spawn fn -> run(initial_state) end
  end

  def run(state) do
    state
    |> listen
    |> run
  end

  def listen(state) do
    receive do
      :some_message -> Core.do_work(state)
      :another_message -> Core.do_other_work(state)
    end
end
