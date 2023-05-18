# defmodule GlchatLiveWeb.AuthPlug do
#   import Plug.Conn
#   require OK

#   alias ControlCenterWeb.AuthUtil

#   def init(options), do: options

#   def call(conn, _opts) do
#     [authorization | _tail] = get_req_header(conn, "authorization")
#     jwt_token = authorization |> String.replace("Bearer", "") |> String.trim()

#     case AuthUtil.check_token_with_api(jwt_token) do
#       {:ok, _} ->
#         case decode(jwt_token) do
#           {:ok, {user_name, exp, authorities}} ->
#             if(not (exp > DateTime.utc_now() |> DateTime.to_unix(:second))) do
#               conn
#               |> Plug.Conn.resp(401, "")
#               |> Plug.Conn.send_resp()
#               |> halt()
#             end

#             conn
#             |> assign(:jwt_token, jwt_token)
#             |> assign(:user_name, user_name)
#             |> assign(:authorities, authorities)

#           {:err, _err} ->
#             conn
#             |> Plug.Conn.resp(401, "")
#             |> Plug.Conn.send_resp()
#             |> halt()
#         end

#       {:error, _} ->
#         conn
#         # # 408 status code is needed for the client to identify that the token is of an old session
#         |> Plug.Conn.resp(408, "")
#         |> Plug.Conn.send_resp()
#         |> halt()
#     end
#   end

#   def decode(token) do
#     jwk = JOSE.JWK.from_pem(Application.get_env(:control_center, :pem))

#     {condition, data} = match(JOSE.JWT.verify_strict(jwk, ["RS256"], token))

#     case condition do
#       :ok ->
#         {:ok, data}

#       :err ->
#         {:err, "Invalid Token"}
#     end
#   end

#   defp match(
#          {true,
#           %{
#             fields:
#               _fields = %{"user_name" => user_name, "exp" => exp, "authorities" => authorities}
#           }, _a}
#        ) do
#     {:ok, {user_name, exp, authorities}}
#   end

#   defp match({:error, _b}) do
#     {:err, "Invalide Token"}
#   end
# end
