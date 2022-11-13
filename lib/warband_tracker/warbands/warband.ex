defmodule WarbandTracker.Warbands.Warband do
  use Ecto.Schema
  import Ecto.Changeset

  schema "warbands" do
    field :name, :string
    # field :user_id, :id
    field :type, :string
    field :gold_crowns, :integer, default: 0
    field :wyrdstone_shards, :integer, default: 0
    field :water_units, :integer, default: 0
    field :burden, :integer, default: 0
    field :burden_limit, :integer, default: 0

    belongs_to :user, WarbandTracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(warband, attrs) do
    IO.inspect(attrs, label: :schema)

    warband
    |> cast(attrs, [
      :name,
      :type,
      :gold_crowns,
      :wyrdstone_shards,
      :water_units,
      :burden,
      :burden_limit,
      :user_id
    ])
    # |> put_assoc(:user, attrs[:user])
    |> validate_required([:name, :user_id])
  end
end
