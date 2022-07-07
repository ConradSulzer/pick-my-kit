defmodule PUBG.Repo do
  use Ecto.Repo,
    otp_app: :pubg,
    adapter: Ecto.Adapters.Postgres
end
