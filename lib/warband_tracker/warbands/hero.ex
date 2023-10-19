defmodule WarbandTracker.Warbands.Hero do
  use Ecto.Schema
  import Ecto.Changeset

  schema "heroes" do
    field :attacks, :integer
    field :ballistic_skill, :integer
    field :initiative, :integer
    field :leadership, :integer
    field :move, :integer
    field :name, :string
    field :strength, :integer
    field :toughness, :integer
    field :type, :string
    field :weapon_skill, :integer
    field :wounds, :integer
    field :special_rules, {:array, :string}, default: []
    field :weapons_and_armour_rules, :string
    field :is_leader, :boolean, default: false

    belongs_to :warband, WarbandTracker.Warbands.Warband

    timestamps()
  end

  @doc false
  def changeset(hero, attrs, warband) do
    attrs = Map.merge(attrs, %{"warband_id" => warband.id})

    hero
    |> cast(attrs, [
      :type,
      :name,
      :move,
      :weapon_skill,
      :ballistic_skill,
      :strength,
      :toughness,
      :wounds,
      :initiative,
      :attacks,
      :leadership,
      :special_rules,
      :weapons_and_armour_rules,
      :warband_id,
      :is_leader
    ])
    |> validate_required([
      :type,
      :name,
      :move,
      :weapon_skill,
      :ballistic_skill,
      :strength,
      :toughness,
      :wounds,
      :initiative,
      :attacks,
      :leadership,
      :special_rules,
      :weapons_and_armour_rules,
      :warband_id,
      :is_leader
    ])
    |> foreign_key_constraint(:warband, name: "heroes_warband_id_fkey")
  end
end
