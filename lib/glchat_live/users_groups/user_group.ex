defmodule GlchatLive.UsersGroups.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users_groups" do
    field :group_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(user_group, attrs) do
    user_group
    |> cast(attrs, [:user_id, :group_id])
    |> validate_required([:user_id, :group_id])
  end
end
