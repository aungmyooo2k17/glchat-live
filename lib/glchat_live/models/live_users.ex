defmodule GlchatLive.Models.LiveUsers do
  alias GlchatLive.Repo

  def get_all_live_user() do
    Repo.all(GlchatLive.Schema.LiveUser)
  end
end
