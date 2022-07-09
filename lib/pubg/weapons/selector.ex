defmodule PUBG.Weapons.Selector do
  @moduledoc """
  functions for choosing random weapons
  """
  require Logger
  alias PUBG.Maps

  def get_primary(params \\ %{}) do
    primary =
      params
      |> Map.merge(%{is_main: true})
      |> Maps.list_weapons_for_map()
      |> choose_random()

    {:ok, primary}
  end

  def get_pistol(params \\ %{}) do
    pistol =
      params
      |> Map.merge(%{is_pistol: true})
      |> Maps.list_weapons_for_map()
      |> choose_random()

    {:ok, pistol}
  end

  def get_kit(params \\ %{}) do
    with {:ok, primary_one} <- get_primary(params),
         {:ok, primary_two} <- get_primary(params),
         {:ok, primary_two} <- check_primary_match(primary_one, primary_two, params),
         {:ok, pistol} <-
           get_pistol(params) do
      {:ok, primary_one, primary_two, pistol}
    else
      other ->
        Logger.info("Unable to select weapons: #{inspect(other)}")
    end
  end

  defp check_primary_match(primary_one, primary_two, params)
       when primary_one.id == primary_two.id do
    {:ok, weapon} = get_primary(params)

    check_primary_match(primary_one, weapon, params)
  end

  defp check_primary_match(_primary_one, weapon, _params) do
    {:ok, weapon}
  end

  defp choose_random(weapons) do
    :rand.seed(:exsss)
    Enum.random(weapons)
  end
end
