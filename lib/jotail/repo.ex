defmodule Jotail.Repo do
  use Ecto.Repo,
    otp_app: :jotail,
    adapter: Ecto.Adapters.Postgres
end
