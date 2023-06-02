defmodule GlchatLive.UsersChats do
  @moduledoc """
  The UsersChats context.
  """

  import Ecto.Query, warn: false
  alias GlchatLive.Chats.Chat
  alias GlchatLive.Repo
  alias GlchatLive.Helper.{FilterHelper, ApiCallHelper}

  alias GlchatLive.UsersChats.UserChat

  @doc """
  Returns the list of users_chatss.

  ## Examples

      iex> list_users_chatss()
      [%UserChat{}, ...]

  """
  def list_users_chatss do
    Repo.all(UserChat)
  end

  @doc """
  Gets a single user_chat.

  Raises `Ecto.NoResultsError` if the User chat does not exist.

  ## Examples

      iex> get_user_chat!(123)
      %UserChat{}

      iex> get_user_chat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_chat!(id), do: Repo.get!(UserChat, id)

  def get_user_chat_by_id(user_id, chat_id),
    do: Repo.one(from(uc in UserChat, where: uc.user_id == ^user_id and uc.chat_id == ^chat_id))

  @spec create_user_chat(
          :invalid
          | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  @doc """
  Creates a user_chat.

  ## Examples

      iex> create_user_chat(%{field: value})
      {:ok, %UserChat{}}

      iex> create_user_chat(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_chat(attrs \\ %{}) do
    %UserChat{}
    |> UserChat.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a user_chat.

  ## Examples

      iex> update_user_chat(user_chat, %{field: new_value})
      {:ok, %UserChat{}}

      iex> update_user_chat(user_chat, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_chat(%UserChat{} = user_chat, attrs) do
    user_chat
    |> UserChat.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_chat.

  ## Examples

      iex> delete_user_chat(user_chat)
      {:ok, %UserChat{}}

      iex> delete_user_chat(user_chat)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_chat(%UserChat{} = user_chat) do
    Repo.delete(user_chat)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_chat changes.

  ## Examples

      iex> change_user_chat(user_chat)
      %Ecto.Changeset{data: %UserChat{}}

  """
  def change_user_chat(%UserChat{} = user_chat, attrs \\ %{}) do
    UserChat.changeset(user_chat, attrs)
  end

  def filter_chats_users(current_user_id) do
    user_chat_subquery =
      from(uc2 in UserChat,
        where: uc2.user_id == ^current_user_id,
        select: uc2.chat_id
      )

    user_chat_query =
      from(uc in UserChat,
        where: uc.chat_id in subquery(user_chat_subquery) and uc.user_id != ^current_user_id,
        select: uc.chat_id,
        distinct: true
      )

    query =
      from(c in Chat,
        where: c.id in subquery(user_chat_query)
      )

    Repo.all(query)
    |> Enum.map(fn chat ->
      data = Map.from_struct(chat)

      %{
        id: data.id,
        name: data.name,
        inserted_at: data.inserted_at
      }
    end)
  end

  def filter_chats_users(filter, pagination, sorting_params) do
    offset_number = (pagination["pageNumber"] - 1) * pagination["pageSize"]

    query =
      UserChat
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

  def get_list_of_chat_user(current_user_id) do
    user_chat_subquery =
      from(uc2 in UserChat,
        where: uc2.user_id == ^current_user_id,
        select: uc2.chat_id
      )

    query =
      from(uc in UserChat,
        where: uc.chat_id in subquery(user_chat_subquery) and uc.user_id != ^current_user_id,
        select: uc.user_id,
        distinct: true
      )

    Repo.all(query)
  end


end
