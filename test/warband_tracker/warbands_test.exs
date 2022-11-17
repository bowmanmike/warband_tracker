defmodule WarbandTracker.WarbandsTest do
  use WarbandTracker.DataCase

  alias WarbandTracker.Warbands

  setup do
    user = insert(:user)

    %{user: user}
  end

  describe "warbands" do
    alias WarbandTracker.Warbands.Warband

    import WarbandTracker.WarbandsFixtures

    @invalid_attrs %{name: nil, user_id: nil}

    test "list_warbands/0 returns all warbands", %{user: user} do
      warband = warband_fixture(%{user_id: user.id})
      assert Warbands.list_warbands() == [warband]
    end

    test "get_warband!/1 returns the warband with given id", %{user: user} do
      warband = warband_fixture(%{user_id: user.id})
      assert Warbands.get_warband!(warband.id) == warband
    end

    test "create_warband/1 with valid data creates a warband", %{user: user} do
      valid_attrs = %{name: "some name", user_id: user.id}

      assert {:ok, %Warband{} = warband} = Warbands.create_warband(valid_attrs)
      assert warband.name == "some name"
    end

    test "create_warband/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warbands.create_warband(@invalid_attrs)
    end

    test "update_warband/2 with valid data updates the warband", %{user: user} do
      warband = warband_fixture(%{user_id: user.id})
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Warband{} = warband} = Warbands.update_warband(warband, update_attrs)
      assert warband.name == "some updated name"
    end

    test "update_warband/2 with invalid data returns error changeset", %{user: user} do
      warband = warband_fixture(%{user_id: user.id})
      assert {:error, %Ecto.Changeset{}} = Warbands.update_warband(warband, @invalid_attrs)
      assert warband == Warbands.get_warband!(warband.id)
    end

    test "delete_warband/1 deletes the warband", %{user: user} do
      # require IEx
      # IEx.pry()
      warband = warband_fixture(%{user_id: user.id})
      assert {:ok, %Warband{}} = Warbands.delete_warband(warband)
      assert_raise Ecto.NoResultsError, fn -> Warbands.get_warband!(warband.id) end
    end

    test "change_warband/1 returns a warband changeset", %{user: user} do
      warband = warband_fixture(%{user_id: user.id})
      assert %Ecto.Changeset{} = Warbands.change_warband(warband)
    end
  end
end
