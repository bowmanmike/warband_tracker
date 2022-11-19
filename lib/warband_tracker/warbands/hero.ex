defmodule WarbandTracker.Warbands.Hero do
  use Ecto.Schema
  import Ecto.Changeset

  schema "heroes" do
    field :attacks, :integer
    field :bow_skill, :integer
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

    timestamps()
  end

  @doc false
  def changeset(hero, attrs) do
    hero
    |> cast(attrs, [
      :type,
      :name,
      :move,
      :weapon_skill,
      :bow_skill,
      :strength,
      :toughness,
      :wounds,
      :initiative,
      :attacks,
      :leadership,
      :special_rules,
      :weapons_and_armour_rules
    ])
    |> validate_required([
      :type,
      :name,
      :move,
      :weapon_skill,
      :bow_skill,
      :strength,
      :toughness,
      :wounds,
      :initiative,
      :attacks,
      :leadership,
      :special_rules,
      :weapons_and_armour_rules
    ])
  end
end
