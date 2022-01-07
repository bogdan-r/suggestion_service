defmodule SuggestionServiceWeb.Api.GoodController do
  use SuggestionServiceWeb, :controller

  alias SuggestionService.Goods

  def index(conn, _params) do
    goods = Goods.list_goods()
    render(conn, "index.json", goods: goods)
  end
end
