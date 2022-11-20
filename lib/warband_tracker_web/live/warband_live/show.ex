defmodule WarbandTrackerWeb.WarbandLive.Show do
  use WarbandTrackerWeb, :live_view

  alias WarbandTracker.Warbands

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    warband = Warbands.get_warband_for_user!(socket.assigns.current_user, id)

    socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:warband, warband)
    |> assign(:heroes, Warbands.get_heroes!(warband))
    |> noreply()
  end

  @impl true
  def handle_event("add-hero", _params, socket) do
    # TODO: put up the modal here
    noreply(socket)
  end

  defp page_title(:show), do: "Show Warband"
  defp page_title(:edit), do: "Edit Warband"
end
