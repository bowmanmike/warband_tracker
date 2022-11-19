defmodule WarbandTrackerWeb.WarbandLive.Index do
  use WarbandTrackerWeb, :live_view

  alias WarbandTracker.{Accounts, Warbands}
  alias WarbandTracker.Warbands.Warband

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(Map.get(session, "user_token"))
    assigns = %{warbands: list_warbands(), current_user: user}

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Warband")
    |> assign(:warband, Warbands.get_warband!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Warband")
    |> assign(:warband, %Warband{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Warbands")
    |> assign(:warband, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    warband = Warbands.get_warband!(id)
    {:ok, _} = Warbands.delete_warband(warband)

    {:noreply, assign(socket, :warbands, list_warbands())}
  end

  defp list_warbands do
    Warbands.list_warbands()
  end
end
