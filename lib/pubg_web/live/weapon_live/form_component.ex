defmodule PUBGWeb.WeaponLive.FormComponent do
  use PUBGWeb, :live_component

  alias PUBG.Weapons

  @impl true
  def update(%{weapon: weapon} = assigns, socket) do
    changeset = Weapons.change_weapon(weapon)
    maps = PUBG.Maps.list_maps()
    map_options = Enum.map(maps, &{&1.name, &1.id})
    selected_maps = Enum.map(weapon.maps, & &1.id)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:maps, maps)
     |> assign(:selected_maps, selected_maps)
     |> assign(:map_options, map_options)}
  end

  @impl true
  def handle_event("validate", %{"weapon" => weapon_params}, socket) do
    weapon_params = Map.put_new(weapon_params, "maps", [])

    changeset =
      socket.assigns.weapon
      |> Weapons.change_weapon(weapon_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"weapon" => weapon_params}, socket) do
    weapon_params = Map.put(weapon_params, :maps, weapon_params["map_multi"])
    save_weapon(socket, socket.assigns.action, weapon_params)
  end

  defp save_weapon(socket, :edit, weapon_params) do
    case Weapons.update_weapon(socket.assigns.weapon, weapon_params) do
      {:ok, _weapon} ->
        {:noreply,
         socket
         |> put_flash(:info, "Weapon updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_weapon(socket, :new, weapon_params) do
    case Weapons.create_weapon(weapon_params) do
      {:ok, _weapon} ->
        {:noreply,
         socket
         |> put_flash(:info, "Weapon created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
