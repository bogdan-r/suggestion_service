defmodule SuggestionService.Repo.Migrations.CreateGoods do
  use Ecto.Migration

  def change do
    create table(:goods) do
      add :title, :string
      add :description, :string

      timestamps()
    end
  end
end
