defmodule GlchatLiveWeb.Components.SendMessageItem do
  @moduledoc false
  use Surface.LiveComponent

  prop(chatting_message_txt, :string)

  def render(assigns) do
    ~H"""
    <form class="form" form="send_message" phx-submit="send_message" phx-change="form_submitted">
      <div class="flex items-center border border-gray-300 rounded-lg p-2">
        <input type="text" placeholder="Type your message" class="flex-grow px-3 py-2 bg-transparent focus:outline-none" name="chatting_message" value={@chatting_message_txt}/>
        <label for="file-input" class="flex items-center cursor-pointer ml-2">
          <span class="ml-1 text-sm text-gray-600">Attach file</span>
          <input id="file-input" type="file" class="hidden" name="chatting_message_file"/>
        </label>
        <input value="Send" type="submit" class="ml-2 bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded focus:outline-none"/>
      </div>
    </form>
    """
  end
end
