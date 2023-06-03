defmodule GlchatLiveWeb.Layouts.ChatListPane do
  @moduledoc false
  use Surface.LiveComponent
  require Logger

  prop(users, :list, required: true)

  def render(assigns) do
    ~H"""
    <div class="col-2">
      <h2>Friend list</h2>
      <ul>
        <%!-- <li class="online / offline / busy">Aung</li> --%>

        <%= for user <- @users do %>
          <li class={user["live_status"]} phx-click="select_chat_user" phx-value-selected_user_id={user["id"]}><%= user["id"] %></li>
        <% end %>

      </ul>
    </div>
    """
  end

  def send_message() do
    Logger.info("send_message")
  end


end
