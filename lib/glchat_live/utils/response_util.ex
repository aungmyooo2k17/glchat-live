defmodule GlchatLive.Utils.ResponseUtil do
  def error_message_response(message) do
    %{
      error: %{
        message: message
      }
    }
  end

  def data_message_response(data) do
    %{
      data: %{
        message: data
      }
    }
  end

  def data_with_pagination_response(
        pageNumber,
        pageSize,
        totalPages,
        numberOfElements,
        totalElements,
        data
      ) do
    %{
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalPages: totalPages,
      numberOfElements: numberOfElements,
      totalElements: totalElements,
      data: data
    }
  end
end
