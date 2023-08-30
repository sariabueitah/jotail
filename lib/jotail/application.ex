defmodule Jotail.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      JotailWeb.Telemetry,
      # Start the Ecto repository
      Jotail.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Jotail.PubSub},
      # Start Finch
      {Finch, name: Jotail.Finch},
      # Start the Endpoint (http/https)
      JotailWeb.Endpoint
      # Start a worker by calling: Jotail.Worker.start_link(arg)
      # {Jotail.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Jotail.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JotailWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
