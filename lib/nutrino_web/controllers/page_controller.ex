defmodule NutrinoWeb.PageController do
  use NutrinoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
