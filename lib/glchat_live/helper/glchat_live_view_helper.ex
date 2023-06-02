defmodule GlchatLive.Helper.GlchatLiveViewHelper do
  def get_assign(socket, key) do
    assigns = Map.get(socket, :assigns, %{})
    Map.get(assigns, key)
  end
end
