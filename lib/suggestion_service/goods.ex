defmodule SuggestionService.Goods do
  @moduledoc """
  The Goods context.
  """

  import Ecto.Query, warn: false
  alias SuggestionService.Repo

  alias SuggestionService.Goods.Good

  @doc """
  Returns the list of goods.

  ## Examples

      iex> list_goods()
      [%Good{}, ...]

  """
  def list_goods do
    Repo.all(Good)
  end

  @doc """
  Gets a single good.

  Raises `Ecto.NoResultsError` if the Good does not exist.

  ## Examples

      iex> get_good!(123)
      %Good{}

      iex> get_good!(456)
      ** (Ecto.NoResultsError)

  """
  def get_good!(id), do: Repo.get!(Good, id)

  @doc """
  Creates a good.

  ## Examples

      iex> create_good(%{field: value})
      {:ok, %Good{}}

      iex> create_good(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_good(attrs \\ %{}) do
    %Good{}
    |> Good.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a good.

  ## Examples

      iex> update_good(good, %{field: new_value})
      {:ok, %Good{}}

      iex> update_good(good, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_good(%Good{} = good, attrs) do
    good
    |> Good.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a good.

  ## Examples

      iex> delete_good(good)
      {:ok, %Good{}}

      iex> delete_good(good)
      {:error, %Ecto.Changeset{}}

  """
  def delete_good(%Good{} = good) do
    Repo.delete(good)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking good changes.

  ## Examples

      iex> change_good(good)
      %Ecto.Changeset{data: %Good{}}

  """
  def change_good(%Good{} = good, attrs \\ %{}) do
    Good.changeset(good, attrs)
  end
end
