defmodule Nutrino.HttpRequest do

  @recipeAppId "1b75dbef"
  @recipeAppKey "dae89fe6395d253549494c5da468ada0"
  @recipeUrl "https://api.edamam.com/api/recipes/v2/?type=public&app_id=#{@recipeAppId}&app_key=#{@recipeAppKey}&random=true"

  @nutrientAppId "12c7b323"
  @nutrientAppKey "08fb0766a75e4d910860294b5869d3e9"
  @nutrientUrl "https://trackapi.nutritionix.com/v2/natural/nutrients"

  def get_recipe_request_body(search_string) do
    custom_url = "#{@recipeUrl}&q=#{search_string}"

    case HTTPoison.get(custom_url) do
      {:ok, http_response} -> get_body(http_response)
      {:error, error_msg} -> raise "Error occured during http GET /recipe request: #{error_msg}"
    end
  end

  def get_nutrient_request_body(description) do
    req_body = Jason.encode!(%{query: description})
    IO.puts "Sent json: #{req_body}"
    header = %{"x-app-id" => @nutrientAppId, "x-app-key" => @nutrientAppKey,
     "Content-Type" => "application/json"}
    url = @nutrientUrl

    case HTTPoison.post(url, req_body, header) do
      {:ok, http_response} -> get_body(http_response)
      {:error, error_msg} -> raise "Dependency to nutrition website failed during GET /recipe request: #{error_msg}"
    end
    # Odkomentować, gdyby API osiągnęło swój limit
    # %{"foods" =>
    #   [%{"nf_total_fat" => 2, "nf_total_carbohydrate" => 4, "nf_protein" => 6, "dummy_key" => "dummy value"},
    #    %{"nf_total_fat" => 3, "nf_total_carbohydrate" => 6, "nf_protein" => 10, "dummy_key" => "dummy value"}]}
  end

  defp get_body(response) do
    case response |> Map.get(:body) |> Jason.decode() do
      {:ok, body} -> body
      {:error, err_msg} -> raise "Error occured during json parsing. #{err_msg}"
    end
  end
end
