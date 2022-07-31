defmodule Goliath.Repo do
  use Ecto.Repo,
    otp_app: :goliath_credits_persistence,
    adapter: Ecto.Adapters.Postgres
end
