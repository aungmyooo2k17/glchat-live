defmodule GlchatLiveWeb.Components.SendMessageItem do
  @moduledoc false
  use Surface.LiveComponent

  def render(assigns) do
    ~H"""

    <form form="send_message" phx-submit="send_message">
      <input class="msg-input" type="text" placeholder="Type a message" name="message"/>
    </form>
    """
  end
end
