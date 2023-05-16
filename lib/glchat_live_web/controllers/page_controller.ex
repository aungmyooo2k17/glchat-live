defmodule GlchatLiveWeb.PageController do
  use GlchatLiveWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
