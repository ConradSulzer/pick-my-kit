defmodule PUBG.Maps do
  @moduledoc """
  The Maps context.
  """

  import Ecto.Query, warn: false
  alias PUBG.Repo

  alias PUBG.Maps.Map

  @doc """
  Returns the list of maps.

  ## Examples

      iex> list_maps()
      [%Map{}, ...]

  """
  def list_maps do
    Repo.all(Map)
  end

  def list_map_options do
    Map
    |> select([m], m.name)
    |> Repo.all()
  end

  def list_map_options_with_id do
    Map
    |> select([m], {m.name, m.id})
    |> Repo.all()
  end

  @doc """
  Gets a single map.

  Raises `Ecto.NoResultsError` if the Map does not exist.

  ## Examples

      iex> get_map!(123)
      %Map{}

      iex> get_map!(456)
      ** (Ecto.NoResultsError)

  """
  def get_map!(id, preloads \\ []) do
    Map
    |> where([m], m.id == ^id)
    |> preload(^preloads)
    |> Repo.one()
  end

  @doc """
  Creates a map.

  ## Examples

      iex> create_map(%{field: value})
      {:ok, %Map{}}

      iex> create_map(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_map(attrs \\ %{}) do
    %Map{}
    |> Map.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a map.

  ## Examples

      iex> update_map(map, %{field: new_value})
      {:ok, %Map{}}

      iex> update_map(map, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_map(%Map{} = map, attrs) do
    map
    |> Map.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a map.

  ## Examples

      iex> delete_map(map)
      {:ok, %Map{}}

      iex> delete_map(map)
      {:error, %Ecto.Changeset{}}

  """
  def delete_map(%Map{} = map) do
    Repo.delete(map)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking map changes.

  ## Examples

      iex> change_map(map)
      %Ecto.Changeset{data: %Map{}}

  """
  def change_map(%Map{} = map, attrs \\ %{}) do
    Map.changeset(map, attrs)
  end

  def list_weapons_for_map(params) do
    {map_name, params} = Elixir.Map.pop(params, :map)

    Map
    |> join(:inner, [m], w in assoc(m, :weapons))
    |> where([m], m.name == ^map_name)
    |> add_filters(params)
    |> select([m, w], w)
    |> Repo.all()
  end

  defp add_filters(query, params) do
    Enum.reduce(params, query, fn {k, v}, query ->
      where(query, [m, w], field(w, ^k) == ^v)
    end)
  end
end
