defmodule PhxVite.Repo do
  use Ecto.Repo,
    otp_app: :phx_vite,
    adapter: Ecto.Adapters.Postgres
end
