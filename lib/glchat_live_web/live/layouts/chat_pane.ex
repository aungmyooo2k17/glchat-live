defmodule GlchatLiveWeb.Layouts.ChatPane do
  @doc false
  use Surface.LiveComponent

  alias GlchatLiveWeb.Components.{ChatListItem, SendMessageItem, EmptyChatScreen}

  prop(messages, :list, default: [])
  prop(current_user_id, :integer, default: "")
  prop(current_selected_user, :integer, default: nil)
  prop(chatting_message_txt, :string)

  def render(assigns) do
    ~H"""
      <div class="col-1">
        <div class="content-wrapper mb-auto">
          <%= for message <- @messages do %>
            <.live_component module={ChatListItem} message={message} current_user_id={@current_user_id} id={message["id"]}></.live_component>
          <% end %>
          <%= if length(@messages) == 0 do %>
            <.live_component module={EmptyChatScreen} id="EmptyChatScreen"></.live_component>
          <% end %>
        </div>
          <%= if not is_nil(@current_selected_user) do %>
            <.live_component
              module={SendMessageItem}
              chatting_message_txt={@chatting_message_txt}
              id="SendMessageItem">
            </.live_component>
          <% end %>
      </div>
    """
  end
end
