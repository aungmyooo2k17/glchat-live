defmodule GlchatLiveWeb.Layouts.ChatPane do
  @doc false
  use Surface.LiveComponent

  alias GlchatLiveWeb.Components.{ChatListItem, SendMessageItem}

  def render(assigns) do
    ~H"""
      <div class="col-1">
        <div class="content-wrapper">
          <.live_component module={ChatListItem} id="hello"></.live_component>
          <.live_component module={ChatListItem} id="hello2"></.live_component>
          <.live_component module={ChatListItem} id="hello3"></.live_component>
          <.live_component module={ChatListItem} id="hello4"></.live_component>
          <.live_component module={ChatListItem} id="hello5"></.live_component>
          <.live_component module={ChatListItem} id="hello6"></.live_component>
          <.live_component module={ChatListItem} id="hello7"></.live_component>
          <.live_component module={ChatListItem} id="hello8"></.live_component>
          <.live_component module={ChatListItem} id="hello9"></.live_component>
          <.live_component module={ChatListItem} id="hello11"></.live_component>
          <.live_component module={ChatListItem} id="hello22"></.live_component>
          <.live_component module={ChatListItem} id="hello33"></.live_component>
          <.live_component module={ChatListItem} id="hello44"></.live_component>
          <.live_component module={ChatListItem} id="hello55"></.live_component>
          <.live_component module={ChatListItem} id="hello66"></.live_component>
          <.live_component module={ChatListItem} id="hello77"></.live_component>
          <.live_component module={ChatListItem} id="hello88"></.live_component>
          <.live_component module={ChatListItem} id="hello99"></.live_component>
          <.live_component module={ChatListItem} id="hello111"></.live_component>
          <.live_component module={ChatListItem} id="hello222"></.live_component>
        </div>
        <.live_component module={SendMessageItem} id="hello333"></.live_component>
      </div>
    """
  end
end
