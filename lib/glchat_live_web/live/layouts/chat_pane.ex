defmodule GlchatLiveWeb.Layouts.ChatPane do
  @doc false
  use Surface.LiveComponent

  alias GlchatLiveWeb.Components.{ChatListItem, SendMessageItem, EmptyChatScreen}

  prop(messages, :list, default: [])
  prop(current_user_id, :integer, default: "")

  def render(assigns) do
    ~H"""
      <div class="col-1">
        <div class="content-wrapper">

        <%= for message <- @messages do %>
          <.live_component module={ChatListItem} message={message} current_user_id={@current_user_id} id={message["id"]}></.live_component>
        <% end %>
        </div>
        <%= if length(@messages) != 0 do %>
          <.live_component module={SendMessageItem} id="SendMessageItem"></.live_component>
        <% else %>
          <.live_component module={EmptyChatScreen} id="SendMessageItem"></.live_component>
        <% end %>
      </div>
    """
  end
end
