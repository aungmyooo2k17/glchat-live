defmodule GlchatLive.Chats do
  @moduledoc """
  The Chats context.
  """

  import Ecto.Query, warn: false
  alias GlchatLive.Repo

  alias GlchatLive.Chats.Chat
  alias GlchatLive.Helper.FilterHelper

  @doc """
  Returns the list of chats.

  ## Examples

      iex> list_chats()
      [%Chat{}, ...]

  """
  def list_chats do
    Repo.all(Chat)
  end

  @doc """
  Gets a single chat.

  Raises `Ecto.NoResultsError` if the Chat does not exist.

  ## Examples

      iex> get_chat!(123)
      %Chat{}

      iex> get_chat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_chat!(id), do: Repo.get!(Chat, id)

  def get_chat_by_name(name),
    do: Repo.one(from c in Chat, where: c.name == ^name)

  @doc """
  Creates a chat.

  ## Examples

      iex> create_chat(%{field: value})
      {:ok, %Chat{}}

      iex> create_chat(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_chat(attrs \\ %{}) do
    %Chat{}
    |> Chat.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a chat.

  ## Examples

      iex> update_chat(chat, %{field: new_value})
      {:ok, %Chat{}}

      iex> update_chat(chat, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_chat(%Chat{} = chat, attrs) do
    chat
    |> Chat.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a chat.

  ## Examples

      iex> delete_chat(chat)
      {:ok, %Chat{}}

      iex> delete_chat(chat)
      {:error, %Ecto.Changeset{}}

  """
  def delete_chat(%Chat{} = chat) do
    Repo.delete(chat)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking chat changes.

  ## Examples

      iex> change_chat(chat)
      %Ecto.Changeset{data: %Chat{}}

  """
  def change_chat(%Chat{} = chat, attrs \\ %{}) do
    Chat.changeset(chat, attrs)
  end

  def filter_chats(filter, pagination, sorting_params) do
    offset_number = (pagination["pageNumber"] - 1) * pagination["pageSize"]

    query =
      Chat
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
        "id" => data.id,
        "name" => data.name,
        "inserted_at" => data.inserted_at,
        "updated_at" => data.updated_at
      }
    end)
  end
end
