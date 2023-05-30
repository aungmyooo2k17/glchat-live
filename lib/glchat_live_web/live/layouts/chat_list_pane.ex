defmodule GlchatLiveWeb.Layouts.ChatListPane do
  @moduledoc false
  use Surface.LiveComponent

  alias GlchatLiveWeb.Components.ChatListItem

  def render(assigns) do
    ~H"""
    <div class="col-2">
      <h2>Friend list</h2>
      <ul>
        <li class="online">Aung</li>
        <li class="offline">Mai</li>
        <li class="busy">Thiri</li>
        <li class="online">KyawKyaw</li>
      </ul>
    </div>
    """
  end
end
