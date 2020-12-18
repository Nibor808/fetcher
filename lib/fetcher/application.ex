defmodule Fetcher.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Fetcher.UserAPI
      # Starts a worker by calling: Fetcher.Worker.start_link(arg)
      # {Fetcher.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fetcher.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
