defmodule WarbandTrackerWeb.Components.CollapsibleSection do
  use WarbandTrackerWeb, :live_component

  attr :title, :string, required: true
  attr :collapsed, :boolean, default: true
  slot :content, required: true

  @impl true
  def render(assigns) do
    ~H"""
    <section class="mb-4 rounded-md shadow-md m-2 p-2">
      <div class="flex gap-4" phx-click="toggle_open" phx-target={@myself}>
        <button class="flex items-center gap-2">
          <%= if @collapsed do %>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 20 20"
              fill="currentColor"
              class="w-5 h-5"
            >
              <path
                fill-rule="evenodd"
                d="M10 18a8 8 0 100-16 8 8 0 000 16zM6.75 9.25a.75.75 0 000 1.5h4.59l-2.1 1.95a.75.75 0 001.02 1.1l3.5-3.25a.75.75 0 000-1.1l-3.5-3.25a.75.75 0 10-1.02 1.1l2.1 1.95H6.75z"
                clip-rule="evenodd"
              />
            </svg>
          <% else %>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 20 20"
              fill="currentColor"
              class="w-5 h-5"
            >
              <path
                fill-rule="evenodd"
                d="M10 18a8 8 0 100-16 8 8 0 000 16zm.75-11.25a.75.75 0 00-1.5 0v4.59L7.3 9.24a.75.75 0 00-1.1 1.02l3.25 3.5a.75.75 0 001.1 0l3.25-3.5a.75.75 0 10-1.1-1.02l-1.95 2.1V6.75z"
                clip-rule="evenodd"
              />
            </svg>
          <% end %>
          <h3 class="font-semibold text-xl text-center"><%= @title %></h3>
        </button>
      </div>
      <div :if={@collapsed == false}>
        <%= render_slot(@content) %>
      </div>
    </section>
    """
  end

  @impl true
  def handle_event("toggle_open", _assigns, socket) do
    {:noreply, assign(socket, :collapsed, !socket.assigns.collapsed)}
  end
end
