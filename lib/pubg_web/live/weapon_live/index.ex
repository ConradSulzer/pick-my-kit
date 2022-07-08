defmodule PUBGWeb.WeaponLive.Index do
  use PUBGWeb, :live_view

  alias PUBG.Weapons
  alias PUBG.Weapons.Weapon

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :weapons, list_weapons())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Weapon")
    |> assign(:weapon, Weapons.get_weapon!(id, [:maps]))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Weapon")
    |> assign(:weapon, %Weapon{maps: []})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Weapons")
    |> assign(:weapon, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    weapon = Weapons.get_weapon!(id)
    {:ok, _} = Weapons.delete_weapon(weapon)

    {:noreply, assign(socket, :weapons, list_weapons())}
  end

  defp list_weapons do
    Weapons.list_weapons()
  end
end
