defmodule WarbandTracker.Factory do
  @moduledoc """
  A collection of functions to be used to create test data and associations
  through functions provided by the ex_machina dependency

  source: https://github.com/thoughtbot/ex_machina
  """

  use ExMachina.Ecto, repo: WarbandTracker.Repo

  use WarbandTracker.Factories.{
    User,
    Warband
  }
end
