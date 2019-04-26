defmodule Innovities.SocialTest do
  use Innovities.DataCase

  alias Innovities.Social

  describe "connections" do
    alias Innovities.Social.Connection

    @valid_attrs %{receiver_id: 42, receiver_is_organization: true, sender_id: 42, sender_is_organization: true}
    @update_attrs %{receiver_id: 43, receiver_is_organization: false, sender_id: 43, sender_is_organization: false}
    @invalid_attrs %{receiver_id: nil, receiver_is_organization: nil, sender_id: nil, sender_is_organization: nil}

    def connection_fixture(attrs \\ %{}) do
      {:ok, connection} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_connection()

      connection
    end

    test "list_connections/0 returns all connections" do
      connection = connection_fixture()
      assert Social.list_connections() == [connection]
    end

    test "get_connection!/1 returns the connection with given id" do
      connection = connection_fixture()
      assert Social.get_connection!(connection.id) == connection
    end

    test "create_connection/1 with valid data creates a connection" do
      assert {:ok, %Connection{} = connection} = Social.create_connection(@valid_attrs)
      assert connection.receiver_id == 42
      assert connection.receiver_is_organization == true
      assert connection.sender_id == 42
      assert connection.sender_is_organization == true
    end

    test "create_connection/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_connection(@invalid_attrs)
    end

    test "update_connection/2 with valid data updates the connection" do
      connection = connection_fixture()
      assert {:ok, connection} = Social.update_connection(connection, @update_attrs)
      assert %Connection{} = connection
      assert connection.receiver_id == 43
      assert connection.receiver_is_organization == false
      assert connection.sender_id == 43
      assert connection.sender_is_organization == false
    end

    test "update_connection/2 with invalid data returns error changeset" do
      connection = connection_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_connection(connection, @invalid_attrs)
      assert connection == Social.get_connection!(connection.id)
    end

    test "delete_connection/1 deletes the connection" do
      connection = connection_fixture()
      assert {:ok, %Connection{}} = Social.delete_connection(connection)
      assert_raise Ecto.NoResultsError, fn -> Social.get_connection!(connection.id) end
    end

    test "change_connection/1 returns a connection changeset" do
      connection = connection_fixture()
      assert %Ecto.Changeset{} = Social.change_connection(connection)
    end
  end

  describe "notifications" do
    alias Innovities.Social.Notification

    @valid_attrs %{body: "some body", notification_type: "some notification_type", requested_idea_id: 42, title: "some title"}
    @update_attrs %{body: "some updated body", notification_type: "some updated notification_type", requested_idea_id: 43, title: "some updated title"}
    @invalid_attrs %{body: nil, notification_type: nil, requested_idea_id: nil, title: nil}

    def notification_fixture(attrs \\ %{}) do
      {:ok, notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_notification()

      notification
    end

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Social.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Social.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      assert {:ok, %Notification{} = notification} = Social.create_notification(@valid_attrs)
      assert notification.body == "some body"
      assert notification.notification_type == "some notification_type"
      assert notification.requested_idea_id == 42
      assert notification.title == "some title"
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      assert {:ok, notification} = Social.update_notification(notification, @update_attrs)
      assert %Notification{} = notification
      assert notification.body == "some updated body"
      assert notification.notification_type == "some updated notification_type"
      assert notification.requested_idea_id == 43
      assert notification.title == "some updated title"
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_notification(notification, @invalid_attrs)
      assert notification == Social.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Social.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Social.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Social.change_notification(notification)
    end
  end
end
