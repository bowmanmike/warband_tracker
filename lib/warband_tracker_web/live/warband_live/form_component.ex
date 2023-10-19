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
        <.input field={{f, :name}} type="text" label="Name" />
        <.input field={{f, :type}} type="text" label="Type" />
        <.input field={{f, :gold_crowns}} type="text" label="Gold Crowns" />
        <.input field={{f, :wyrdstone_shards}} type="text" label="Wyrdstone_Shards" />
        <.input field={{f, :water_units}} type="text" label="Water Units" />
        <.input field={{f, :burden}} type="text" label="Burden" />
        <.input field={{f, :burden_limit}} type="text" label="Burden Limit" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Warband</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{warband: warband} = assigns, socket) do
    changeset = warband |> Map.put(:user, assigns.user) |> Warbands.change_warband()

    socket
    |> assign(assigns)
    |> assign(:changeset, changeset)
    |> ok()
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
    params = Map.merge(warband_params, %{"user_id" => socket.assigns.user.id})

    save_warband(socket, socket.assigns.action, params)
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
        socket
        |> put_flash(:info, "Warband created successfully")
        |> push_navigate(to: socket.assigns.navigate)
        |> noreply()

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
