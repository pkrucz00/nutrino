defmodule Nutrino.RecipesTest do
  use Nutrino.DataCase

  alias Nutrino.Recipes

  describe "search_queries" do
    alias Nutrino.Recipes.SearchQuery

    import Nutrino.RecipesFixtures

    @invalid_attrs %{calories: nil, carbohydrates: nil, fat: nil, protein: nil, query_text: nil}

    test "list_search_queries/0 returns all search_queries" do
      search_query = search_query_fixture()
      assert Recipes.list_search_queries() == [search_query]
    end

    test "get_search_query!/1 returns the search_query with given id" do
      search_query = search_query_fixture()
      assert Recipes.get_search_query!(search_query.id) == search_query
    end

    test "create_search_query/1 with valid data creates a search_query" do
      valid_attrs = %{calories: 42, carbohydrates: 42, fat: 42, protein: 42, query_text: "some query_text"}

      assert {:ok, %SearchQuery{} = search_query} = Recipes.create_search_query(valid_attrs)
      assert search_query.calories == 42
      assert search_query.carbohydrates == 42
      assert search_query.fat == 42
      assert search_query.protein == 42
      assert search_query.query_text == "some query_text"
    end

    test "create_search_query/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_search_query(@invalid_attrs)
    end

    test "update_search_query/2 with valid data updates the search_query" do
      search_query = search_query_fixture()
      update_attrs = %{calories: 43, carbohydrates: 43, fat: 43, protein: 43, query_text: "some updated query_text"}

      assert {:ok, %SearchQuery{} = search_query} = Recipes.update_search_query(search_query, update_attrs)
      assert search_query.calories == 43
      assert search_query.carbohydrates == 43
      assert search_query.fat == 43
      assert search_query.protein == 43
      assert search_query.query_text == "some updated query_text"
    end

    test "update_search_query/2 with invalid data returns error changeset" do
      search_query = search_query_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_search_query(search_query, @invalid_attrs)
      assert search_query == Recipes.get_search_query!(search_query.id)
    end

    test "delete_search_query/1 deletes the search_query" do
      search_query = search_query_fixture()
      assert {:ok, %SearchQuery{}} = Recipes.delete_search_query(search_query)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_search_query!(search_query.id) end
    end

    test "change_search_query/1 returns a search_query changeset" do
      search_query = search_query_fixture()
      assert %Ecto.Changeset{} = Recipes.change_search_query(search_query)
    end
  end
end
