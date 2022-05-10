defmodule NutrinoWeb.RecipesController do
  use NutrinoWeb, :controller
  alias Nutrino.Recipes

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, params) do
    recipes = Recipes.get_recipes(params)
    render(conn, "recipes.html", recipes: recipes)
  end

end
