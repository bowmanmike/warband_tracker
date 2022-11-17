defmodule WarbandTracker.WarbandsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WarbandTracker.Warbands` context.
  """

  @doc """
  Generate a warband.
  """
  def warband_fixture(attrs \\ %{}) do
    {:ok, warband} =
      attrs
      |> Enum.into(%{
        name: "some name",
        user_id: :rand.uniform(500)
      })
      # This is failing because I've told ecto that the user < -- > warband
      # is a foreign key, so it needs to point to a valid user
      # Should just swap this out for ex_machina and get it working the right way
      |> WarbandTracker.Warbands.create_warband()

    warband
  end
end
