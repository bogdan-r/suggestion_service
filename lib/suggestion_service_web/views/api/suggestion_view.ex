defmodule SuggestionServiceWeb.Api.SuggestionView do
  use SuggestionServiceWeb, :view

  def render("suggestion.json", %{suggestions: suggestions}) do
    %{
      data: Enum.map(suggestions, &render_suggestion_item/1)
    }
  end

  def render_suggestion_item(suggestion) do
    %{
      title: suggestion.title,
      description: suggestion.description
    }
  end
end
