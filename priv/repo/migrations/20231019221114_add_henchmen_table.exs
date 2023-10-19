defmodule WarbandTracker.Repo.Migrations.AddHenchmenTable do
  use Ecto.Migration

  def change do
    create table(:henchmen) do
      add :type, :string, null: false
      add :name, :string, null: false
      add :number, :integer, null: false
      add :move, :integer, null: false
      add :weapon_skill, :integer, null: false
      add :ballistic_skill, :integer, null: false
      add :strength, :integer, null: false
      add :toughness, :integer, null: false
      add :wounds, :integer, null: false
      add :initiative, :integer, null: false
      add :attacks, :integer, null: false
      add :leadership, :integer, null: false
      add :special_rules, {:array, :string}, default: [], null: false
      add :weapons_and_armour_rules, :string, null: false
      add :warband_id, references(:warbands, on_delete: :delete_all)
      add :group_experience, :integer, null: false, default: 0

      timestamps()
    end
  end
end
