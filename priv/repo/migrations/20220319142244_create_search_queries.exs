defmodule Nutrino.Repo.Migrations.CreateSearchQueries do
  use Ecto.Migration

  def change do
    create table(:search_queries) do
      add :query_text, :string
      add :calories, :integer
      add :fat, :integer
      add :carbohydrates, :integer
      add :protein, :integer

      timestamps()
    end
  end
end
