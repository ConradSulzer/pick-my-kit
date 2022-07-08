defmodule PUBG.MapsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PUBG.Maps` context.
  """

  @doc """
  Generate a map.
  """
  def map_fixture(attrs \\ %{}) do
    {:ok, map} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> PUBG.Maps.create_map()

    map
  end
end
