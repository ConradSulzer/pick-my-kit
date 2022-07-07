defmodule PUBG.WeaponsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PUBG.Weapons` context.
  """

  @doc """
  Generate a weapon.
  """
  def weapon_fixture(attrs \\ %{}) do
    {:ok, weapon} =
      attrs
      |> Enum.into(%{
        description: "some description",
        is_console: true,
        is_crate: true,
        is_gun: true,
        is_main: true,
        is_melee: true,
        is_pc: true,
        is_pistol: true,
        name: "some name",
        official_name: "some official_name"
      })
      |> PUBG.Weapons.create_weapon()

    weapon
  end
end
