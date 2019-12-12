defmodule Clouds.UsersTest do
  use Clouds.DataCase

  alias Clouds.Users

  describe "users" do
    alias Clouds.Users.User

    @valid_attrs %{
      name: "some name",
      priv_key: "some priv_key",
      pub_key: "some pub_key",
      summary: "some summary",
      username: "some username"
    }
    @update_attrs %{
      name: "some updated name",
      priv_key: "some updated priv_key",
      pub_key: "some updated pub_key",
      summary: "some updated summary",
      username: "some updated username"
    }
    @invalid_attrs %{name: nil, priv_key: nil, pub_key: nil, summary: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.name == "some name"
      assert user.summary == "some summary"
      assert user.username == "some username"
      assert user.priv_key != "some priv_key"
      assert user.pub_key != "some pub_key"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.name == "some updated name"
      assert user.summary == "some updated summary"
      assert user.username == "some updated username"
      assert user.priv_key != "some updated priv_key"
      assert user.pub_key != "some updated pub_key"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
