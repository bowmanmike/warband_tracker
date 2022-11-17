defmodule WarbandTrackerWeb.WarbandLiveTest do
  use WarbandTrackerWeb.ConnCase

  import Phoenix.LiveViewTest
  import WarbandTracker.WarbandsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_warband(%{user: user}) do
    warband = warband_fixture(%{user_id: user.id})
    %{warband: warband}
  end

  setup do
    user = insert(:user)

    %{user: user}
  end

  describe "Index" do
    setup [:create_warband]

    test "lists all warbands", %{conn: conn, warband: warband} do
      {:ok, _index_live, html} = live(conn, ~p"/warbands")

      assert html =~ "Listing Warbands"
      assert html =~ warband.name
    end

    test "saves new warband", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/warbands")

      assert index_live |> element("a", "New Warband") |> render_click() =~
               "New Warband"

      assert_patch(index_live, ~p"/warbands/new")

      assert index_live
             |> form("#warband-form", warband: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#warband-form", warband: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/warbands")

      assert html =~ "Warband created successfully"
      assert html =~ "some name"
    end

    test "updates warband in listing", %{conn: conn, warband: warband} do
      {:ok, index_live, _html} = live(conn, ~p"/warbands")

      assert index_live |> element("#warbands-#{warband.id} a", "Edit") |> render_click() =~
               "Edit Warband"

      assert_patch(index_live, ~p"/warbands/#{warband}/edit")

      assert index_live
             |> form("#warband-form", warband: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#warband-form", warband: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/warbands")

      assert html =~ "Warband updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes warband in listing", %{conn: conn, warband: warband} do
      {:ok, index_live, _html} = live(conn, ~p"/warbands")

      assert index_live |> element("#warbands-#{warband.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#warband-#{warband.id}")
    end
  end

  describe "Show" do
    setup [:create_warband]

    test "displays warband", %{conn: conn, warband: warband} do
      {:ok, _show_live, html} = live(conn, ~p"/warbands/#{warband}")

      assert html =~ "Show Warband"
      assert html =~ warband.name
    end

    test "updates warband within modal", %{conn: conn, warband: warband} do
      {:ok, show_live, _html} = live(conn, ~p"/warbands/#{warband}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Warband"

      assert_patch(show_live, ~p"/warbands/#{warband}/show/edit")

      assert show_live
             |> form("#warband-form", warband: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#warband-form", warband: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/warbands/#{warband}")

      assert html =~ "Warband updated successfully"
      assert html =~ "some updated name"
    end
  end
end
