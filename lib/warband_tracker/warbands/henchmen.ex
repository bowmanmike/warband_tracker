defmodule WarbandTracker.Warbands.Henchmen do
  use Ecto.Schema
  import Ecto.Changeset

  schema "henchmen" do
    field :type, :string
    field :name, :string
    field :number, :integer
    field :move, :integer
    field :weapon_skill, :integer
    field :ballistic_skill, :integer
    field :strength, :integer
    field :toughness, :integer
    field :wounds, :integer
    field :initiative, :integer
    field :attacks, :integer
    field :leadership, :integer
    field :special_rules, {:array, :string}, default: []
    field :weapons_and_armour_rules, :string
    field :group_experience, :integer, default: 0

    belongs_to :warband, WarbandTracker.Warbands.Warband

    timestamps()
  end

  @doc false
  def changeset(henchmen, attrs, warband) do
    attrs = Map.merge(attrs, %{"warband_id" => warband.id})

    henchmen
    |> cast(attrs, [
      :type,
      :name,
      :number,
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
      :group_experience,
      :warband_id
    ])
    |> validate_required([
      :type,
      :name,
      :number,
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
      :group_experience,
      :warband_id
    ])
    |> foreign_key_constraint(:warband, name: "henchmen_warband_id_fkey")
  end
end
