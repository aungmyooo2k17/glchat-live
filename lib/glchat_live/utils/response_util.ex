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
end
