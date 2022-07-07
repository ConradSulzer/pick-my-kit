defmodule PUBGWeb.IndexLive.Dashboard do
  use PUBGWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:primary, nil) |> assign(:secondary, nil) |> assign(:pistol, nil)}
  end

  def handle_event("randomize", _, socket) do
    {:noreply, socket}
  end
end
