defmodule WarbandTrackerWeb.WarbandLive.Heroes.FormComponent do
  use WarbandTrackerWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>Add a Hero</.header>
    </div>
    """
  end

  def update(assigns, socket) do
    ok(socket)
  end
end
