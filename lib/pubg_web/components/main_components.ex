defmodule PUBGWeb.Components.MainComponents do
  @moduledoc """
  shared components for main views
  """

  use PUBGWeb, :component

  def header_bar(assigns) do
    ~H"""
      <div class="header-bar">
        <div class="logo-div"></div>
      </div>
    """
  end
end
