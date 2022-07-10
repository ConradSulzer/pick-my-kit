defmodule PUBGWeb.MapLive.Show do
  use PUBGWeb, :live_view

  alias PUBG.Maps

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    weapons = PUBG.Weapons.list_weapons()

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:map, Maps.get_map!(id, [:weapons]))
     |> assign(:weapons, weapons)}
  end

  @impl true
  def handle_event(
        "save",
        %{"map_weapons" => map_weapons},
        %{assigns: %{weapons: weapons, map: map}} = socket
      ) do
    IO.inspect(map_weapons, label: "MAP WEAPONS")

    selected_weapons =
      Enum.reduce(map_weapons, [], fn {_k, v}, acc ->
        if v != "" do
          result = Enum.find(weapons, &(&1.id == String.to_integer(v)))
          (!!result && [result | acc]) || acc
        else
          acc
        end
      end)

    IO.inspect(selected_weapons, label: "SELECTED WEAPONS")

    result = PUBG.Maps.update_map(map, %{weapons: selected_weapons})

    IO.inspect(result, label: "RESULT")

    {:noreply, socket}
  end

  defp page_title(:show), do: "Show Map"
  defp page_title(:edit), do: "Edit Map"
end
