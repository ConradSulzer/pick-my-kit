defmodule PUBGWeb.IndexLive.Dashboard do
  use PUBGWeb, :live_view

  import Ecto.Changeset

  @types %{
    map: :string,
    is_crate: :boolean,
    is_gun: :boolean
  }

  def mount(_params, _session, socket) do
    maps = PUBG.Maps.list_map_options()

    {:ok,
     socket
     |> assign(:changeset, form_changeset())
     |> assign(:maps, maps)
     |> assign(:form_params, %{map: List.first(maps)})
     |> assign(:primary, nil)
     |> assign(:secondary, nil)
     |> assign(:pistol, nil)}
  end

  def handle_event(
        "change",
        %{"settings_form" => params},
        %{assigns: %{form_params: form_params}} = socket
      ) do
    params = params |> Jason.encode!() |> Jason.decode!(keys: :atoms)
    attrs = Map.merge(form_params, params)
    changeset = form_changeset(attrs)

    {:noreply,
     socket
     |> assign(form_params: attrs)
     |> assign(changeset: changeset)}
  end

  def handle_event("randomize", %{"settings_form" => params}, socket) do
    params =
      params
      |> Jason.encode!()
      |> Jason.decode!(keys: :atoms)
      |> Map.put(:is_gun, !String.to_existing_atom(params["is_gun"]))
      |> Map.put(:is_crate, String.to_existing_atom(params["is_crate"]))

    {:ok, primary, secondary, pistol} = PUBG.Weapons.Selector.get_kit(params)

    {:noreply,
     socket
     |> assign(:primary, primary)
     |> assign(:secondary, secondary)
     |> assign(:pistol, pistol)}
  end

  defp form_changeset(attrs \\ %{}) do
    {%{}, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required([:map])
  end
end
