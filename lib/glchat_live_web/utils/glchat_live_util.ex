defmodule GlchatLiveWeb.Utils.GlchatLiveUtil do
  alias GlchatLive.Users

  def get_all_system_users() do
    #######################
    # GET ALL USER        #
    #######################
    {:ok, users} = Users.get_all_users()
    # add user status to all users in user["data"]

    Map.update!(users, "data", fn users ->
      Enum.map(users, fn user ->
        Map.put(user, "live_status", "online")
      end)
    end)
  end
end
