defmodule Coex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CoexWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:coex, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Coex.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Coex.Finch},
      # Start a worker by calling: Coex.Worker.start_link(arg)
      # {Coex.Worker, arg},
      # Start to serve requests, typically the last entry
      CoexWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Coex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CoexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
