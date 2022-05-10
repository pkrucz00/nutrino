defmodule NutrinoWeb.SearchQueryControllerTest do
  use NutrinoWeb.ConnCase

  import Nutrino.RecipesFixtures

  @create_attrs %{calories: 42, carbohydrates: 42, fat: 42, protein: 42, query_text: "some query_text"}
  @update_attrs %{calories: 43, carbohydrates: 43, fat: 43, protein: 43, query_text: "some updated query_text"}
  @invalid_attrs %{calories: nil, carbohydrates: nil, fat: nil, protein: nil, query_text: nil}

  describe "index" do
    test "lists all search_queries", %{conn: conn} do
      conn = get(conn, Routes.search_query_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Search queries"
    end
  end

  describe "new search_query" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.search_query_path(conn, :new))
      assert html_response(conn, 200) =~ "New Search query"
    end
  end

  describe "create search_query" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.search_query_path(conn, :create), search_query: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.search_query_path(conn, :show, id)

      conn = get(conn, Routes.search_query_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Search query"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.search_query_path(conn, :create), search_query: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Search query"
    end
  end

  describe "edit search_query" do
    setup [:create_search_query]

    test "renders form for editing chosen search_query", %{conn: conn, search_query: search_query} do
      conn = get(conn, Routes.search_query_path(conn, :edit, search_query))
      assert html_response(conn, 200) =~ "Edit Search query"
    end
  end

  describe "update search_query" do
    setup [:create_search_query]

    test "redirects when data is valid", %{conn: conn, search_query: search_query} do
      conn = put(conn, Routes.search_query_path(conn, :update, search_query), search_query: @update_attrs)
      assert redirected_to(conn) == Routes.search_query_path(conn, :show, search_query)

      conn = get(conn, Routes.search_query_path(conn, :show, search_query))
      assert html_response(conn, 200) =~ "some updated query_text"
    end

    test "renders errors when data is invalid", %{conn: conn, search_query: search_query} do
      conn = put(conn, Routes.search_query_path(conn, :update, search_query), search_query: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Search query"
    end
  end

  describe "delete search_query" do
    setup [:create_search_query]

    test "deletes chosen search_query", %{conn: conn, search_query: search_query} do
      conn = delete(conn, Routes.search_query_path(conn, :delete, search_query))
      assert redirected_to(conn) == Routes.search_query_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.search_query_path(conn, :show, search_query))
      end
    end
  end

  defp create_search_query(_) do
    search_query = search_query_fixture()
    %{search_query: search_query}
  end
end
