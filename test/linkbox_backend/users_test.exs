defmodule LinkboxBackend.UsersTest do
  use LinkboxBackend.DataCase

  alias LinkboxBackend.Users

  describe "links" do
    alias LinkboxBackend.Users.Link

    @valid_attrs %{note: "some note", url: "some url"}
    @update_attrs %{note: "some updated note", url: "some updated url"}
    @invalid_attrs %{note: nil, url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Users.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Users.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Users.create_link(@valid_attrs)
      assert link.note == "some note"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, %Link{} = link} = Users.update_link(link, @update_attrs)
      assert link.note == "some updated note"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_link(link, @invalid_attrs)
      assert link == Users.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Users.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Users.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Users.change_link(link)
    end
  end
end
