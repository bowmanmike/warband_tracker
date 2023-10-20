defmodule WarbandTrackerWeb.WarbandLive.Henchmen.FormComponent do
  use WarbandTrackerWeb, :live_component

  alias WarbandTracker.Warbands
  alias WarbandTracker.Warbands.Henchmen

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header><%= @title %></.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="new-henchmen-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :name}} type="text" label="Name" />
        <.input field={{f, :type}} type="text" label="Type" />
        <.input field={{f, :number}} type="number" label="Number" />
        <.input field={{f, :move}} type="number" label="Movement" />
        <.input field={{f, :weapon_skill}} type="number" label="Weapon Skill" />
        <.input field={{f, :ballistic_skill}} type="number" label="Ballistic Skill" />
        <.input field={{f, :strength}} type="number" label="Strength" />
        <.input field={{f, :toughness}} type="number" label="Toughness" />
        <.input field={{f, :wounds}} type="number" label="Wounds" />
        <.input field={{f, :initiative}} type="number" label="Initiative" />
        <.input field={{f, :attacks}} type="number" label="Attacks" />
        <.input field={{f, :leadership}} type="number" label="Leadership" />
        <.input field={{f, :weapons_and_armour_rules}} type="text" label="Weapons and Armour" />

        <:actions>
          <.button phx-disable-with="Saving...">Save Henchmen</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    # changeset = %Henchmen{} |> Warbands.change_henchmen(attrs, warband)
    changeset = Warbands.change_henchmen(%Henchmen{}, assigns.warband)

    socket
    |> assign(assigns)
    |> assign(:changeset, changeset)
    |> ok()
  end

  @impl true
  def handle_event("validate", %{"henchmen" => henchmen_params}, socket) do
    changeset =
      %Henchmen{}
      |> Warbands.change_henchmen(henchmen_params, socket.assigns.warband)
      |> Map.put(:action, :validate)

    socket
    |> assign(:changeset, changeset)
    |> noreply()
  end

  def handle_event("save", %{"henchmen" => henchmen_params}, socket) do
    case Warbands.create_henchmen(socket.assigns.warband, henchmen_params) do
      {:ok, _henchmen} ->
        socket
        |> put_flash(:info, "Henchmen created successfully")
        |> push_navigate(to: socket.assigns.navigate)
        |> noreply()

      {:error, %Ecto.Changeset{} = changeset} ->
        socket
        |> put_flash(:error, "Something went wrong")
        |> assign(:changeset, changeset)
        |> noreply()
    end
  end

  def handle_event(event, params, socket) do
    IO.puts("handling event #{event} with values #{inspect(params)}")

    noreply(socket)
  end
end
