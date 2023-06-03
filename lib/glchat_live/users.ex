defmodule GlchatLive.Users do
  alias GlchatLive.Repo
  alias GlchatLive.Schema.LiveUser
  alias GlchatLive.Helper.ApiCallHelper
  alias GlchatLive.Models.LiveUsers

  def update_or_inserted_user_status(user_id, status) do

    result =
      case Repo.get_by(LiveUser, user_id: user_id) do
        # LiveUser not found, we build one
        nil -> %LiveUser{user_id: user_id, active_status: status}
        # LiveUser exists, let's use it
        live_user -> live_user
      end
      |> LiveUser.changeset(%{
        user_id: user_id,
        active_status: status,
        updated_at: DateTime.utc_now()
      })
      |> Repo.insert_or_update()

    case result do
      {:ok, struct} -> :ok
      {:error, changeset} -> :error
    end
  end

  def get_all_users() do
    url = Application.get_env(:glchat_live, :auth_api) <> "/api/users"

    payload =
      ApiCallHelper.payload_builder(
        [],
        "FILTER_LOGIC_AND",
        "inserted_at",
        "desc",
        1,
        100
      )

    ApiCallHelper.do_post(url, payload)
  end

  def update_users_live_status(users) do
    live_users = LiveUsers.get_all_live_user()

    Enum.map(users, fn user ->
      live_user =
        Enum.find(live_users, fn live_user ->
          live_user.user_id == user["id"]
        end)

      Map.put(user, "live_status", live_user.active_status)
    end)
  end
end
