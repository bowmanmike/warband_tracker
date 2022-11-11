defmodule WarbandTracker.Repo do
  use Ecto.Repo,
    otp_app: :warband_tracker,
    adapter: Ecto.Adapters.Postgres
end
