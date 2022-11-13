defmodule WarbandTrackerWeb.WarbandLive.Show do
  use WarbandTrackerWeb, :live_view

  alias WarbandTracker.Warbands

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:warband, Warbands.get_warband!(id))}
  end

  defp page_title(:show), do: "Show Warband"
  defp page_title(:edit), do: "Edit Warband"
end
