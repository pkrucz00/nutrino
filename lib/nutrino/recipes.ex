defmodule Nutrino.Recipes do

  alias Nutrino.HttpRequest

  @nutritionMap %{"fat" => "nf_total_fat", "carbohydrates" => "nf_total_carbohydrate", "protein" => "nf_protein"}

  def get_recipes(%{"search_string" => search_string} = params) do
    nutrients = Enum.map(@nutritionMap, fn {k, v} -> {v, parse_integer(params[k])} end) |> Enum.into(%{})
    get_recipes(search_string, nutrients)
  end

  defp parse_integer(int_str) do
    case Integer.parse(int_str) do
      {integer, _} -> integer
      :error -> raise NutrinoWeb.BadRequest, "#{int_str} is not an integer"
    end
  end

  def get_recipes(search_string, nutrients) do
    all_recipes = get_query_recipes(search_string)
    nutrition_totals = get_nutritions(all_recipes, Map.keys(nutrients))
    recipes_with_description = join_maps_in_lists(all_recipes, nutrition_totals)
    filter_out_recipies_without_necessary_nutrient_totals(recipes_with_description, nutrients)
  end

  defp get_query_recipes(url) do
    HttpRequest.get_recipe_request_body(url)
    |> Map.get("hits")
    |> Enum.map(&get_necessary_recipe_data/1)
  end

  defp get_necessary_recipe_data(%{"recipe" => %{"label" => label, "url" => url, "ingredientLines" => ingredient_lines}}) do
    description = get_recipe_description(ingredient_lines)
    %{label: label, url: url, description: description}
  end

  defp get_recipe_description(ingredient_lines) do
    ingredient_lines
    |> Enum.map( &(hd(String.split(&1, " or "))) )
    |> Enum.join("; ")
  end

  defp get_nutritions(recipes, nutrient_names) do
    recipes
    |> Enum.map(&(Task.async( fn -> get_nutritions_for_one_recipe(&1, nutrient_names) end)))
    |> Enum.map(&Task.await/1)
  end

  defp get_nutritions_for_one_recipe(%{description: description}, nutrient_names) do
    food_data = HttpRequest.get_nutrient_request_body(description)
      |> Map.get("foods")

    nutrient_names
      |> Enum.map( &( {String.to_atom(&1), sum_recipe_nutrient_total(food_data, &1)} ) )
      |> Enum.into(%{})
  end

  defp sum_recipe_nutrient_total(food_data, nutrient_name) do
    food_data
      |> Enum.map( &(Map.get(&1, nutrient_name)) )
      |> Enum.sum()
  end

  defp join_maps_in_lists(first_list, second_list) do
    Enum.zip(first_list, second_list)
    |> Enum.map( fn {first_map, second_map} -> Map.merge(first_map, second_map) end)
  end

  defp filter_out_recipies_without_necessary_nutrient_totals(recipes, nutrients) do
    Enum.filter(recipes, &( has_enough_nutrients(&1, nutrients)) )
  end

  defp has_enough_nutrients(recipe, nutrients) do
    nutrients
      |> Enum.to_list()
      |> Stream.map( &(has_enough_nutrient(recipe, &1)) )
      |> Enum.reduce( &( &1 and &2) )
  end

  defp has_enough_nutrient(recipe, {nutrient_name, min_nutrient_val}) do
    recipe[nutrient_name] >= min_nutrient_val
  end

end
