defmodule PUBGWeb.PageController do
  use PUBGWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
