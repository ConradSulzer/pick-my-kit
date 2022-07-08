defmodule PUBG.Repo.Migrations.AddMapWeaponJoinTable do
  use Ecto.Migration

  def change do
    create table(:maps_weapons) do
      add(:map_id, references(:maps, on_delete: :delete_all))
      add(:weapon_id, references(:weapons, on_delete: :delete_all))
    end

    create index(:maps_weapons, [:map_id])
    create index(:maps_weapons, [:weapon_id])
  end
end
