defmodule GlchatLiveWeb.Layouts.ChatListPane do
  @moduledoc false
  use Surface.LiveComponent

  alias GlchatLiveWeb.Components.ChatListItem

  prop users, :list, required: true

  def render(assigns) do
    ~H"""
    <div class="col-2">
      <h2>Friend list</h2>
      <ul>
        <%!-- <li class="online / offline / busy">Aung</li> --%>

        <%= for user <- @users do %>
          <li class={user["live_status"]}><%= user["id"] %></li>
        <% end %>

      </ul>
    </div>
    """
  end
end
