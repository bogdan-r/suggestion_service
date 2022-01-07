defmodule SuggestionServiceWeb.GoodController do
  use SuggestionServiceWeb, :controller

  alias SuggestionService.Goods
  alias SuggestionService.Goods.Good

  def index(conn, _params) do
    goods = Goods.list_goods()
    render(conn, "index.html", goods: goods)
  end

  def new(conn, _params) do
    changeset = Goods.change_good(%Good{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"good" => good_params}) do
    case Goods.create_good(good_params) do
      {:ok, good} ->
        conn
        |> put_flash(:info, "Good created successfully.")
        |> redirect(to: Routes.good_path(conn, :show, good))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    good = Goods.get_good!(id)
    render(conn, "show.html", good: good)
  end

  def edit(conn, %{"id" => id}) do
    good = Goods.get_good!(id)
    changeset = Goods.change_good(good)
    render(conn, "edit.html", good: good, changeset: changeset)
  end

  def update(conn, %{"id" => id, "good" => good_params}) do
    good = Goods.get_good!(id)

    case Goods.update_good(good, good_params) do
      {:ok, good} ->
        conn
        |> put_flash(:info, "Good updated successfully.")
        |> redirect(to: Routes.good_path(conn, :show, good))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", good: good, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    good = Goods.get_good!(id)
    {:ok, _good} = Goods.delete_good(good)

    conn
    |> put_flash(:info, "Good deleted successfully.")
    |> redirect(to: Routes.good_path(conn, :index))
  end
end
