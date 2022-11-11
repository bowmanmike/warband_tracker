defmodule WarbandTracker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WarbandTrackerWeb.Telemetry,
      # Start the Ecto repository
      WarbandTracker.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: WarbandTracker.PubSub},
      # Start Finch
      {Finch, name: WarbandTracker.Finch},
      # Start the Endpoint (http/https)
      WarbandTrackerWeb.Endpoint
      # Start a worker by calling: WarbandTracker.Worker.start_link(arg)
      # {WarbandTracker.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WarbandTracker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WarbandTrackerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
