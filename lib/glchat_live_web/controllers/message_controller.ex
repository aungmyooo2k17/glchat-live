defmodule GlchatLiveWeb.MessageController do
  use GlchatLiveWeb, :controller

  alias GlchatLive.{Messages, Chats, UsersChats}
  alias GlchatLive.Utils.ResponseUtil

  def get(conn, params) do
    %{
      "filter" => filter = %{"filterParams" => _filter_params, "filterLogic" => _filter_logic},
      "paginationParam" => pagination = %{"pageNumber" => page_number, "pageSize" => page_size},
      "sortingParams" => sorting_params
    } = params

    data =
      Messages.filter_messages(
        filter,
        pagination,
        sorting_params
      )

    response = ResponseUtil.data_with_pagination_response(page_number, page_size, 10, 10, 10, data)

    send_resp(conn, :ok, Poison.encode!(response))
  end

  def send(conn, params) do
    %{
      "users" => users,
      "sender_id" => sender_id,
      "type" => type,
      "content" => content
    } = params

    chat_name = Poison.encode!(users)

    Task.async(fn -> Messages.send_message(chat_name, sender_id, type, content) end)

    conn
    |> put_status(:ok)
    |> json(ResponseUtil.data_message_response("Message sent successfully."))
  end
end
