defmodule GlchatLiveWeb.Layouts.RootLayout do
  @moduledoc false
  alias GlchatLiveWeb.Layouts.{ChatPane, ChatListPane}
  use Surface.LiveComponent

  prop(app_prop, :map, default: %{})
  def render(assigns) do
    ~H"""
    <div class="container">
        <div class="chatbox">
          <.live_component module={ChatPane} id="ChatPane"></.live_component>
          <.live_component module={ChatListPane} users={@app_prop.users} id="ChatListPane"></.live_component>
        </div>
      </div>
    """
  end
end
