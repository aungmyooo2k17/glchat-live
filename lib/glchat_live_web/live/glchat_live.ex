defmodule GlchatLiveWeb.GlChatLive do
  @moduledoc false
  use Surface.LiveView
  require Logger

  alias GlchatLive.Helper.GlchatLiveViewHelper
  alias GlchatLiveWeb.Layouts.RootLayout
  alias GlchatLive.UsersChats
  alias GlchatLive.Users
  alias GlchatLiveWeb.Utils.GlchatLiveUtil

  @minutes 10

  def mount(%{"user_id" => user_id} = assigns, _session, socket) do
    socket =
      assign(socket,
        user_id: user_id,
        users: []
      )

    Logger.info("USER_ID::#{user_id} - " <> "Mount started")

    #######################
    # User status update  #
    #######################
    Task.start(fn ->
      Logger.info("USER_ID::#{user_id} - " <> "Task started")
      Users.update_or_inserted_user_status(user_id, "online")
      Logger.info("USER_ID::#{user_id} - " <> "Task ended")
    end)

    init_handlers(socket)
  end

  defp init_handlers(socket) do
    Logger.info("USER_ID::#{inspect(socket.assigns.user_id)} - init_handlers")

    users = GlchatLiveUtil.get_all_system_users()

    socket = assign(socket, users: users["data"])

    Process.send_after(self(), :live_user_update, 0)

    {:ok, socket}
  end

  def handle_info(:live_user_update, socket) do
    IO.inspect("GLCHAT::live_user_update - handl_info")
    users = Users.update_users_live_status(socket.assigns.users)
    socket = assign(socket, users: users)

    Process.send_after(self(), :live_user_update, @minutes * 1_000)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <%= live_component(RootLayout, app_prop: assigns, id: "root_layout") %>
    </div>
    """
  end

  def terminate(_reason, socket) do
    user_id = GlchatLiveViewHelper.get_assign(socket, :user_id)

    Task.start(fn ->
      Users.update_or_inserted_user_status(user_id, "offline")
    end)

    {:noreply, socket}
  end
end
