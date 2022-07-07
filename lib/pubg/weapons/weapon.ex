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
      :img_url
    ])
    |> validate_required([
      :name,
      :description,
      :official_name,
      :img_url
    ])
  end
end
