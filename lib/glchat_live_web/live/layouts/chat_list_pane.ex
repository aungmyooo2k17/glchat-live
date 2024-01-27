defmodule GlchatLiveWeb.Layouts.ChatListPane do
  @moduledoc false
  use Surface.LiveComponent
  require Logger

  prop(users, :list, required: true)

  def render(assigns) do
    ~H"""
    <div class="col-2">
      <h2>Friend list</h2>
      <ul class="p-6 divide-y divide-slate-200">
        <%!-- <li class="online / offline / busy">Aung</li> --%>

        <%= for user <- @users do %>
          <li class="flex py-4 first:pt-0 last:pb-0" phx-click="select_chat_user" phx-value-selected_user_id={user["id"]}>
            <img class="h-10 w-10 rounded-full" src="http://localhost:4003/api/download/sample-bucket/bike.jpeg" alt="" />
            <div class="ml-3 overflow-hidden">
              <p class="text-sm font-medium text-slate-900"><%= user["username"] %></p>
              <p class="text-sm text-slate-500 truncate">Hfewifhioewjfewjfioewfjioewjfioewi</p>
            </div>
          </li>
        <% end %>

      </ul>
    </div>
    """
  end

  def send_message() do
    Logger.info("send_message")
  end
end
