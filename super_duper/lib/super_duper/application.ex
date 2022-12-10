defmodule SuperDuper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias SuperDuper.Server

  @impl true
  def start(_type, _args) do
    IO.puts(">>>> Starting Super-duper Super-visor <<<<")

    children = [
      {Server, :superman},
      {Server, :superdave},
      {Server, :supermario},
      {
        DynamicSupervisor,
        name: SuperDuper.DynamicSupervisor,
        strategy: :one_for_one
      }
    ]

    opts = [strategy: :rest_for_one, name: SuperDuper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
