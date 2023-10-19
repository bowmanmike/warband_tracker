defmodule WarbandTrackerWeb.WarbandLive.Show do
  use WarbandTrackerWeb, :live_view

  alias WarbandTracker.Warbands
  alias Phoenix.LiveView.JS

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    warband = Warbands.get_warband_for_user!(socket.assigns.current_user, id)

    %{
      heroes: heroes,
      henchmen: henchmen
    } = Warbands.members(warband)

    socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:warband, warband)
    |> assign(:henchmen, henchmen)
    |> assign(:heroes, heroes)
    |> noreply()
  end

  # @impl true
  # def handle_event("add-hero", _params, socket) do
  #   # TODO: put up the modal here
  #   noreply(socket)
  # end

  # def show_hero_form(js \\ %JS{}) do
  #   js
  #   |> JS.show(to: "#new-hero-form")
  # end

  defp page_title(:show), do: "Show Warband"
  defp page_title(:edit), do: "Edit Warband"
  defp page_title(:add_hero), do: "Add A Hero"
end
