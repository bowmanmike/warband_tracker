defmodule WarbandTracker.Repo.Migrations.AddFieldsToWarbands do
  use Ecto.Migration

  def change do
    alter table("warbands") do
      add :type, :string
      add :gold_crowns, :integer, default: 0
      add :wyrdstone_shards, :integer, default: 0
      add :water_units, :integer, default: 0
      add :burden, :integer, default: 0
      add :burden_limit, :integer, default: 0
    end
  end
end
