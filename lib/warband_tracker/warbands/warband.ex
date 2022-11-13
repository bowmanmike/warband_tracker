defmodule WarbandTracker.Warbands.Warband do
  use Ecto.Schema
  import Ecto.Changeset

  schema "warbands" do
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(warband, attrs) do
    warband
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
