defmodule SuggestionService.Repo do
  use Ecto.Repo,
    otp_app: :suggestion_service,
    adapter: Ecto.Adapters.Postgres
end
