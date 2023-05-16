defmodule GlchatLive.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field(:chat_id, :integer)
    field(:content, :string)
    field(:delivered_at, :naive_datetime)
    field(:group_id, :integer)
    field(:seen_at, :naive_datetime)
    field(:send_at, :naive_datetime)
    field(:type, :string)
    field(:user_id, :integer)

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [
      :user_id,
      :group_id,
      :chat_id,
      :type,
      :content,
      :send_at,
      :delivered_at,
      :seen_at
    ])
    |> validate_required([:user_id, :type, :content, :send_at])
  end
end
