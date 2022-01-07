defmodule SuggestionService.GoodsTest do
  use SuggestionService.DataCase

  alias SuggestionService.Goods

  describe "goods" do
    alias SuggestionService.Goods.Good

    import SuggestionService.GoodsFixtures

    @invalid_attrs %{description: nil, title: nil}

    test "list_goods/0 returns all goods" do
      good = good_fixture()
      assert Goods.list_goods() == [good]
    end

    test "get_good!/1 returns the good with given id" do
      good = good_fixture()
      assert Goods.get_good!(good.id) == good
    end

    test "create_good/1 with valid data creates a good" do
      valid_attrs = %{description: "some description", title: "some title"}

      assert {:ok, %Good{} = good} = Goods.create_good(valid_attrs)
      assert good.description == "some description"
      assert good.title == "some title"
    end

    test "create_good/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Goods.create_good(@invalid_attrs)
    end

    test "update_good/2 with valid data updates the good" do
      good = good_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title"}

      assert {:ok, %Good{} = good} = Goods.update_good(good, update_attrs)
      assert good.description == "some updated description"
      assert good.title == "some updated title"
    end

    test "update_good/2 with invalid data returns error changeset" do
      good = good_fixture()
      assert {:error, %Ecto.Changeset{}} = Goods.update_good(good, @invalid_attrs)
      assert good == Goods.get_good!(good.id)
    end

    test "delete_good/1 deletes the good" do
      good = good_fixture()
      assert {:ok, %Good{}} = Goods.delete_good(good)
      assert_raise Ecto.NoResultsError, fn -> Goods.get_good!(good.id) end
    end

    test "change_good/1 returns a good changeset" do
      good = good_fixture()
      assert %Ecto.Changeset{} = Goods.change_good(good)
    end
  end
end
