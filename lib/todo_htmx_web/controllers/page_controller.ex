defmodule TodoHtmxWeb.PageController do
  use TodoHtmxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
