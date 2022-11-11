defmodule WarbandTrackerWeb.Components.CollapsibleSection do
  use WarbandTrackerWeb, :live_component
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  attr :title, :string, required: true
  attr :collapsed, :boolean, default: true
  slot :content, required: true

  def collapsible_section(assigns) do
    ~H"""
    <section class="mb-4 rounded-md shadow-md m-2 p-2">
      <div class="flex gap-4" phx-click={toggle_visible(@id)}>
        <button class="flex items-center gap-2">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 20 20"
            fill="currentColor"
            class="w-5 h-5"
            id={"closed-icon-#{dom_id(@id)}"}
          >
            <path
              fill-rule="evenodd"
              d="M10 18a8 8 0 100-16 8 8 0 000 16zM6.75 9.25a.75.75 0 000 1.5h4.59l-2.1 1.95a.75.75 0 001.02 1.1l3.5-3.25a.75.75 0 000-1.1l-3.5-3.25a.75.75 0 10-1.02 1.1l2.1 1.95H6.75z"
              clip-rule="evenodd"
            />
          </svg>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 20 20"
            fill="currentColor"
            class="w-5 h-5"
            id={"open-icon-#{dom_id(@id)}"}
          >
            <path
              fill-rule="evenodd"
              d="M10 18a8 8 0 100-16 8 8 0 000 16zm.75-11.25a.75.75 0 00-1.5 0v4.59L7.3 9.24a.75.75 0 00-1.1 1.02l3.25 3.5a.75.75 0 001.1 0l3.25-3.5a.75.75 0 10-1.1-1.02l-1.95 2.1V6.75z"
              clip-rule="evenodd"
            />
          </svg>
          <h3 class="font-semibold text-xl text-center"><%= @title %></h3>
        </button>
      </div>
      <div id={dom_id(@id)} phx-mounted={@collapsed && hide_section(@id)}>
        <%= render_slot(@content) %>
      </div>
    </section>
    """
  end

  def toggle_visible(js \\ %JS{}, id) do
    js
    |> JS.toggle(to: dom_selector(id))
    |> JS.toggle(to: "#open-icon-#{dom_id(id)}")
    |> JS.toggle(to: "#closed-icon-#{dom_id(id)}")
  end

  def show_section(js \\ %JS{}, id) do
    js
    |> JS.show(to: dom_selector(id))
    |> JS.hide(to: "#closed-icon-#{dom_id(id)}")
    |> JS.show(to: "#open-icon-#{dom_id(id)}")
  end

  def hide_section(js \\ %JS{}, id) do
    js
    |> JS.hide(to: dom_selector(id))
    |> JS.show(to: "#closed-icon-#{dom_id(id)}")
    |> JS.hide(to: "#open-icon-#{dom_id(id)}")
  end

  defp dom_id(id), do: "collapsible-#{id}"
  defp dom_selector(id), do: "##{dom_id(id)}"
end
