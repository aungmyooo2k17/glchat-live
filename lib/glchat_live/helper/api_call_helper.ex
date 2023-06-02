defmodule GlchatLive.Helper.ApiCallHelper do
  require Logger

  @doc """
  Builds the payload for the API call.
  %{
    "paginationParam" => %{
      "pageNumber" => page_no,
      "pageSize" => page_size
    },
    "sortingParams" => %{
      "key" => order_by_item,
      "sortType" => order_by_value
    },
    "filter" => %{
      "filterParams" => [
        %{
          "key" => query_item,
          "filterType" => item_type,
          "textValue" => %{
            "value" => item_value
          }
        }
      ],
      "filterLogic" => filter_logic
    }
  }
  """
  def payload_builder(
        filter,
        filter_logic,
        order_by_item,
        order_by_value,
        page_no,
        page_size
      ) do
    %{
      "paginationParam" => %{
        "pageNumber" => page_no,
        "pageSize" => page_size
      },
      "sortingParams" => %{
        "key" => order_by_item,
        "sortType" => order_by_value
      },
      "filter" => %{
        "filterParams" => [],
        "filterLogic" => filter_logic
      }
    }
  end

  def do_post(url, payload) do
    payload = Jason.encode!(payload)

    headers = [
      {
        "content-type",
        "application/json"
      }
    ]

    case HTTPoison.post(url, payload, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, Logger.warn("Not found :(")}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, Logger.error(reason)}
    end
  end

  def do_get(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.warn("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error(reason)
    end
  end
end
