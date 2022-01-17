defmodule SuggestionService.Suggestion do
  alias SuggestionService.Goods
  alias SuggestionService.Bitap

  def suggest(text) do
    goods =
      Goods.list_goods()
      |> search(text)
    IO.inspect(goods)

    goods
  end

  defp search(entities, text) do
    entities
    |> Enum.reject(fn entity ->
      {res_title, title_errors} = Bitap.search(entity.title, text, 2)
      {res_descr, descr_errros} = Bitap.search(entity.description, text, 2)

      (res_title == "" && res_descr == "") ||
      String.length(res_title) == title_errors && String.length(res_descr) == descr_errros
   end)
  end
end
