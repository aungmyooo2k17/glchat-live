defmodule GlchatLive.Helper.ApiCallHelper do
  def payload_builder(
        query_item,
        item_type,
        item_value,
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
        IO.puts(body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def do_get(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts(body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
