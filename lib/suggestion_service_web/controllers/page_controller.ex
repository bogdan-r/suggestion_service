defmodule SuggestionServiceWeb.PageController do
  use SuggestionServiceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
