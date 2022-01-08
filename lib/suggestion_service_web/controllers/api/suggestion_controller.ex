defmodule SuggestionServiceWeb.Api.SuggestionController do
  use SuggestionServiceWeb, :controller

  alias SuggestionService.Suggestion

  def suggest(conn, params) do
    query = params["q"]

    suggestions = Suggestion.suggest(query)

    render(conn, "suggestion.json", suggestions: suggestions)
  end
end
