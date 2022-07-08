defmodule PUBG.Weapons do
  @moduledoc """
  The Weapons context.
  """

  import Ecto.Query, warn: false
  alias PUBG.Repo

  alias PUBG.Weapons.Weapon

  @doc """
  Returns the list of weapons.

  ## Examples

      iex> list_weapons()
      [%Weapon{}, ...]

  """

  def list_weapons(params \\ %{}) do
    Weapon
    |> add_filters(params)
    |> Repo.all()
  end

  @doc """
  Gets a single weapon.

  Raises `Ecto.NoResultsError` if the Weapon does not exist.

  ## Examples

      iex> get_weapon!(123)
      %Weapon{}

      iex> get_weapon!(456)
      ** (Ecto.NoResultsError)

  """
  def get_weapon!(id, preloads \\ []) do
    Weapon
    |> where([w], w.id == ^id)
    |> preload(^preloads)
    |> Repo.one()
  end

  # do: Repo.get!(Weapon, id) |> Repo.preload(preloads)

  @doc """
  Creates a weapon.

  ## Examples

      iex> create_weapon(%{field: value})
      {:ok, %Weapon{}}

      iex> create_weapon(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_weapon(attrs) do
    attrs =
      attrs
      |> Jason.encode!()
      |> Jason.decode!(keys: :atoms)
      |> add_maps_to_attrs()

    %Weapon{}
    |> Weapon.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a weapon.

  ## Examples

      iex> update_weapon(weapon, %{field: new_value})
      {:ok, %Weapon{}}

      iex> update_weapon(weapon, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_weapon(%Weapon{} = weapon, attrs) do
    attrs =
      attrs
      |> Jason.encode!()
      |> Jason.decode!(keys: :atoms)
      |> add_maps_to_attrs()

    weapon
    |> Weapon.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a weapon.

  ## Examples

      iex> delete_weapon(weapon)
      {:ok, %Weapon{}}

      iex> delete_weapon(weapon)
      {:error, %Ecto.Changeset{}}

  """
  def delete_weapon(%Weapon{} = weapon) do
    Repo.delete(weapon)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking weapon changes.

  ## Examples

      iex> change_weapon(weapon)
      %Ecto.Changeset{data: %Weapon{}}

  """
  def change_weapon(%Weapon{} = weapon, attrs \\ %{maps: []}) do
    Weapon.changeset(weapon, attrs)
  end

  defp add_filters(query, params) do
    Enum.reduce(params, query, fn {k, v}, query ->
      where(query, [w], field(w, ^k) == ^v)
    end)
  end

  defp add_maps_to_attrs(%{maps: [head | _rest]} = attrs) when head == %PUBG.Maps.Map{} do
    attrs
  end

  defp add_maps_to_attrs(%{maps: [head | _rest] = map_ids} = attrs) when is_binary(head) do
    map_options = PUBG.Maps.list_maps()

    selected_maps =
      Enum.reduce(map_ids, [], fn id, acc ->
        result = Enum.find(map_options, &(&1.id == String.to_integer(id)))
        (!!result && [result | acc]) || acc
      end)

    Map.put(attrs, :maps, selected_maps)
  end

  defp add_maps_to_attrs(attrs) do
    Map.put(attrs, :maps, [])
  end
end
