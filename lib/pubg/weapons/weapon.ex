defmodule PUBG.Weapons.Weapon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weapons" do
    field :description, :string
    field :is_console, :boolean, default: false
    field :is_crate, :boolean, default: false
    field :is_gun, :boolean, default: false
    field :is_main, :boolean, default: false
    field :is_melee, :boolean, default: false
    field :is_pc, :boolean, default: false
    field :is_pistol, :boolean, default: false
    field :name, :string
    field :official_name, :string
    field :img_url, :string

    field :caliber, Ecto.Enum,
      values: [
        :"7.62mm",
        :"5.56mm",
        :"9mm",
        :".45 ACP",
        :"12 Guage",
        :"300 Magnum",
        :"5.7mm",
        :Bolt,
        :"60mm Mortar",
        :"40mm Smoke",
        :Warhead
      ]

    field :type, Ecto.Enum,
      values: [
        :AR,
        :DMR,
        :SMG,
        :LMG,
        :SHOTGUN,
        :PISTOL,
        :CROSS_BOW,
        :MORTAR,
        :ROCKET
      ]

    many_to_many :maps, PUBG.Maps.Map, join_through: Pubg.Weapons.WeaponsMaps, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(weapon, attrs) do
    weapon
    |> cast(attrs, [
      :name,
      :description,
      :official_name,
      :is_crate,
      :is_main,
      :is_pistol,
      :is_gun,
      :is_console,
      :is_pc,
      :is_melee,
      :img_url,
      :caliber,
      :type
    ])
    |> validate_required([
      :name,
      :description,
      :official_name,
      :img_url,
      :caliber,
      :type
    ])
    |> put_map_assoc(attrs)
  end

  defp put_map_assoc(changeset, %{"maps" => maps}) do
    put_assoc(changeset, :maps, maps)
  end

  defp put_map_assoc(changeset, %{maps: maps}) do
    put_assoc(changeset, :maps, maps)
  end

  defp put_map_assoc(changeset, _) do
    changeset
  end
end
