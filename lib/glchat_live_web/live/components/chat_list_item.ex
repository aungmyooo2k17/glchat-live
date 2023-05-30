defmodule GlchatLiveWeb.Components.ChatListItem do
  @moduledoc false
  use Surface.LiveComponent

  def render(assigns) do
    ~H"""
      <div class="msg-row">
        <div class="msg-text">
          <h2>Steve Austin</h2>
          <p>I am waiting for your reply</p>
        </div>
        <img
          src="https://www.gstatic.com/ac/family/images/join_family_error_ab42317bf12649f06e1b6d26dd6f42cb.png"
          alt=""
          class="msg-img"
        />
      </div>
    """
  end
end
