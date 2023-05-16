defmodule GlchatLive.Repo do
  use Ecto.Repo,
    otp_app: :glchat_live,
    adapter: Ecto.Adapters.Postgres
end
