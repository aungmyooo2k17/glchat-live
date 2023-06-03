defmodule GlchatLiveWeb.Components.EmptyChatScreen do
  use Surface.LiveComponent

  def render(assigns) do
    ~H"""
    <div class="empty-chat-screen">
      <div class="empty-chat-screen__text">
        <p>There are no messages yet.</p>
        <p>Be the first to send a message!</p>
      </div>
    </div>
    """
  end
end
