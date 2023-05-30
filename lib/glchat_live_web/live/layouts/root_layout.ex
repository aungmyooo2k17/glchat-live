defmodule GlchatLiveWeb.Layouts.RootLayout do
  @moduledoc false
  alias GlchatLiveWeb.Layouts.{ChatPane, ChatListPane}
  use Surface.LiveComponent

  def render(assigns) do
    ~H"""
    <div class="container">
        <div class="chatbox">
          <.live_component module={ChatPane} id="hello"></.live_component>
          <.live_component module={ChatListPane} id="hello"></.live_component>
        </div>
      </div>
    """
  end
end
