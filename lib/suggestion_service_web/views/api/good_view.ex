defmodule SuggestionServiceWeb.Api.GoodView do
  use SuggestionServiceWeb, :view

  def render("index.json", %{goods: goods}) do
    %{data: Enum.map(goods, &render_item/1)}
  end

  def render_item(good) do
    %{
      title: good.title,
      description: good.description
    }
  end
end
