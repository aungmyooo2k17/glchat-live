defmodule GlchatLive.Helper.FilterHelper do
  import Ecto.Query, warn: false

  def filter_order_by(key, "desc") do
    key = String.to_atom(key)
    [desc: dynamic([n], field(n, ^key))]
  end

  def filter_order_by(key, "asc") do
    key = String.to_atom(key)
    [dynamic([n], field(n, ^key))]
  end

  def filter_order_by(_),
    do: []

  def filter_where("type", params) do
    conditions = true

    if !is_nil(params) do
      dynamic([n], n.type in ^params)
    else
      conditions
    end
  end

  def filter_where(params) do
    Enum.with_index(params["filterParams"])
    |> Enum.reduce(dynamic(true), fn
      {obj = %{"key" => _key}, index}, dynamic ->
        filter_process(obj["filterType"], obj, dynamic, params["filterLogic"], index)

      {_, _}, dynamic ->
        dynamic
    end)
  end

  defp filter_process("text", obj, dynamic, filterLogic, index) do
    key = String.to_atom(obj["key"])

    case filterLogic do
      "FILTER_LOGIC_AND" ->
        case index do
          0 -> dynamic([n], field(n, ^key) == ^obj["textValue"]["value"])
          _ -> dynamic([n], ^dynamic and field(n, ^key) == ^obj["textValue"]["value"])
        end

      "FILTER_LOGIC_OR" ->
        case index do
          0 -> dynamic([n], field(n, ^key) == ^obj["textValue"]["value"])
          _ -> dynamic([n], ^dynamic or field(n, ^key) == ^obj["textValue"]["value"])
        end
    end
  end

  defp filter_process("textArray", obj, dynamic, filterLogic, index) do
    key = String.to_atom(obj["key"])

    case filterLogic do
      "FILTER_LOGIC_AND" ->
        case index do
          0 -> dynamic([n], field(n, ^key) in ^obj["textArrayValue"]["list"])
          _ -> dynamic([n], ^dynamic and field(n, ^key) in ^obj["textArrayValue"]["list"])
        end

      "FILTER_LOGIC_OR" ->
        case index do
          0 -> dynamic([n], field(n, ^key) in ^obj["textArrayValue"]["list"])
          _ -> dynamic([n], ^dynamic or field(n, ^key) in ^obj["textArrayValue"]["list"])
        end
    end
  end

  defp filter_process("dateRange", obj, dynamic, filterLogic, index) do
    key = String.to_atom(obj["key"])

    case filterLogic do
      "FILTER_LOGIC_AND" ->
        case index do
          0 ->
            dynamic(
              [n],
              field(n, ^key) >= ^obj["dateRangeValue"]["start"] and
                field(n, ^key) <= ^obj["dateRangeValue"]["end"]
            )

          _ ->
            dynamic(
              [n],
              ^dynamic and field(n, ^key) >= ^obj["dateRangeValue"]["start"] and
                field(n, ^key) <= ^obj["dateRangeValue"]["end"]
            )
        end

      "FILTER_LOGIC_OR" ->
        case index do
          0 ->
            dynamic(
              [n],
              field(n, ^key) >= ^obj["dateRangeValue"]["start"] and
                field(n, ^key) <= ^obj["dateRangeValue"]["end"]
            )

          _ ->
            dynamic(
              [n],
              ^dynamic or
                (field(n, ^key) >= ^obj["dateRangeValue"]["start"] and
                   field(n, ^key) <= ^obj["dateRangeValue"]["end"])
            )
        end
    end
  end
end
