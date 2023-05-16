defmodule GlchatLive.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias GlchatLive.Repo

  alias GlchatLive.Messages.Message
  alias GlchatLive.Helper.FilterHelper

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list_messages()
      [%Message{}, ...]

  """
  def list_messages do
    Repo.all(Message)
  end

  @doc """
  Gets a single message.

  Raises `Ecto.NoResultsError` if the Message does not exist.

  ## Examples

      iex> get_message!(123)
      %Message{}

      iex> get_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_message!(id), do: Repo.get!(Message, id)

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a message.

  ## Examples

      iex> delete_message(message)
      {:ok, %Message{}}

      iex> delete_message(message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Ecto.Changeset{data: %Message{}}

  """
  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end

  def filter_messages(filter, pagination, sorting_params) do
    offset_number = (pagination["pageNumber"] - 1) * pagination["pageSize"]

    query =
      Message
      |> limit(^pagination["pageSize"])
      |> offset(^offset_number)
      |> order_by(
        ^FilterHelper.filter_order_by(sorting_params["key"], sorting_params["sortType"])
      )
      |> where(^FilterHelper.filter_where(filter))

    Repo.all(query)
    |> Enum.map(fn chat ->
      data = Map.from_struct(chat)

      %{
        "chat_id" => data.chat_id,
        "content" => data.content,
        "delivered_at" => data.delivered_at,
        "group_id" => data.group_id,
        "seen_at" => data.seen_at,
        "send_at" => data.send_at,
        "type" => data.type,
        "user_id" => data.user_id
      }
    end)
  end
end
