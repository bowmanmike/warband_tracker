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
        name: "some name"
      })
      |> WarbandTracker.Warbands.create_warband()

    warband
  end
end
