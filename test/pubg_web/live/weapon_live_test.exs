defmodule PUBGWeb.WeaponLiveTest do
  use PUBGWeb.ConnCase

  import Phoenix.LiveViewTest
  import PUBG.WeaponsFixtures

  @create_attrs %{description: "some description", is_console: true, is_crate: true, is_gun: true, is_main: true, is_melee: true, is_pc: true, is_pistol: true, name: "some name", official_name: "some official_name"}
  @update_attrs %{description: "some updated description", is_console: false, is_crate: false, is_gun: false, is_main: false, is_melee: false, is_pc: false, is_pistol: false, name: "some updated name", official_name: "some updated official_name"}
  @invalid_attrs %{description: nil, is_console: false, is_crate: false, is_gun: false, is_main: false, is_melee: false, is_pc: false, is_pistol: false, name: nil, official_name: nil}

  defp create_weapon(_) do
    weapon = weapon_fixture()
    %{weapon: weapon}
  end

  describe "Index" do
    setup [:create_weapon]

    test "lists all weapons", %{conn: conn, weapon: weapon} do
      {:ok, _index_live, html} = live(conn, Routes.weapon_index_path(conn, :index))

      assert html =~ "Listing Weapons"
      assert html =~ weapon.description
    end

    test "saves new weapon", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.weapon_index_path(conn, :index))

      assert index_live |> element("a", "New Weapon") |> render_click() =~
               "New Weapon"

      assert_patch(index_live, Routes.weapon_index_path(conn, :new))

      assert index_live
             |> form("#weapon-form", weapon: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#weapon-form", weapon: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.weapon_index_path(conn, :index))

      assert html =~ "Weapon created successfully"
      assert html =~ "some description"
    end

    test "updates weapon in listing", %{conn: conn, weapon: weapon} do
      {:ok, index_live, _html} = live(conn, Routes.weapon_index_path(conn, :index))

      assert index_live |> element("#weapon-#{weapon.id} a", "Edit") |> render_click() =~
               "Edit Weapon"

      assert_patch(index_live, Routes.weapon_index_path(conn, :edit, weapon))

      assert index_live
             |> form("#weapon-form", weapon: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#weapon-form", weapon: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.weapon_index_path(conn, :index))

      assert html =~ "Weapon updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes weapon in listing", %{conn: conn, weapon: weapon} do
      {:ok, index_live, _html} = live(conn, Routes.weapon_index_path(conn, :index))

      assert index_live |> element("#weapon-#{weapon.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#weapon-#{weapon.id}")
    end
  end

  describe "Show" do
    setup [:create_weapon]

    test "displays weapon", %{conn: conn, weapon: weapon} do
      {:ok, _show_live, html} = live(conn, Routes.weapon_show_path(conn, :show, weapon))

      assert html =~ "Show Weapon"
      assert html =~ weapon.description
    end

    test "updates weapon within modal", %{conn: conn, weapon: weapon} do
      {:ok, show_live, _html} = live(conn, Routes.weapon_show_path(conn, :show, weapon))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Weapon"

      assert_patch(show_live, Routes.weapon_show_path(conn, :edit, weapon))

      assert show_live
             |> form("#weapon-form", weapon: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#weapon-form", weapon: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.weapon_show_path(conn, :show, weapon))

      assert html =~ "Weapon updated successfully"
      assert html =~ "some updated description"
    end
  end
end
