defmodule PUBG.WeaponsTest do
  use PUBG.DataCase

  alias PUBG.Weapons

  describe "weapons" do
    alias PUBG.Weapons.Weapon

    import PUBG.WeaponsFixtures

    @invalid_attrs %{description: nil, is_console: nil, is_crate: nil, is_gun: nil, is_main: nil, is_melee: nil, is_pc: nil, is_pistol: nil, name: nil, official_name: nil}

    test "list_weapons/0 returns all weapons" do
      weapon = weapon_fixture()
      assert Weapons.list_weapons() == [weapon]
    end

    test "get_weapon!/1 returns the weapon with given id" do
      weapon = weapon_fixture()
      assert Weapons.get_weapon!(weapon.id) == weapon
    end

    test "create_weapon/1 with valid data creates a weapon" do
      valid_attrs = %{description: "some description", is_console: true, is_crate: true, is_gun: true, is_main: true, is_melee: true, is_pc: true, is_pistol: true, name: "some name", official_name: "some official_name"}

      assert {:ok, %Weapon{} = weapon} = Weapons.create_weapon(valid_attrs)
      assert weapon.description == "some description"
      assert weapon.is_console == true
      assert weapon.is_crate == true
      assert weapon.is_gun == true
      assert weapon.is_main == true
      assert weapon.is_melee == true
      assert weapon.is_pc == true
      assert weapon.is_pistol == true
      assert weapon.name == "some name"
      assert weapon.official_name == "some official_name"
    end

    test "create_weapon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Weapons.create_weapon(@invalid_attrs)
    end

    test "update_weapon/2 with valid data updates the weapon" do
      weapon = weapon_fixture()
      update_attrs = %{description: "some updated description", is_console: false, is_crate: false, is_gun: false, is_main: false, is_melee: false, is_pc: false, is_pistol: false, name: "some updated name", official_name: "some updated official_name"}

      assert {:ok, %Weapon{} = weapon} = Weapons.update_weapon(weapon, update_attrs)
      assert weapon.description == "some updated description"
      assert weapon.is_console == false
      assert weapon.is_crate == false
      assert weapon.is_gun == false
      assert weapon.is_main == false
      assert weapon.is_melee == false
      assert weapon.is_pc == false
      assert weapon.is_pistol == false
      assert weapon.name == "some updated name"
      assert weapon.official_name == "some updated official_name"
    end

    test "update_weapon/2 with invalid data returns error changeset" do
      weapon = weapon_fixture()
      assert {:error, %Ecto.Changeset{}} = Weapons.update_weapon(weapon, @invalid_attrs)
      assert weapon == Weapons.get_weapon!(weapon.id)
    end

    test "delete_weapon/1 deletes the weapon" do
      weapon = weapon_fixture()
      assert {:ok, %Weapon{}} = Weapons.delete_weapon(weapon)
      assert_raise Ecto.NoResultsError, fn -> Weapons.get_weapon!(weapon.id) end
    end

    test "change_weapon/1 returns a weapon changeset" do
      weapon = weapon_fixture()
      assert %Ecto.Changeset{} = Weapons.change_weapon(weapon)
    end
  end
end
