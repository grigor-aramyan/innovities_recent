defmodule InnovitiesWeb.PageController do
  use InnovitiesWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
