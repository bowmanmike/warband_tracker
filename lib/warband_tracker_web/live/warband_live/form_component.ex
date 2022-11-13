defmodule WarbandTrackerWeb.WarbandLive.FormComponent do
  use WarbandTrackerWeb, :live_component

  alias WarbandTracker.Warbands

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage warband records in your database.</:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="warband-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :name}} type="text" label="name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Warband</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{warband: warband} = assigns, socket) do
    changeset = Warbands.change_warband(warband)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"warband" => warband_params}, socket) do
    changeset =
      socket.assigns.warband
      |> Warbands.change_warband(warband_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"warband" => warband_params}, socket) do
    save_warband(socket, socket.assigns.action, warband_params)
  end

  defp save_warband(socket, :edit, warband_params) do
    case Warbands.update_warband(socket.assigns.warband, warband_params) do
      {:ok, _warband} ->
        {:noreply,
         socket
         |> put_flash(:info, "Warband updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_warband(socket, :new, warband_params) do
    case Warbands.create_warband(warband_params) do
      {:ok, _warband} ->
        {:noreply,
         socket
         |> put_flash(:info, "Warband created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
