defmodule GlchatLive.UsersChats.UserChat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users_chats" do
    field :chat_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(user_chat, attrs) do
    user_chat
    |> cast(attrs, [:user_id, :chat_id])
    |> validate_required([:user_id, :chat_id])
  end
end
