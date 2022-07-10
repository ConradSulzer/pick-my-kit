defmodule PUBG.Maps.Map do
  use Ecto.Schema
  import Ecto.Changeset

  schema "maps" do
    field :name, :string

    many_to_many :weapons, PUBG.Weapons.Weapon,
      join_through: Pubg.Weapons.WeaponsMaps,
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(map, attrs) do
    map
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> put_map_assoc(attrs)
  end

  defp put_map_assoc(changeset, %{"weapons" => maps}) do
    put_assoc(changeset, :weapons, maps)
  end

  defp put_map_assoc(changeset, %{weapons: maps}) do
    put_assoc(changeset, :weapons, maps)
  end

  defp put_map_assoc(changeset, _) do
    changeset
  end
end
