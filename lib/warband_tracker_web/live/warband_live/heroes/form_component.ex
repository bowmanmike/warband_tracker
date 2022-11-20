defmodule WarbandTrackerWeb.WarbandLive.Heroes.FormComponent do
  use WarbandTrackerWeb, :live_component

  alias WarbandTracker.Warbands
  alias WarbandTracker.Warbands.Hero

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header><%= @title %></.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="new-hero-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :name}} type="text" label="Name" />
        <.input field={{f, :type}} type="text" label="Type" />
        <.input field={{f, :is_leader}} type="checkbox" label="Is Leader?" />
        <.input field={{f, :move}} type="number" label="Movement" />
        <.input field={{f, :weapon_skill}} type="number" label="Weapon Skill" />
        <.input field={{f, :ballistic_skill}} type="number" label="Ballistic Skill" />
        <.input field={{f, :strength}} type="number" label="Strength" />
        <.input field={{f, :toughness}} type="number" label="Toughness" />
        <.input field={{f, :wounds}} type="number" label="Wounds" />
        <.input field={{f, :initiative}} type="number" label="Initiative" />
        <.input field={{f, :attacks}} type="number" label="Attacks" />
        <.input field={{f, :leadership}} type="number" label="Leadership" />
        <.input field={{f, :special_rules}} type="text" label="Special Rules" />
        <.input field={{f, :weapons_and_armour_rules}} type="text" label="Weapons and Armour" />

        <:actions>
          <.button phx-disable-with="Saving...">Save Hero</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    # changeset = %Hero{} |> Warbands.change_hero(attrs, warband)
    changeset = Warbands.change_hero(%Hero{}, assigns.warband)

    socket
    |> assign(assigns)
    |> assign(:changeset, changeset)
    |> ok()
  end

  @impl true
  def handle_event("validate", %{"hero" => hero_params}, socket) do
    changeset =
      %Hero{}
      |> Warbands.change_hero(hero_params, socket.assigns.warband)
      |> Map.put(:action, :validate)

    socket
    |> assign(:changeset, changeset)
    |> noreply()
  end

  def handle_event(event, params, socket) do
    IO.puts("handling event #{event} with values #{inspect(params)}")

    noreply(socket)
  end
end
