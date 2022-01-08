defmodule SuggestionService.Suggestion do
  alias SuggestionService.Goods

  def suggest(text) do
    goods = Goods.list_goods()

    []
  end

  defp search(text) do

  end
end
