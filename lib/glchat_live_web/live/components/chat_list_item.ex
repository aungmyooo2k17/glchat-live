defmodule GlchatLiveWeb.Components.ChatListItem do
  @moduledoc false
  use Surface.LiveComponent

  prop(message, :map, default: %{})
  prop(current_user_id, :integer, default: "")

  def render(assigns) do
    ~H"""
      <div class={if @message["user_id"] == @current_user_id, do: "msg-row msg-row2", else: "msg-row"}>
        <div class="msg-text">
          <p><%= @message["content"] %></p>
        </div>
      </div>
    """
  end
end
