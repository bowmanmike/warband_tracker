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
        <.input field={{f, :type}} type="text" label="type" />
        <.input field={{f, :gold_crowns}} type="text" label="gold_crowns" />
        <.input field={{f, :wyrdstone_shards}} type="text" label="wyrdstone_shards" />
        <.input field={{f, :water_units}} type="text" label="water_units" />
        <.input field={{f, :burden}} type="text" label="burden" />
        <.input field={{f, :burden_limit}} type="text" label="burden_limit" />
        <!-- # TODO: don't use a hidden field here, too easy to fake -->
        <.input field={{f, :user_id}} type="hidden" value={@user.id} />
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
    # params = Map.merge(warband_params, %{"user_id" => socket.assigns.user})
    # IO.inspect(params)
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
        socket
        |> put_flash(:info, "Warband created successfully")
        |> push_navigate(to: socket.assigns.navigate)
        |> noreply()

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
