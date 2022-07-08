defmodule Pubg.Weapons.WeaponsMaps do
  @moduledoc """
  Schema for joining weapons to maps
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "maps_weapons" do
    belongs_to(:map, PUBG.Maps.Map)
    belongs_to(:weapon, PUBG.Weapons.Weapon)
  end

  def changeset(data \\ %__MODULE__{}, attrs) do
    data
    |> cast(attrs, [:map_id, :weapon_id])
  end
end
