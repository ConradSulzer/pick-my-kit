defmodule PUBGWeb.Router do
  use PUBGWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PUBGWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PUBGWeb do
    pipe_through :browser

    live "/", IndexLive.Dashboard, :index
  end

  scope "/admin", PUBGWeb do
    pipe_through :browser

    live "/weapons", WeaponLive.Index, :index
    live "/weapons/new", WeaponLive.Index, :new
    live "/weapons/:id/edit", WeaponLive.Index, :edit

    live "/weapons/:id", WeaponLive.Show, :show
    live "/weapons/:id/show/edit", WeaponLive.Show, :edit

    live "/maps", MapLive.Index, :index
    live "/maps/new", MapLive.Index, :new
    live "/maps/:id/edit", MapLive.Index, :edit

    live "/maps/:id", MapLive.Show, :show
    live "/maps/:id/show/edit", MapLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", PUBGWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PUBGWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
