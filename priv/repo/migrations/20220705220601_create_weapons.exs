defmodule PUBG.Repo.Migrations.CreateWeapons do
  use Ecto.Migration

  def change do
    create table(:weapons) do
      add :name, :string
      add :description, :string
      add :official_name, :string
      add :img_url, :string
      add :is_crate, :boolean, default: false, null: false
      add :is_main, :boolean, default: false, null: false
      add :is_pistol, :boolean, default: false, null: false
      add :is_gun, :boolean, default: false, null: false
      add :is_console, :boolean, default: false, null: false
      add :is_pc, :boolean, default: false, null: false
      add :is_melee, :boolean, default: false, null: false
      add :is_enabled, :boolean, default: true, null: false
      add :caliber, :string, null: false
      add :type, :string, null: false

      timestamps()
    end

    create unique_index(:weapons, [:name])
    create unique_index(:weapons, [:official_name])
  end
end
