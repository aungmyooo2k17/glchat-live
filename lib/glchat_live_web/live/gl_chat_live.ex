defmodule GlchatLiveWeb.GlChatLive do
  @moduledoc false
  use Phoenix.LiveView
  import Surface
  require Logger

  alias GlchatLive.UsersChats

  def mount(%{"current_user_id" => current_user_id} = assigns, _session, socket) do
    Logger.info("USER_ID::#{current_user_id} - " <> "Mount started")

    socket =
      assign(socket,
        current_user_id: current_user_id,
        message: "Salamat, Raya.",
        chat_list: []
      )

    init_handlers(socket)
  end

  def init_handlers(socket) do
    Logger.info("USER_ID::#{inspect(socket.assigns.current_user_id)} - init_handlers")

    chats = UsersChats.filter_chats_users(socket.assigns.current_user_id)

    IO.inspect(chats)

    socket =
      assign(socket,
        chat_list: chats
      )

    {:ok, socket}
  end

  def handle_info(:call_back_func_name, socket) do
    socket =
      assign(socket,
        message: "Good morning."
      )

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div style="font-size: 30px;text-align: center;color: black;margin-top: 50px;"><%= @message %></div>
      <div style="font-size: 30px;text-align: left;color: black;margin-top: 50px;">
        <%= for user <- @chat_list do %>
          <%= user.name %> <br/>
        <% end %>
      </div>
    </div>
    """
  end
end
