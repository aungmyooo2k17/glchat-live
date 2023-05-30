defmodule GlchatLiveWeb.Components.SendMessageItem do
  @moduledoc false
  use Surface.LiveComponent

  def render(assigns) do
    ~H"""
      <input class="msg-input" type="text" placeholder="Type a message" />
    """
  end
end
