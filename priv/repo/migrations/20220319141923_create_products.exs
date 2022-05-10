defmodule Nutrino.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :string
      add :price, :decimal
      add :views, :integer

      timestamps()
    end
  end
end