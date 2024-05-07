defmodule PhxVite.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxViteWeb.Telemetry,
      PhxVite.Repo,
      {DNSCluster, query: Application.get_env(:phx_vite, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxVite.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxVite.Finch},
      # Start a worker by calling: PhxVite.Worker.start_link(arg)
      # {PhxVite.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxViteWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxVite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxViteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
