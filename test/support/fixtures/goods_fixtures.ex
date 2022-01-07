defmodule SuggestionService.GoodsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SuggestionService.Goods` context.
  """

  @doc """
  Generate a good.
  """
  def good_fixture(attrs \\ %{}) do
    {:ok, good} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> SuggestionService.Goods.create_good()

    good
  end
end
