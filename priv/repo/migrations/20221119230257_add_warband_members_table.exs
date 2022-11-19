defmodule WarbandTracker.Repo.Migrations.AddWarbandMembersTable do
  use Ecto.Migration

  def change do
    create_table(:warband_members, primary_key: false) do
      add(:warband_id, references(:warbands))
      # add(:member)
    end
  end
end
