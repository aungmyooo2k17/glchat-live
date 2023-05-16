defmodule GlchatLiveWeb.MessageController do
  use GlchatLiveWeb, :controller

  alias Glchat.Messages

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

    response = %{
      pageNumber: page_number,
      pageSize: page_size,
      totalPages: 10,
      numberOfElements: 10,
      totalElements: 10,
      items: data
    }

    send_resp(conn, :ok, Jason.encode!(response))
  end
end
