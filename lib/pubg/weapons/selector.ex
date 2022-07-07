defmodule PUBG.Weapons.Selector do
  @moduledoc """
  functions for choosing random weapons
  """
  require Logger
  alias PUBG.Weapons

  def get_primary(params \\ %{}) do
    primary =
      params
      |> Map.merge(%{is_main: true})
      |> Weapons.list_weapons()
      |> choose_random()

    {:ok, primary}
  end

  def get_secondary(primary, params \\ %{}) do
    secondary =
      params
      |> get_primary()
      |> check_primary_match(primary, params)

    {:ok, secondary}
  end

  def get_pistol(params \\ %{}) do
    pistol =
      params
      |> Map.merge(%{is_pistol: true})
      |> Weapons.list_weapons()
      |> choose_random()

    {:ok, pistol}
  end

  def get_kit(params \\ %{}) do
    with {:ok, primary} <- get_primary(params),
         {:ok, secondary} <- get_secondary(params),
         {:ok, pistol} <- get_pistol(params) do
      {:ok, primary, secondary, pistol}
    else
      other ->
        Logger.info("Unable to select weapons: #{inspect(other)}")
    end
  end

  defp check_primary_match({:ok, secondary}, primary, params)
       when secondary.id == primary.id do
    primary
    |> get_secondary(params)
    |> check_primary_match(primary, params)
  end

  defp check_primary_match(secondary, _primary, _params) do
    {:ok, secondary}
  end

  defp choose_random(weapons) do
    :rand.seed(:exsss)
    Enum.random(weapons)
  end
end
