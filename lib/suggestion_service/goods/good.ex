defmodule SuggestionService.Goods.Good do
  use Ecto.Schema
  import Ecto.Changeset

  schema "goods" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(good, attrs) do
    good
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
