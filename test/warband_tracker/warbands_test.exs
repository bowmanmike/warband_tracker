defmodule WarbandTracker.WarbandsTest do
  use WarbandTracker.DataCase

  alias WarbandTracker.Warbands

  setup do
    user = insert(:user)

    %{user: user}
  end

  describe "warbands" do
    alias WarbandTracker.Warbands.Warband

    @invalid_attrs %{name: nil, user_id: nil}

    test "list_warbands/0 returns all warbands", %{user: user} do
      %{id: warband_id} = insert(:warband, user: user)
      assert [%{id: ^warband_id}] = Warbands.list_warbands()
    end

    test "list_warbands_for_user/1 returns all warbands for the provided user", %{user: user} do
      insert_list(3, :warband, user: user)
      other = insert(:warband)

      result = Warbands.list_warbands_for_user(user)

      assert length(result) == 3
      assert Enum.all?(result, &(&1.user_id == user.id))
      refute other.user_id == user.id
    end

    test "get_warband!/1 returns the warband with given id", %{user: user} do
      %{id: warband_id} = insert(:warband, user: user)
      assert %{id: ^warband_id} = Warbands.get_warband!(warband_id)
    end

    test "get_warband_for_user!/2 returns the warband matching the warband_id and the user_id", %{
      user: user
    } do
      %{id: user_warband_id} = insert(:warband, user: user)
      %{id: non_user_warband_id} = insert(:warband)

      assert %{id: ^user_warband_id} = Warbands.get_warband_for_user!(user, user_warband_id)

      assert_raise Ecto.NoResultsError, fn ->
        Warbands.get_warband_for_user!(user, non_user_warband_id)
      end
    end

    test "create_warband/1 with valid data creates a warband", %{user: user} do
      valid_attrs = %{name: "some name", user_id: user.id}

      assert {:ok, %Warband{} = warband} = Warbands.create_warband(valid_attrs)
      assert warband.name == "some name"

      warband = Repo.preload(warband, :user)
      assert warband.user_id == user.id
    end

    test "create_warband/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warbands.create_warband(@invalid_attrs)
    end

    test "update_warband/2 with valid data updates the warband", %{user: user} do
      warband = insert(:warband, user: user)
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Warband{} = warband} = Warbands.update_warband(warband, update_attrs)
      assert warband.name == "some updated name"
    end

    test "update_warband/2 with invalid data returns error changeset", %{user: user} do
      %{id: warband_id} = warband = insert(:warband, user: user)
      assert {:error, %Ecto.Changeset{}} = Warbands.update_warband(warband, @invalid_attrs)
      assert %{id: ^warband_id} = Warbands.get_warband!(warband_id)
    end

    test "delete_warband/1 deletes the warband", %{user: user} do
      warband = insert(:warband, user: user)
      assert {:ok, %Warband{}} = Warbands.delete_warband(warband)
      assert_raise Ecto.NoResultsError, fn -> Warbands.get_warband!(warband.id) end
    end

    test "change_warband/1 returns a warband changeset", %{user: user} do
      warband = insert(:warband, user: user)
      assert %Ecto.Changeset{} = Warbands.change_warband(warband)
    end
  end
end
