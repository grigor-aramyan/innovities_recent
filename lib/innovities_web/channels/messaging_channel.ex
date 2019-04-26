defmodule InnovitiesWeb.MessagingChannel do
  use InnovitiesWeb, :channel

  import Ecto.Query, only: [from: 2]

  alias Innovities.Repo
  alias Innovities.Auth
  alias Innovities.Auth.Token
  alias Innovities.Messaging
  alias Innovities.Messaging.Message
  alias Innovities.Accounts
  alias Innovities.Accounts.{Innovator, Organization}


  def join("messaging:general", _params, socket) do
    {:ok, socket}
  end

  def handle_in("tst_msg", %{"msg" => msg} = _params, socket) do
    broadcast socket, "tst_event", %{
      msg: msg
    }

    {:reply, :ok, socket}
  end

  def handle_in("mark_incoming_message_as_red", %{"message_id" => id, "token" => token} = _params, socket) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            case Messaging.get_message!(id) do
              m = %Message{} ->
                q =
                  from msg in Message,
                    where: msg.from == ^m.from and msg.receiver_is_organization == ^m.receiver_is_organization and msg.sender_is_organization == ^m.sender_is_organization and msg.to == ^m.to and msg.red == false

                case Repo.update_all(q, set: [red: true]) do
                  {_, _} ->
                    push socket, "success_marking_incoming_message_as_red", %{sucess: "Sucess"}
                  _ ->
                    push socket, "error_marking_incoming_message_as_red", %{error: "Can't update msgs"}
                end
              _ ->
                push socket, "error_marking_incoming_message_as_red", %{error: "Can't find msg"}
            end
          _ ->
            push socket, "error_marking_incoming_message_as_red", %{error: "Can't find token"}
        end
    end

    {:reply, :ok, socket}
  end

  def handle_in("mark_chat_message_as_red", %{"message_id" => id, "token" => token} = _params, socket) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            case Messaging.get_message!(id) do
              m = %Message{} ->
                q =
                  from msg in Message,
                    where: msg.from == ^m.from and msg.receiver_is_organization == ^m.receiver_is_organization and msg.sender_is_organization == ^m.sender_is_organization and msg.to == ^m.to and msg.red == false

                case Repo.update_all(q, set: [red: true]) do
                  {_, _} ->
                    if m.sender_is_organization do
                      case Accounts.get_organization!(m.from) do
                        org = %Organization{} ->
                          push socket, "success_marking_message_as_red", %{
                            message_id: m.id,
                            receiver_id: m.from,
                            receiver_is_org: m.sender_is_organization,
                            receiver_name: org.name
                          }
                        _ ->
                          push socket, "error_marking_message_as_red", %{error: "Can't find sender org"}
                      end
                    else
                      case Accounts.get_innovator!(m.from) do
                        inn = %Innovator{} ->
                          push socket, "success_marking_message_as_red", %{
                            message_id: m.id,
                            receiver_id: m.from,
                            receiver_is_org: m.sender_is_organization,
                            receiver_name: inn.full_name
                          }
                        _ ->
                          push socket, "error_marking_message_as_red", %{error: "Can't find sender inno"}
                      end
                    end
                  _ ->
                    push socket, "error_marking_message_as_red", %{error: "Can't update msgs"}
                end
              _ ->
                push socket, "error_marking_message_as_red", %{error: "Can't find msg"}
            end
          _ ->
            push socket, "error_marking_message_as_red", %{error: "Can't find token"}
        end
    end

    {:reply, :ok, socket}
  end

  def handle_in("fetch_message_senders_picture", %{"id" => id, "sender_id" => sender_id, "receiver_id" => receiver_id,
    "sender_is_organization" => sender_is_org, "body" => body} = params, socket) do

      q =
        from m in Message,
          where: (m.id == ^id and m.sender_is_organization == ^sender_is_org and m.to == ^receiver_id and m.from == ^sender_id and m.body == ^body),
          limit: 1,
          select: m
      messages = Repo.all(q)

      if (length(messages) > 0) do
        case sender_is_org do
          true ->
            case Accounts.get_organization!(sender_id) do
              o = %Organization{} ->
                final_params =
                  params
                  |> Map.put("sender_picture_uri", o.logo_uri)

                push socket, "reply_with_message_senders_picture", final_params
              _ ->
                final_params =
                  params
                  |> Map.put("sender_picture_uri", "")

                push socket, "reply_with_message_senders_picture", final_params
            end
          false ->
            case Accounts.get_innovator!(sender_id) do
              i = %Innovator{} ->
                final_params =
                  params
                  |> Map.put("sender_picture_uri", i.picture_uri)

                push socket, "reply_with_message_senders_picture", final_params
              _ ->
                final_params =
                  params
                  |> Map.put("sender_picture_uri", "")

                push socket, "reply_with_message_senders_picture", final_params
            end
        end
      else
        final_params =
          params
          |> Map.put("sender_picture_uri", "")

        push socket, "reply_with_message_senders_picture", final_params
      end

      {:reply, :ok, socket}
  end

  def handle_in("new_chat_message", %{"token" => token} = params, socket) do
    final_params =
      params
      |> Map.delete("token")

      case Auth.update_token_time(token) do
        {:ok, _t = %Token{}} ->
          case Auth.find_token(token) do
            _tok = %Token{} ->
              case Messaging.create_message(final_params) do
                {:ok, m = %Message{}} ->
                  broadcast socket, "new_chat_message_submitted", %{
                    id: m.id,
                    sender_id: m.from,
                    receiver_id: m.to,
                    body: m.body,
                    sender_is_organization: m.sender_is_organization,
                    receiver_is_organization: m.receiver_is_organization,
                    inserted_at: NaiveDateTime.to_iso8601(m.inserted_at)
                  }
                {:error, _} ->
                  push socket, "new_chat_message_error", %{
                    error: "Couldn't send your message! Contact with us, please!"
                  }
              end
            _ ->
              push socket, "new_chat_message_error", %{
                error: "Unauthenticated access!"
              }
          end
      end

      {:reply, :ok, socket}
  end

end
