defmodule GlchatLive.Schema.LiveUser do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "live_users" do
    field :active_status, :string
    field :user_id, :integer, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(live_user, attrs) do
    live_user
    |> cast(attrs, [:user_id, :active_status])
    |> validate_required([:user_id, :active_status])
  end
end
