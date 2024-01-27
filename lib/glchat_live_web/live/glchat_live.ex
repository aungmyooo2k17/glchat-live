defmodule GlchatLiveWeb.GlChatLive do
  @moduledoc false
  use Surface.LiveView
  require Logger

  alias GlchatLive.Helper.GlchatLiveViewHelper
  alias GlchatLiveWeb.Layouts.RootLayout
  alias GlchatLive.{Users, Messages, Chats}
  alias GlchatLiveWeb.Utils.GlchatLiveUtil

  @minutes 1

  def mount(%{"user_id" => user_id} = _assigns, _session, socket) do
    socket =
      assign(socket,
        user_id: user_id |> String.to_integer(),
        users: [],
        messages: [],
        current_selected_user: nil,
        chatting_message_txt: nil
      )

    Logger.info("USER_ID::#{user_id} - " <> "Mount started")

    GlchatLiveWeb.Endpoint.subscribe("message_poller")

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

  def handle_info(
        %Phoenix.Socket.Broadcast{
          event: "update_message",
          payload: %{"payload" => messages, "receiver_id" => user_id, "sender_id" => sender_id},
          topic: "message_poller"
        },
        socket
      ) do
    IO.inspect({user_id, socket.assigns.user_id})

    if user_id == socket.assigns.user_id and sender_id == socket.assigns.current_selected_user do
      {:noreply, assign(socket, messages: messages)}
    else
      {:noreply, socket}
    end
  end

  def handle_info(:live_user_update, socket) do
    users = Users.update_users_live_status(socket.assigns.users)
    # remove current user from users list
    users =
      users
      |> Enum.filter(fn user -> user["id"] != socket.assigns.user_id end)

    socket = assign(socket, users: users)

    Process.send_after(self(), :live_user_update, @minutes * 60_000)
    {:noreply, socket}
  end

  def handle_event("select_chat_user", %{"selected_user_id" => selected_user_id}, socket) do
    socket = assign(socket, current_selected_user: selected_user_id |> String.to_integer())

    chat_name =
      [socket.assigns.user_id, socket.assigns.current_selected_user]
      |> Enum.sort()
      |> Enum.join("-")

    chat_data =
      Chats.filter_chats(
        %{
          "filterParams" => [
            %{
              "key" => "name",
              "filterType" => "text",
              "textValue" => %{
                "value" => chat_name
              }
            }
          ],
          "filterLogic" => "FILTER_LOGIC_AND"
        },
        %{"pageNumber" => 1, "pageSize" => 100},
        %{"key" => "inserted_at", "sortType" => "desc"}
      )
      |> List.last()

    data =
      if chat_data != nil do
        Messages.filter_messages(
          %{
            "filterParams" => [
              %{
                "key" => "chat_id",
                "filterType" => "text",
                "textValue" => %{"value" => chat_data["id"]}
              }
            ],
            "filterLogic" => "FILTER_LOGIC_AND"
          },
          %{"pageNumber" => 1, "pageSize" => 100},
          %{"key" => "send_at", "sortType" => "desc"}
        )
      else
        []
      end

    {:noreply, assign(socket, messages: data)}
  end

  def handle_event("form_submitted", %{"chatting_message" => chatting_message, "_target" => _chatting_message_file}, socket) do
    {:noreply, assign(socket, chatting_message_txt: chatting_message)}
  end

  def handle_event("send_message", %{"chatting_message" => message, "_target" => chatting_message_file}, socket) do
    Logger.info("USER_ID::#{inspect(socket.assigns.user_id)} send message - #{message}")
    IO.inspect(chatting_message_file)

    chat_name =
      [socket.assigns.user_id, socket.assigns.current_selected_user]
      |> Enum.sort()
      |> Enum.join("-")

    sent_message = Messages.send_message(chat_name, socket.assigns.user_id, "Text", message)

    # append message to messages list
    messages =
      %{
        "content" => message,
        "id" => sent_message.id,
        "user_id" => socket.assigns.user_id
      }
      |> List.wrap()
      |> Enum.concat(socket.assigns.messages)

    GlchatLiveWeb.Endpoint.broadcast!(
      "message_poller",
      "update_message",
      %{
        "payload" => messages,
        "receiver_id" => socket.assigns.current_selected_user,
        "sender_id" => socket.assigns.user_id
      }
    )

    IO.inspect("********")

    {:noreply,
     assign(
       socket,
       messages: messages,
       chatting_message_txt: ""
     )}
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
