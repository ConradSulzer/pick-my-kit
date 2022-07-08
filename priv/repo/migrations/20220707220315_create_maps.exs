defmodule PUBG.Repo.Migrations.CreateMaps do
  use Ecto.Migration

  def change do
    create table(:maps) do
      add :name, :string

      timestamps()
    end

    create unique_index(:maps, [:name])
  end
end
