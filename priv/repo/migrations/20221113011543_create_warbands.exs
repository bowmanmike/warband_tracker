defmodule WarbandTracker.Repo.Migrations.CreateWarbands do
  use Ecto.Migration

  def change do
    create table(:warbands) do
      add :name, :string, required: true
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:warbands, [:user_id])
  end
end
