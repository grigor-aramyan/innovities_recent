defmodule Innovities.MessagingTest do
  use Innovities.DataCase

  alias Innovities.Messaging

  describe "messages" do
    alias Innovities.Messaging.Message

    @valid_attrs %{body: "some body", from: 42, receiver_is_organization: true, red: true, sender_is_organization: true, to: 42}
    @update_attrs %{body: "some updated body", from: 43, receiver_is_organization: false, red: false, sender_is_organization: false, to: 43}
    @invalid_attrs %{body: nil, from: nil, receiver_is_organization: nil, red: nil, sender_is_organization: nil, to: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messaging.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Messaging.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Messaging.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Messaging.create_message(@valid_attrs)
      assert message.body == "some body"
      assert message.from == 42
      assert message.receiver_is_organization == true
      assert message.red == true
      assert message.sender_is_organization == true
      assert message.to == 42
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messaging.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, message} = Messaging.update_message(message, @update_attrs)
      assert %Message{} = message
      assert message.body == "some updated body"
      assert message.from == 43
      assert message.receiver_is_organization == false
      assert message.red == false
      assert message.sender_is_organization == false
      assert message.to == 43
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Messaging.update_message(message, @invalid_attrs)
      assert message == Messaging.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Messaging.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Messaging.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Messaging.change_message(message)
    end
  end
end
