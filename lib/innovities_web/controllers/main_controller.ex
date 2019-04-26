defmodule InnovitiesWeb.MainController do
  use InnovitiesWeb, :controller

  import Ecto.Query, only: [from: 2]

  alias Innovities.Repo
  alias Innovities.Tarrifs
  alias Innovities.Tarrifs.{InnovatorsPlan, OrganizationsPlan}
  alias Innovities.Accounts
  alias Innovities.Accounts.{Innovator, Organization}
  alias Innovities.Auth
  alias Innovities.Auth.Token
  alias Innovities.Mailing.{Emails, Mailer}
  alias Innovities.Content
  alias Innovities.Content.{Post, Idea, Comment, Nda}
  #alias Innovities.Messaging
  alias Innovities.Messaging.Message
  alias Innovities.Social
  alias Innovities.Social.Connection
  alias Innovities.Social.Notification
  alias Innovities.Locations.Locals

  def fetch_signed_ndas(conn, %{"id" => user_id, "is_org" => user_is_org, "token" => token} = _params) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->

          user =
            if user_is_org do
              Accounts.get_organization!(user_id)
            else
              nil
            end

          ideas_count =
            case user do
              o = %Organization{} ->
                tp = Tarrifs.get_organizations_plan!(o.organizations_plan_id)
                tp.complete_ideas_count
              _ -> nil
            end

            q =
              if ideas_count == nil do
                from n in Nda,
                  where: n.recipient_id == ^user_id and n.recipient_is_org == ^user_is_org,
                  #limit: 3,
                  order_by: [desc: n.id],
                  select: n
              else
                from n in Nda,
                  where: n.recipient_id == ^user_id and n.recipient_is_org == ^user_is_org,
                  limit: ^ideas_count,
                  order_by: [desc: n.id],
                  select: n
              end
            ndas = Repo.all(q)

            o =
              ndas
              |> Enum.map(fn n ->
                current_idea = Content.get_idea!(n.idea_id)

                %{
                  idea_id: n.idea_id,
                  idea_name: current_idea.idea_name,
                  idea_industry: current_idea.industry,
                  idea_price: current_idea.price,
                  signing_date: n.signing_date
                }
              end)

            render(conn, "simple_response.json", response: %{ndas: o})
          _ ->
            render(conn, "simple_response.json", response: %{ndas: []})
        end
    end
  end

  def save_nda(conn, %{"author_id" => _author_id, "author_is_org" => _author_is_org,
    "idea_id" => _idea_id, "recipient_id" => r_id, "recipient_is_org" => r_org,
    "token" => token} = params) do

    currentDate =
      DateTime.utc_now()
      |> to_string()
      |> String.split(" ")
      |> hd()

    final_params =
      params
      |> Map.delete("token")
      |> Map.put("signing_date", currentDate)

    recipient_user =
      if r_org do
        Accounts.get_organization!(r_id)
      else
        nil
      end

    case recipient_user do
      _o = %Organization{} ->
        case Auth.update_token_time(token) do
          {:ok, _t = %Token{}} ->
            case Auth.find_token(token) do
              _tok = %Token{} ->
                case Content.create_nda(final_params) do
                  {:ok, %Nda{}} ->
                    Accounts.update_organization(recipient_user, %{complete_ideas_count: recipient_user.complete_ideas_count + 1})

                    render(conn, "simple_response.json", response: %{
                        success: "",
                        error: ""
                      })
                  _ ->
                    render(conn, "simple_response.json", response: %{
                        success: "",
                        error: "Can't save nda!"
                      })
                end
              _ ->
                render(conn, "simple_response.json", response: %{
                    success: "",
                    error: "Unauthenticated access!"
                  })
            end
        end
      _ ->
        render(conn, "simple_response.json", response: %{
            success: "",
            error: "Some weird error. Contact with us, please!"
          })
    end

  end

  def get_full_idea(conn, %{"id" => idea_id, "token" => token} = _params) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            ia = Content.get_idea!(idea_id)
            innovator = Accounts.get_innovator!(ia.innovator_id)

            o =
              %{
                id: ia.id,
                short_description: ia.short_description,
                idea_name: ia.idea_name,
                industry: ia.industry,
                tags: ia.tags,
                price: ia.price,
                picture_uris: ia.picture_uris,
                video_uri: ia.video_uri,
                innovator_id: ia.innovator_id,
                innovator_name: innovator.full_name,
                innovator_pic: innovator.picture_uri,
                long_description: ia.long_description,
                has_nda: ia.has_nda,
                is_default_nda: ia.is_default_nda,
                custom_nda: ia.custom_nda
              }

            render(conn, "simple_response.json", response: o)
          _ ->
            o =
              %{
                id: 0,
                short_description: "",
                idea_name: "",
                industry: "",
                tags: "",
                price: "",
                picture_uris: "",
                video_uri: "",
                innovator_id: 0,
                innovator_name: "",
                innovator_pic: "",
                long_description: "",
                has_nda: false,
                is_default_nda: true,
                custom_nda: ""
              }

              render(conn, "simple_response.json", response: o)
        end
    end
  end

  def accept_or_reject_full_desc_req(conn, %{"notif_id" => notif_id, "res_code" => res_code,
    "token" => token}) do
    # res_code : 0 - rejected, 1 - accepted

    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            notif = Social.get_notification!(notif_id)
            case Social.update_notification(notif, %{red: true}) do
              {:ok, n = %Notification{}} ->
                addressed_to = n.requested_from
                addressed_to_is_org = n.requested_from_is_org
                requested_from = n.addressed_to
                requested_from_is_org = n.addressed_to_is_org
                requested_idea_id = n.requested_idea_id

                idea = Content.get_idea!(requested_idea_id)

                author_is_org = requested_from_is_org
                author =
                  if author_is_org do
                    Accounts.get_organization!(requested_from)
                  else
                    Accounts.get_innovator!(requested_from)
                  end

                body =
                  cond do
                    res_code == 0 ->
                      if author_is_org do
                        "Organization #{author.name} rejected your request of idea \"#{idea.idea_name}\" full description"
                      else
                        "Innovator #{author.full_name} rejected your request of idea \"#{idea.idea_name}\" full description"
                      end
                    res_code == 1 ->
                      if author_is_org do
                        "Organization #{author.name} accepted your request of idea \"#{idea.idea_name}\" full description"
                      else
                        "Innovator #{author.full_name} accepted your request of idea \"#{idea.idea_name}\" full description"
                      end
                  end

                notif_type =
                  cond do
                    res_code == 0 -> "DESC_REQ_REJECTED"
                    res_code == 1 -> "DESC_REQ_ACCEPTED"
                  end

                title =
                  cond do
                    res_code == 0 -> "Full Description Request Rejected"
                    res_code == 1 -> "Full Description Request Accepted"
                  end

                  final_params =
                    %{
                      body: body,
                      notification_type: notif_type,
                      requested_idea_id: requested_idea_id,
                      title: title,
                      addressed_to: addressed_to,
                      addressed_to_is_org: addressed_to_is_org,
                      requested_from: requested_from,
                      requested_from_is_org: requested_from_is_org
                    }

                  case Social.create_notification(final_params) do
                    {:ok, _nn = %Notification{}} ->
                      render(conn, "simple_response.json", response: %{
                          success: "#{n.id}",
                          error: ""
                        })
                    _ ->
                      render(conn, "simple_response.json", response: %{
                          success: "",
                          error: "Can't create accept/reject notif!"
                        })
                  end
              _ ->
                render(conn, "simple_response.json", response: %{
                    success: "",
                    error: "Server-side error!"
                  })
            end
          _ ->
            render(conn, "simple_response.json", response: %{
                success: "",
                error: "Unauthenticated access!"
              })
        end
    end

  end

  def create_full_desc_req_notification(conn, %{"notification_type_code" => notification_type_code,
    "requested_idea_id" => idea_id, "addressed_to" => receiver_id, "addressed_to_is_org" => receiver_is_org,
    "requested_from" => reqed_from, "requested_from_is_org" => reqed_is_org, "token" => token} = params) do

      remaining_ideas =
        case Accounts.check_subscription(reqed_from, reqed_is_org) do
          {:ok, ri, _rc, _r_scheme, _rg} -> ri
          _ -> 0
        end

      if remaining_ideas > 0 do
        idea =
          Content.get_idea!(idea_id)

        reqed_user =
          if reqed_is_org do
            Accounts.get_organization!(reqed_from)
          else
            Accounts.get_innovator!(reqed_from)
          end

        complete_desc_req_body =
          if reqed_is_org do
            "Organization #{reqed_user.name} requested full description of your idea \"#{idea.idea_name}\""
          else
            "Innovator #{reqed_user.full_name} requested full description of your idea \"#{idea.idea_name}\""
          end

        desc_req_accepted_body =
          if reqed_is_org do
            "Organization #{reqed_user.name} accepted your request of full description of \"#{idea.idea_name}\" idea"
          else
            "Innovator #{reqed_user.full_name} accepted your request of full description of \"#{idea.idea_name}\" idea"
          end

          desc_req_rejected_body =
            if reqed_is_org do
              "Organization #{reqed_user.name} rejected your request of full description of \"#{idea.idea_name}\" idea"
            else
              "Innovator #{reqed_user.full_name} rejected your request of full description of \"#{idea.idea_name}\" idea"
            end

        notification_type =
          cond do
            notification_type_code == 0 -> "COMPLETE_DESC_REQ"
            notification_type_code == 1 -> "DESC_REQ_ACCEPTED"
            notification_type_code == 2 -> "DESC_REQ_REJECTED"
          end

          notification_title =
            cond do
              notification_type_code == 0 -> "Full Description Request"
              notification_type_code == 1 -> "Full Description Request Accepted"
              notification_type_code == 2 -> "Full Description Request Rejected"
            end

            notification_body =
              cond do
                notification_type_code == 0 -> complete_desc_req_body
                notification_type_code == 1 -> desc_req_accepted_body
                notification_type_code == 2 -> desc_req_rejected_body
              end

        final_params =
          params
          |> Map.delete("token")
          |> Map.delete("notification_type_code")
          |> Map.put("notification_type", notification_type)
          |> Map.put("title", notification_title)
          |> Map.put("body", notification_body)

        case Auth.update_token_time(token) do
          {:ok, _t = %Token{}} ->
            case Auth.find_token(token) do
              _tok = %Token{} ->
                q =
                  from n in Notification,
                    where: n.notification_type == ^notification_type and n.requested_idea_id == ^idea_id and n.addressed_to == ^receiver_id and n.addressed_to_is_org == ^receiver_is_org and n.requested_from == ^reqed_from and n.requested_from_is_org == ^reqed_is_org,
                    #order_by: [desc: c.id],
                    select: n
                notifs = Repo.all(q)

                if (length(notifs) > 0) do
                  render(conn, "simple_response.json", response: %{
                      success: "",
                      error: "Already requested!"
                    })
                else
                  case Social.create_notification(final_params) do
                    {:ok, _nn = %Notification{}} ->
                      render(conn, "simple_response.json", response: %{
                          success: "",
                          error: ""
                        })
                    {:error, _ch = %Ecto.Changeset{}} ->
                      render(conn, "simple_response.json", response: %{
                          success: "",
                          error: "Can't create request! Try later, please."
                        })
                  end
                end
              _ ->
                render(conn, "simple_response.json", response: %{
                    success: "",
                    error: "Unauthenticated access!"
                  })
            end
        end
      else
        render(conn, "simple_response.json", response: %{
            success: "",
            error: "Error or ideas limit reached!"
          })
      end

  end

  def check_connection_and_connect(conn, %{"sender_id" => sender_id, "sender_is_organization" => sender_is_org,
    "receiver_id" => receiver_id, "receiver_is_organization" => receiver_is_org,
    "token" => token} = params) do

      final_params =
        params
        |> Map.delete("token")

      remaining_connections =
        case Accounts.check_subscription(sender_id, sender_is_org) do
          {:ok, _ri, rc, _r_scheme, _region} -> rc
          _ -> 0
        end

      if remaining_connections > 0 do
        case Auth.update_token_time(token) do
          {:ok, _t = %Token{}} ->
            case Auth.find_token(token) do
              _tok = %Token{} ->
                q =
                  from c in Connection,
                    where: c.receiver_id == ^receiver_id and c.receiver_is_organization == ^receiver_is_org and c.sender_id == ^sender_id and c.sender_is_organization == ^sender_is_org,
                    #order_by: [desc: c.id],
                    select: c
                connections = Repo.all(q)

                if (length(connections) == 0) do
                  case Social.create_connection(final_params) do
                    {:ok, _conn = %Connection{}} ->
                      render(conn, "simple_response.json", response: %{
                          success: "#{receiver_id}",
                          error: "#{receiver_is_org}"
                        })
                    _ ->
                      render(conn, "simple_response.json", response: %{
                          success: "",
                          error: "Can't create connection!"
                        })
                  end
                else
                  render(conn, "simple_response.json", response: %{
                      success: "#{receiver_id}",
                      error: "#{receiver_is_org}"
                    })
                end
              _ ->
                render(conn, "simple_response.json", response: %{
                    success: "",
                    error: "Unauthenticated access!"
                  })
            end
        end
      else
        render(conn, "simple_response.json", response: %{
            success: "",
            error: "Error or connections limit reached!"
          })
      end

  end

  def process_search(conn, %{"query" => query, "token" => token,
    "user_id" => user_id, "user_is_org" => user_is_org} = _params) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
          user =
            if user_is_org do
              Accounts.get_organization!(user_id)
            else
              Accounts.get_innovator!(user_id)
            end

          {region_scheme, user_region} =
            case user do
              _i = %Innovator{} ->
                tp =
                  Tarrifs.get_innovators_plan!(user.innovators_plan_id)

                case tp.region do
                  "Current country" ->
                    {tp.region, user.country}
                  "Current region" ->
                    {tp.region, user.region}
                  "Current continent" ->
                    {tp.region, user.continent}
                  "Worldwide" ->
                    {"Worldwide", "Worldwide"}
                end
              _o = %Organization{} ->
                tp =
                  Tarrifs.get_organizations_plan!(user.organizations_plan_id)
                case tp.region do
                  "Current country" ->
                    {tp.region, user.country}
                  "Current region" ->
                    {tp.region, user.region}
                  "Current continent" ->
                    {tp.region, user.continent}
                  "Worldwide" ->
                    {"Worldwide", "Worldwide"}
                end
              _ ->
                {"Current country", "Armenia"}
            end

            q =
              case region_scheme do
                "Current country" ->
                  from i in Innovator,
                    where: i.country == ^user_region,
                    select: i
                "Current region" ->
                  from i in Innovator,
                    where: i.region == ^user_region,
                    select: i
                "Current continent" ->
                  from i in Innovator,
                    where: i.continent == ^user_region,
                    select: i
                "Worldwide" ->
                  from i in Innovator,
                    where: i.id > 0,
                    select: i
              end


          innovators_all = Repo.all(q)
          innovators_searched =
            innovators_all
            |> Enum.filter(fn i ->
              if (String.contains?(i.full_name, query) or String.contains?(i.description, query)
                or String.contains?(i.about_me, query) or String.contains?(i.education, query)
                or String.contains?(i.experience, query) or String.contains?(i.username, query)) do
                true
              else
                false
              end
            end)
            |> Enum.map(fn i ->
              q =
                from c in Connection,
                  where: (c.receiver_id == ^i.id and c.receiver_is_organization == false) or (c.sender_id == ^i.id and c.sender_is_organization == false),
                  select: c
              connections = Repo.all(q)

              %{
                id: i.id,
                name: i.full_name,
                pic_uri: i.picture_uri,
                rating: i.rating,
                country: i.country,
                email: i.email,
                ideas_count: i.generated_ideas_count,
                innovators_plan_id: i.innovators_plan_id,
                description: i.description,
                about_me: i.about_me,
                education: i.education,
                experience: i.experience,
                username: i.username,
                phone: i.phone,
                connections_count: length(connections)
              }
            end)

            q2 =
              case region_scheme do
                "Current country" ->
                  from o in Organization,
                    where: o.country == ^user_region,
                    select: o
                "Current region" ->
                  from o in Organization,
                    where: o.region == ^user_region,
                    select: o
                "Current continent" ->
                  from o in Organization,
                    where: o.continent == ^user_region,
                    select: o
                "Worldwide" ->
                  from o in Organization,
                    where: o.id > 0,
                    select: o
              end

          organizations_all = Repo.all(q2)
          organizations_searched =
            organizations_all
            |> Enum.filter(fn o ->
              if (String.contains?(o.name, query) or String.contains?(o.description, query)
                or String.contains?(o.about_us, query) or String.contains?(o.industry, query)
                or String.contains?(o.interested_industries, query) or String.contains?(o.username, query)) do
                true
              else
                false
              end
            end)
            |> Enum.map(fn ow ->
              q =
                from c in Connection,
                  where: (c.receiver_id == ^ow.id and c.receiver_is_organization == true) or (c.sender_id == ^ow.id and c.sender_is_organization == true),
                  select: c
              connections = Repo.all(q)

              %{
                id: ow.id,
                name: ow.name,
                pic_uri: ow.logo_uri,
                country: ow.country,
                email: ow.email,
                complete_ideas_count: 0,
                organizations_plan_id: ow.organizations_plan_id,
                description: ow.description,
                webpage: ow.webpage,
                about_us: ow.about_us,
                industry: ow.industry,
                interested_industries: ow.interested_industries,
                username: ow.username,
                phone: ow.phone,
                rating: ow.rating,
                connections_count: length(connections)
              }
            end)

          ideas_all = Content.list_ideas
          ideas_searched =
            ideas_all
            |> Enum.filter(fn ia ->
              if ((String.contains?(ia.short_description, query) or String.contains?(ia.idea_name, query)
                or String.contains?(ia.industry, query) or String.contains?(ia.tags, query))
                and (ia.organization_id == nil)) do
                true
              else
                false
              end
            end)
            |> Enum.map(fn ia ->
              innovator = Accounts.get_innovator!(ia.innovator_id)

              %{
                id: ia.id,
                short_description: ia.short_description,
                idea_name: ia.idea_name,
                industry: ia.industry,
                tags: ia.tags,
                price: ia.price,
                picture_uris: ia.picture_uris,
                video_uri: ia.video_uri,
                innovator_id: ia.innovator_id,
                innovator_name: innovator.full_name,
                innovator_pic: innovator.picture_uri
              }
            end)

          posts_all = Content.list_posts()
          posts_searched =
            posts_all
            |> Enum.filter(fn p ->
              if (String.contains?(p.message, query)) do
                true
              else
                false
              end
            end)
            |> Enum.map(fn p ->

                author_is_org =
                  if p.innovator_id == nil do
                    true
                  else
                    false
                  end

                author =
                  if author_is_org do
                    case Accounts.get_organization!(p.organization_id) do
                      a_o = %Organization{} ->
                        a_o
                      _ ->
                        nil
                    end
                  else
                    case Accounts.get_innovator!(p.innovator_id) do
                      a_i = %Innovator{} ->
                        a_i
                      _ ->
                        nil
                    end
                  end

                  author_name =
                    if author_is_org do
                      author.name
                    else
                      author.full_name
                    end

                    author_pic =
                      if author_is_org do
                        author.logo_uri
                      else
                        author.picture_uri
                      end


              %{
                author_name: author_name,
                author_desc: author.description,
                author_pic: author_pic,
                author_id: author.id,
                post_id: p.id,
                post_media_file: p.media_file_uri,
                post_message: p.message,
                post_likes: p.likes
              }
            end)

            render(conn, "simple_response.json", response: %{
                innovators: innovators_searched,
                organizations: organizations_searched,
                ideas: ideas_searched,
                posts: posts_searched
              })
          _ ->
            render(conn, "simple_response.json", response: %{
                innovators: [],
                organizations: [],
                ideas: [],
                posts: []
              })
        end
    end
  end

  def fetch_comments(conn, %{"id" => post_id, "token" => token} = _params) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            q =
              from c in Comment,
                where: c.post_id == ^post_id,
                #order_by: [desc: c.id],
                select: c
            comms = Repo.all(q)

            o =
              comms
              |> Enum.map(fn c ->
                %{
                    author_id: c.author_id,
                    author_is_org: c.author_is_org,
                    author_name: c.author_name,
                    body: c.body,
                    input_date: c.input_date,
                    post_id: c.post_id,
                    token: ""
                  }
              end)

            render(conn, "simple_response.json", response: %{comments: o})
          _ ->
            render(conn, "simple_response.json", response: %{comments: []})
        end
    end
  end

  def create_comment(conn, %{"author_id" => ai, "author_is_org" => aio,
    "body" => _b, "post_id" => _pi, "token" => token} = params) do
    author =
      if aio do
        Accounts.get_organization!(ai)
      else
        Accounts.get_innovator!(ai)
      end

    author_name =
      if aio do
        author.name
      else
        author.full_name
      end

    final_params =
      params
      |> Map.delete("token")
      |> Map.put("author_name", author_name)
      |> Map.put("input_date", Date.to_string(DateTime.utc_now()))

      case Auth.update_token_time(token) do
        {:ok, _t = %Token{}} ->
          case Auth.find_token(token) do
            _tok = %Token{} ->
              case Content.create_comment(final_params) do
                {:ok, comm = %Comment{}} ->
                  render(conn, "simple_response.json", response: %{
                      author_id: comm.author_id,
                      author_is_org: comm.author_is_org,
                      author_name: comm.author_name,
                      body: comm.body,
                      input_date: comm.input_date,
                      post_id: comm.post_id,
                      token: ""
                    })
                {:error, _} ->
                  render(conn, "simple_response.json", response: %{
                      author_id: 0,
                      author_is_org: false,
                      author_name: "",
                      body: "",
                      input_date: "",
                      post_id: 0,
                      token: ""
                    })
              end
            _ ->
              render(conn, "simple_response.json", response: %{
                  author_id: 0,
                  author_is_org: false,
                  author_name: "",
                  body: "",
                  input_date: "",
                  post_id: 0,
                  token: ""
                })
          end
      end
  end

  def like_post(conn, %{"id" => post_id, "token" => token} = _params) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            case Content.get_post!(post_id) do
              p = %Post{} ->
                case Content.update_post(p, %{likes: p.likes + 1}) do
                  {:ok, ps = %Post{}} ->
                    render(conn, "simple_response.json", response: %{
                        success: to_string(ps.id),
                        error: ""
                      })
                  _ ->
                    render(conn, "simple_response.json", response: %{
                        success: "",
                        error: "Couldn't update your data!"
                      })
                end
              _ ->
                render(conn, "simple_response.json", response: %{
                    success: "",
                    error: "Couldn't find your data!"
                  })
            end
          _ ->
            render(conn, "simple_response.json", response: %{
                success: "",
                error: "Unauthenticated access!"
              })
        end
    end
  end

  def fetch_unred_notifs(conn, %{"receiver_id" => id, "receiver_is_org" => is_org, "token" => token}) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            q =
              from n in Notification,
                where: n.addressed_to == ^id and n.addressed_to_is_org == ^is_org and n.red == false,
                order_by: [desc: n.id],
                select: n
            notifs = Repo.all(q)

            o =
              notifs
              |> Enum.map(fn n ->
                %{ id: n.id,
                  title: n.title,
                  body: n.body,
                  notificationType: n.notification_type,
                  requestedIdeaId: n.requested_idea_id
                }
              end)

            render(conn, "simple_response.json", response: %{notifications: o})
          _ ->
            render(conn, "simple_response.json", response: %{notifications: []})
        end
    end
  end

  def mark_notif_as_red(conn, %{"id" => notif_id, "token" => token} = _params) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            case Social.get_notification!(notif_id) do
              n = %Notification{} ->
                case Social.update_notification(n, %{red: true}) do
                  {:ok, notif = %Notification{}} ->
                    render(conn, "simple_response.json", response: %{
                        success: to_string(notif.id),
                        error: ""
                      })
                  {:error, _} ->
                    render(conn, "simple_response.json", response: %{
                        success: "",
                        error: "Unable to update notification!"
                      })
                end
              _ ->
                render(conn, "simple_response.json", response: %{
                    success: "",
                    error: "Unable to find notification!"
                  })
            end
          _ ->
            render(conn, "simple_response.json", response: %{
                success: "",
                error: "Unauthenticated access!"
              })
        end
    end
  end

  def subscribe_tariff_plan(conn, %{"id" => id, "is_organization" => is_org,
    "tariff_plan_name" => tp_name, "token" => token} = _params) do

    tariff_plan_id =
      if is_org do
        case Repo.get_by(OrganizationsPlan, name: tp_name) do
          tp = %OrganizationsPlan{} ->
            tp.id
          _ ->
            0
        end
      else
        case Repo.get_by(InnovatorsPlan, name: tp_name) do
          tp = %InnovatorsPlan{} ->
            tp.id
          _ ->
            0
        end
      end

    update_map =
      if is_org do
        %{
          organizations_plan_id: tariff_plan_id,
          tariff_subscription_date: Date.to_string(DateTime.utc_now()),
          tariff_expiry_date: Date.to_string(Timex.shift(Timex.now(), days: 30))
        }
      else
        %{
          innovators_plan_id: tariff_plan_id,
          tariff_subscription_date: Date.to_string(DateTime.utc_now()),
          tariff_expiry_date: Date.to_string(Timex.shift(Timex.now(), days: 30))
        }
      end

    if (tariff_plan_id == 0) do
      render(conn, "simple_response.json", response: %{
          success: "",
          error: "Unexpected error! Contact with us, please"
        })
    else
      case Auth.update_token_time(token) do
        {:ok, _t = %Token{}} ->
          case Auth.find_token(token) do
            _tok = %Token{} ->
              if is_org do
                case Accounts.get_organization!(id) do
                  o = %Organization{} ->
                    case Accounts.update_organization(o, update_map) do
                      {:ok, _oq = %Organization{}} ->
                        render(conn, "simple_response.json", response: %{
                            success: "True",
                            error: ""
                          })
                      _ ->
                        render(conn, "simple_response.json", response: %{
                            success: "",
                            error: "Can't update your data! Contact with us, please!"
                          })
                    end
                  _ ->
                    render(conn, "simple_response.json", response: %{
                        success: "",
                        error: "Can't find your data! Contact with us, please!"
                      })
                end
              else
                case Accounts.get_innovator!(id) do
                  i = %Innovator{} ->
                    case Accounts.update_innovator(i, update_map) do
                      {:ok, _in = %Innovator{}} ->
                        render(conn, "simple_response.json", response: %{
                            success: "True",
                            error: ""
                          })
                      _ ->
                        render(conn, "simple_response.json", response: %{
                            success: "",
                            error: "Can't update your data! Contact with us, please!"
                          })
                    end
                  _ ->
                    render(conn, "simple_response.json", response: %{
                        success: "",
                        error: "Can't find your data! Contact with us, please!"
                      })
                end
              end
            _ ->
              render(conn, "simple_response.json", response: %{
                  success: "",
                  error: "Unauthenticated access!"
                })
          end
      end
    end

  end

  def update_organization_settings(conn, %{"id" => id, "token" => token} = params) do

    final_params =
      params
      |> Map.delete("id")
      |> Map.delete("token")

      case Auth.update_token_time(token) do
        {:ok, _t = %Token{}} ->
          case Auth.find_token(token) do
            _tok = %Token{} ->
              case Accounts.get_organization!(id) do
                o = %Organization{} ->
                  case Accounts.update_organization(o, final_params) do
                    {:ok, ow = %Organization{}} ->
                      q =
                       from c in Connection,
                         where: (c.receiver_id == ^ow.id and c.receiver_is_organization == true) or (c.sender_id == ^ow.id and c.sender_is_organization == true),
                         select: c
                     connections = Repo.all(q)

                      render(conn, InnovitiesWeb.OrganizationView, "organization_extended.json", organization: %Organization{
                        id: ow.id,
                        name: ow.name,
                        logo_uri: ow.logo_uri,
                        country: ow.country,
                        email: ow.email,
                        complete_ideas_count: 0,
                        organizations_plan_id: ow.organizations_plan_id,
                        description: ow.description,
                        webpage: ow.webpage,
                        about_us: ow.about_us,
                        industry: ow.industry,
                        interested_industries: ow.interested_industries,
                        username: ow.username,
                        phone: ow.phone,
                        rating: ow.rating,
                      }, connections_count: length(connections), token: "")
                    _ ->
                      render(conn, InnovitiesWeb.OrganizationView, "organization_extended.json", organization: %Organization{
                        id: 0,
                        name: "",
                        logo_uri: "",
                        country: "",
                        email: "",
                        complete_ideas_count: 0,
                        organizations_plan_id: 0,
                        description: "",
                        webpage: "",
                        about_us: "",
                        industry: "Couldn't update your data! Contact with us, please.",
                        interested_industries: "",
                        username: "",
                        phone: "",
                        rating: 0
                      }, connections_count: 0, token: "")
                  end
                _ ->
                  render(conn, InnovitiesWeb.OrganizationView, "organization_extended.json", organization: %Organization{
                    id: 0,
                    name: "",
                    logo_uri: "",
                    country: "",
                    email: "",
                    complete_ideas_count: 0,
                    organizations_plan_id: 0,
                    description: "",
                    webpage: "",
                    about_us: "",
                    industry: "Couldn't find your data! Contact with us, please.",
                    interested_industries: "",
                    username: "",
                    phone: "",
                    rating: 0
                  }, connections_count: 0, token: "")
              end
            _ ->
              render(conn, InnovitiesWeb.OrganizationView, "organization_extended.json", organization: %Organization{
                id: 0,
                name: "",
                logo_uri: "",
                country: "",
                email: "",
                complete_ideas_count: 0,
                organizations_plan_id: 0,
                description: "",
                webpage: "",
                about_us: "",
                industry: "Unauthenticated access!",
                interested_industries: "",
                username: "",
                phone: "",
                rating: 0
              }, connections_count: 0, token: "")
          end
      end
  end

  def update_innovator_settings(conn, %{"id" => id, "token" => token} = params) do

    final_params =
      params
      |> Map.delete("id")
      |> Map.delete("token")

      case Auth.update_token_time(token) do
        {:ok, _t = %Token{}} ->
          case Auth.find_token(token) do
            _tok = %Token{} ->
              case Accounts.get_innovator!(id) do
                inn = %Innovator{} ->
                  case Accounts.update_innovator(inn, final_params) do
                    {:ok, i = %Innovator{}} ->
                      q =
                       from c in Connection,
                         where: (c.receiver_id == ^i.id and c.receiver_is_organization == false) or (c.sender_id == ^i.id and c.sender_is_organization == false),
                         #limit: 30,
                         #order_by: [desc: p.id],
                         select: c
                     connections = Repo.all(q)

                      render(conn, InnovitiesWeb.InnovatorView, "innovator_extended.json", innovator: %Innovator{
                        id: i.id,
                        full_name: i.full_name,
                        picture_uri: i.picture_uri,
                        rating: i.rating,
                        country: i.country,
                        email: i.email,
                        generated_ideas_count: i.generated_ideas_count,
                        innovators_plan_id: i.innovators_plan_id,
                        description: i.description,
                        about_me: i.about_me,
                        education: i.education,
                        experience: i.experience,
                        username: i.username,
                        phone: i.phone
                    }, connections_count: length(connections), token: "")
                    _ ->
                      render(conn, InnovitiesWeb.InnovatorView, "innovator_extended.json", innovator: %Innovator{
                        id: 0,
                        full_name: "",
                        picture_uri: "",
                        rating: 0,
                        country: "",
                        email: "",
                        generated_ideas_count: 0,
                        innovators_plan_id: 0,
                        description: "",
                        about_me: "",
                        education: "",
                        experience: "Couldn't update your data! Contact with us, please.",
                        username: "",
                        phone: ""
                    }, connections_count: 0, token: "")
                  end
                _ ->
                  render(conn, InnovitiesWeb.InnovatorView, "innovator_extended.json", innovator: %Innovator{
                    id: 0,
                    full_name: "",
                    picture_uri: "",
                    rating: 0,
                    country: "",
                    email: "",
                    generated_ideas_count: 0,
                    innovators_plan_id: 0,
                    description: "",
                    about_me: "",
                    education: "",
                    experience: "Couldn't find your data! Contact with us, please.",
                    username: "",
                    phone: ""
                }, connections_count: 0, token: "")
              end
            _ ->
              render(conn, InnovitiesWeb.InnovatorView, "innovator_extended.json", innovator: %Innovator{
                id: 0,
                full_name: "",
                picture_uri: "",
                rating: 0,
                country: "",
                email: "",
                generated_ideas_count: 0,
                innovators_plan_id: 0,
                description: "",
                about_me: "",
                education: "",
                experience: "Unauthenticated access!",
                username: "",
                phone: ""
            }, connections_count: 0, token: "")
          end
      end
  end

  def make_connection(conn, %{"token" => token, "sender_id" => sender_id,
    "sender_is_organization" => sender_is_org, "receiver_id" => receiver_id,
    "receiver_is_organization" => receiver_is_org} = params) do
    final_params =
      params
      |> Map.delete("token")

    sender_user =
      if sender_is_org do
        Accounts.get_organization!(sender_id)
      else
        Accounts.get_innovator!(sender_id)
      end

    receiver_user =
      if receiver_is_org do
        Accounts.get_organization!(receiver_id)
      else
        Accounts.get_innovator!(receiver_id)
      end

    remaining_connections =
      case Accounts.check_subscription(sender_id, sender_is_org) do
        {:ok, _ri, rc, _rsh, _r} -> rc
        {:ok, :expired} -> 0
        {:error, _} -> 0
      end

      remaining_connections_2 =
        case Accounts.check_subscription(receiver_id, receiver_is_org) do
          {:ok, _ri, rc, _rsh, _r} -> rc
          {:ok, :expired} -> 0
          {:error, _} -> 0
        end

      if ((remaining_connections > 0) and (remaining_connections_2 > 0)) do
        case Auth.update_token_time(token) do
          {:ok, _t = %Token{}} ->
            case Auth.find_token(token) do
              _tok = %Token{} ->
                case Social.create_connection(final_params) do
                  {:ok, _c = %Connection{}} ->

                    case sender_user do
                      _i = %Innovator{} ->
                        Accounts.update_innovator(sender_user, %{organization_connection_count: sender_user.organization_connection_count + 1})
                      _o = %Organization{} ->
                        Accounts.update_organization(sender_user, %{innovator_connection_count: sender_user.innovator_connection_count + 1})
                      _ ->
                        true
                    end

                    case receiver_user do
                      _i = %Innovator{} ->
                        Accounts.update_innovator(receiver_user, %{organization_connection_count: receiver_user.organization_connection_count + 1})
                      _o = %Organization{} ->
                        Accounts.update_organization(receiver_user, %{innovator_connection_count: receiver_user.innovator_connection_count + 1})
                      _ ->
                        true
                    end

                    render(conn, "simple_response.json", response: %{
                        success: "True",
                        error: ""
                      })
                  {:error, _} ->
                    render(conn, "simple_response.json", response: %{
                        success: "",
                        error: "Couldn't create connection!"
                      })
                end
              _ ->
                render(conn, "simple_response.json", response: %{
                    success: "",
                    error: "Unauthenticated access!"
                  })
            end
        end
      else
        render(conn, "simple_response.json", response: %{
            success: "",
            error: "Error or connectios limit reached!"
          })
      end
  end

  def fetch_suggested_innovators(conn, %{"id" => organization_id, "token" => token} = _params) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            case Accounts.get_organization!(organization_id) do
              org = %Organization{} ->
                industry =
                  if ((String.trim(org.industry) |> String.length()) > 0) do
                    org.industry
                  else
                    "***"
                  end
                interested_industries_list = String.split(org.interested_industries, [", ", ","])

                ii1 =
                  if ( (length(interested_industries_list) > 0) and
                    ((String.trim(hd(interested_industries_list)) |> String.length()) > 0) ) do
                    hd(interested_industries_list)
                  else
                    "***"
                  end

                remaining1 =
                  if (length(interested_industries_list) > 0) do
                    tl(interested_industries_list)
                  else
                    []
                  end

                ii2 =
                  if ( (length(remaining1) > 0) and
                    ((String.trim(hd(remaining1)) |> String.length()) > 0) ) do
                    hd(remaining1)
                  else
                    "***"
                  end

                remaining2 =
                  if (length(remaining1) > 0) do
                    tl(remaining1)
                  else
                    []
                  end

                ii3 =
                  if ( (length(remaining2) > 0) and
                    ((String.trim(hd(remaining2)) |> String.length()) > 0) ) do
                    hd(remaining2)
                  else
                    "***"
                  end

                  {region_scheme, active_region} =
                    case Accounts.check_subscription(organization_id, true) do
                      {:ok, _ri, _rc, r_scheme, region} ->
                        {r_scheme, region}
                      {:ok, :expired} ->
                        {"Current country", org.country}
                      {:error, _} ->
                        {"error", ""}
                    end

                q =
                  case region_scheme do
                    "Current country" ->
                      from i in Innovator,
                        where: i.country == ^active_region,
                        order_by: [desc: i.rating],
                        #distinct: [msg.from, msg.sender_is_organization],
                        select: i
                    "Current region" ->
                      from i in Innovator,
                        where: i.region == ^active_region,
                        order_by: [desc: i.rating],
                        #distinct: [msg.from, msg.sender_is_organization],
                        select: i
                    "Current continent" ->
                      from i in Innovator,
                        where: i.continent == ^active_region,
                        order_by: [desc: i.rating],
                        #distinct: [msg.from, msg.sender_is_organization],
                        select: i
                    "Worldwide" ->
                      from i in Innovator,
                        #where: msg.to == ^receiver_id and msg.receiver_is_organization == ^receiver_is_org and msg.red == false,
                        order_by: [desc: i.rating],
                        #distinct: [msg.from, msg.sender_is_organization],
                        select: i
                    "error" ->
                      from i in Innovator,
                        #where: msg.to == ^receiver_id and msg.receiver_is_organization == ^receiver_is_org and msg.red == false,
                        order_by: [desc: i.rating],
                        #distinct: [msg.from, msg.sender_is_organization],
                        select: i
                  end
                innovators_initial_list = Repo.all(q)

                # industries to filter against: ii1, ii2, ii3, industry
                innovators_filtered_list =
                  innovators_initial_list
                  |> Enum.filter(fn i ->
                    String.contains?(i.description, ii1) or String.contains?(i.about_me, ii1) or String.contains?(i.education, ii1) or String.contains?(i.experience, ii1) or
                    String.contains?(i.description, ii2) or String.contains?(i.about_me, ii2) or String.contains?(i.education, ii2) or String.contains?(i.experience, ii2) or
                    String.contains?(i.description, ii3) or String.contains?(i.about_me, ii3) or String.contains?(i.education, ii3) or String.contains?(i.experience, ii3) or
                    String.contains?(i.description, industry) or String.contains?(i.about_me, industry) or String.contains?(i.education, industry) or String.contains?(i.experience, industry)
                  end)
                  |> Enum.filter(fn i ->
                    !(Accounts.connected?(org.id, i.id))
                  end)
                  |> Enum.slice(0..2)

                innovators_final_list =
                  cond do
                    (length(innovators_filtered_list) == 3) ->
                      innovators_filtered_list
                    (length(innovators_filtered_list) == 0) ->
                      innovators_initial_list
                      |> Enum.filter(fn i ->
                        !(Accounts.connected?(org.id, i.id))
                      end)
                      |> Enum.slice(0..2)
                    (length(innovators_filtered_list) < 3) ->
                      innovators_initial_list
                      |> Enum.filter(fn i ->
                        !(Accounts.connected?(org.id, i.id))
                      end)
                      |> (&(Enum.slice(&1, 0..(2 - length(innovators_filtered_list))))).()
                      |> (&(innovators_filtered_list ++ &1)).()
                  end

                o =
                  innovators_final_list
                  |> Enum.map(fn i ->
                    %{
                      id: i.id,
                      name: i.full_name,
                      description: i.description,
                      picture: i.picture_uri,
                    }
                  end)
                render(conn, "simple_response.json", response: %{suggestions: o})
              _ ->
                render(conn, "simple_response.json", response: %{suggestions: []})
            end
          _ ->
            render(conn, "simple_response.json", response: %{suggestions: []})
        end
    end
  end


  def fetch_suggested_companies(conn, %{"id" => innovator_id, "token" => token} = _params) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            case Accounts.get_innovator!(innovator_id) do
              inn = %Innovator{} ->

                {region_scheme, active_region} =
                  case Accounts.check_subscription(innovator_id, false) do
                    {:ok, _ri, _rc, r_scheme, region} ->
                      {r_scheme, region}
                    {:ok, :expired} ->
                      {"Current country", inn.country}
                    {:error, _} ->
                      {"error", ""}
                  end

                q =
                  case region_scheme do
                    "Current country" ->
                      from o in Organization,
                        where: o.country == ^active_region,
                        order_by: [desc: o.rating],
                        #distinct: [msg.from, msg.sender_is_organization],
                        select: o
                    "Current region" ->
                      from o in Organization,
                        where: o.region == ^active_region,
                        order_by: [desc: o.rating],
                        #distinct: [msg.from, msg.sender_is_organization],
                        select: o
                    "Current continent" ->
                      from o in Organization,
                        where: o.continent == ^active_region,
                        order_by: [desc: o.rating],
                        #distinct: [msg.from, msg.sender_is_organization],
                        select: o
                    "Worldwide" ->
                      from o in Organization,
                        #where: o.continent == ^active_region,
                        order_by: [desc: o.rating],
                        #distinct: [msg.from, msg.sender_is_organization],
                        select: o
                    "error" ->
                      from o in Organization,
                        #where: o.continent == ^active_region,
                        order_by: [desc: o.rating],
                        #distinct: [msg.from, msg.sender_is_organization],
                        select: o
                  end
                organizations_initial_list = Repo.all(q)

                # innovator values to compare against for finding suggestions
                desc = inn.description
                about_me = inn.about_me
                edu = inn.education
                exp = inn.experience
                comparison_map = %{
                  desc: desc,
                  about_me: about_me,
                  edu: edu,
                  exp: exp
                }

                organizations_filtered_list =
                  organizations_initial_list
                  |> Enum.filter(fn o ->
                    innovator_info_contains?(comparison_map, o)
                  end)
                  |> Enum.filter(fn o ->
                    !(Accounts.connected?(o.id, inn.id))
                  end)
                  |> Enum.slice(0..2)

                  organizations_final_list =
                    cond do
                      (length(organizations_filtered_list) == 3) ->
                        organizations_filtered_list
                      (length(organizations_filtered_list) == 0) ->
                        organizations_initial_list
                        |> Enum.filter(fn o ->
                          !(Accounts.connected?(o.id, inn.id))
                        end)
                        |> Enum.slice(0..2)
                      (length(organizations_filtered_list) < 3) ->
                        organizations_initial_list
                        |> Enum.filter(fn o ->
                          !(Accounts.connected?(o.id, inn.id))
                        end)
                        |> (&(Enum.slice(&1, 0..(2 - length(organizations_filtered_list))))).()
                        |> (&(organizations_filtered_list ++ &1)).()
                    end

                o =
                  organizations_final_list
                  |> Enum.map(fn o ->
                    %{
                      id: o.id,
                      name: o.name,
                      description: o.description,
                      picture: o.logo_uri,
                    }
                  end)
                render(conn, "simple_response.json", response: %{suggestions: o})
              _ ->
                render(conn, "simple_response.json", response: %{suggestions: []})
            end
          _ ->
            render(conn, "simple_response.json", response: %{suggestions: []})
        end
    end
  end

  def fetch_unred_messages(conn, %{"receiver_id" => receiver_id, "receiver_is_org" => receiver_is_org,
    "token" => token}) do

      case Auth.update_token_time(token) do
        {:ok, _t = %Token{}} ->
          case Auth.find_token(token) do
            _tok = %Token{} ->
              q =
                from msg in Message,
                  where: msg.to == ^receiver_id and msg.receiver_is_organization == ^receiver_is_org and msg.red == false,
                  order_by: [desc: msg.id],
                  distinct: [msg.from, msg.sender_is_organization],
                  select: msg
              unred_messages = Repo.all(q)

              output =
                unred_messages
                |> Enum.map(fn m ->

                  case m.sender_is_organization do
                    true ->
                      sender_pic =
                        case Accounts.get_organization!(m.from) do
                          o = %Organization{} ->
                            o.logo_uri
                          _ ->
                            ""
                        end

                        %{
                          id: m.id,
                          sender_id: m.from,
                          receiver_id: m.to,
                          body: m.body,
                          sender_is_organization: m.sender_is_organization,
                          receiver_is_organization: m.receiver_is_organization,
                          inserted_at: NaiveDateTime.to_iso8601(m.inserted_at),
                          sender_picture_uri: sender_pic
                        }
                    false ->
                      sender_pic =
                        case Accounts.get_innovator!(m.from) do
                          inno = %Innovator{} ->
                            inno.picture_uri
                          _ ->
                            ""
                        end

                      %{
                        id: m.id,
                        sender_id: m.from,
                        receiver_id: m.to,
                        body: m.body,
                        sender_is_organization: m.sender_is_organization,
                        receiver_is_organization: m.receiver_is_organization,
                        inserted_at: NaiveDateTime.to_iso8601(m.inserted_at),
                        sender_picture_uri: sender_pic
                      }
                  end

                end)

              render(conn, "simple_response.json", response: %{unreds: output})
            _ ->
              render(conn, "simple_response.json", response: %{unreds: []})
          end
      end
  end

  def fetch_chat_history(conn, %{"to_id" => to_id, "from_id" => from_id,
    "to_is_organization" => to_is_organization, "from_is_organization" => from_is_organization,
    "token" => token} = _params) do

      case Auth.update_token_time(token) do
        {:ok, _t = %Token{}} ->
          case Auth.find_token(token) do
            _tok = %Token{} ->
              q =
                from m in Message,
                  where: (m.from == ^from_id and m.sender_is_organization == ^from_is_organization and m.to == ^to_id and m.receiver_is_organization == ^to_is_organization) or (m.from == ^to_id and m.sender_is_organization == ^to_is_organization and m.to == ^from_id and m.receiver_is_organization == ^from_is_organization),
                  limit: 20,
                  order_by: [desc: m.id],
                  select: m
              messages = Repo.all(q)

              output =
                messages
                |> Enum.map(fn m ->
                  %{
                    id: m.id,
                    sender_id: m.from,
                    receiver_id: m.to,
                    body: m.body,
                    sender_is_organization: m.sender_is_organization,
                    receiver_is_organization: m.receiver_is_organization,
                    inserted_at: NaiveDateTime.to_iso8601(m.inserted_at)
                  }
                end)

              render(conn, "simple_response.json", response: %{messages: output})
            _ ->
              render(conn, "simple_response.json", response: %{messages: []})
          end
      end
  end

  def submit_idea(conn, %{"token" => token, "innovator_id" => innovator_id,
    "has_nda" => _has_nda, "is_default_nda" => _is_default_nda, "custom_nda" => _custom_nda} = params) do
    final_params =
      params
      |> Map.delete("token")

    innovator = Accounts.get_innovator!(innovator_id)

    remaining_ideas =
      case Accounts.check_subscription(innovator_id, false) do
        {:ok, ri, _rc, _r, _aa} -> ri
        {:ok, :expired} -> 2 - innovator.generated_ideas_count
        {:error, _} -> 0
      end

    if remaining_ideas > 0 do
      case Auth.update_token_time(token) do
        {:ok, _t = %Token{}} ->
          case Auth.find_token(token) do
            _tok = %Token{} ->
              case Content.create_idea(final_params) do
                {:ok, _i = %Idea{}} ->
                  Accounts.update_innovator(innovator, %{generated_ideas_count: innovator.generated_ideas_count + 1})

                  render(conn, "simple_response.json", response: %{
                      success: "True",
                      error: ""
                    })
                {:error, _} ->
                  render(conn, "simple_response.json", response: %{
                      success: "",
                      error: "Couldn't store your idea! Contact with us, please!"
                    })
              end
            _ ->
              render(conn, "simple_response.json", response: %{
                  success: "",
                  error: "Unauthenticated access!"
                })
          end
      end
    else
      render(conn, "simple_response.json", response: %{
          success: "",
          error: "No such user or ideas limit reached!"
        })
    end
  end

  def fetch_extended_posts(conn, %{"token" => token} = _params) do
    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            q =
              from p in Post,
                #where: p.id > -1,
                limit: 30,
                order_by: [desc: p.id],
                select: p
            posts = Repo.all(q)

            extended_posts =
              posts
              |> Enum.map(fn p ->
                if (p.innovator_id == nil) do
                  o =
                    Accounts.get_organization!(p.organization_id)
                    %{
                      author_name: o.name,
                      author_desc: o.description,
                      author_pic: o.logo_uri,
                      author_id: o.id,
                      post_id: p.id,
                      post_media_file: p.media_file_uri,
                      post_message: p.message,
                      post_likes: p.likes
                    }
                else
                  i =
                    Accounts.get_innovator!(p.innovator_id)
                    %{
                      author_name: i.full_name,
                      author_desc: i.description,
                      author_pic: i.picture_uri,
                      author_id: i.id,
                      post_id: p.id,
                      post_media_file: p.media_file_uri,
                      post_message: p.message,
                      post_likes: p.likes
                    }

                end
              end)

            render(conn, "simple_response.json", response: %{posts: extended_posts})
        _ ->
            render(conn, "simple_response.json", response: %{posts: []})
        end
    end

  end

  def submit_post(conn, %{"message" => _message, "media_file_uri" => _uri, "innovator_id" => i_id,
    "organization_id" => o_id, "token" => token} = params) do

    updated_params =
      cond do
        i_id == 0 ->
          params
          |> Map.delete("innovator_id")
          |> Map.put("innovator_id", nil)
        o_id == 0 ->
          params
          |> Map.delete("organization_id")
          |> Map.put("organization_id", nil)
      end

    final_params =
      updated_params
      |> Map.delete("token")

    case Auth.update_token_time(token) do
      {:ok, _t = %Token{}} ->
        case Auth.find_token(token) do
          _tok = %Token{} ->
            case Content.create_post(final_params) do
              {:ok, _p = %Post{}} ->
                render(conn, "simple_response.json", response: %{
                    success: "True",
                    error: ""
                  })
              {:error, _} ->
                render(conn, "simple_response.json", response: %{
                    success: "",
                    error: "Error submitting post! Try later, please"
                  })
            end
          _ ->
            render(conn, "simple_response.json", response: %{
                success: "",
                error: "Unauthenticated access!"
              })
        end
    end

  end

  def send_contact_us_email(conn, %{"name" => name, "email" => email, "message" => message} = _params) do
    email =
      Emails.email_for_contact_us(name, email, message)

    try do
      case Mailer.deliver_now(email) do
        _e = %Bamboo.Email{} ->
          render(conn, "simple_response.json", response: %{
              success: "True",
              error: ""
            })
        _ ->
          render(conn, "simple_response.json", response: %{
              success: "False",
              error: "Wasn't able to send your message. Try later, please!"
            })
      end
    rescue
      Bamboo.ApiError ->
        render(conn, "simple_response.json", response: %{
            success: "False",
            error: "Wasn't able to send your message. Check your data validity, please!"
          })
    end

  end

  def make_token(conn, _params) do
    case Auth.create_token() do
      {:ok, t = %Token{}} ->
        render(conn, "login.json", login_data: %{token: t.token}, error: "")
      _ ->
        render(conn, "login.json", login_data: %{}, error: "error creating token")
    end
  end

  def get_innovator_data(conn, %{"id" => id, "token" => token} = _params) do
    case Auth.update_token_time(token) do
      {:ok, _tok = %Token{}} ->
        case Auth.find_token(token) do
          t = %Token{} ->
            case Repo.get(Innovator, id) do
              inno = %Innovator{} ->
                q =
                   from c in Connection,
                     where: (c.receiver_id == ^id and c.receiver_is_organization == false) or (c.sender_id == ^id and c.sender_is_organization == false),
                     #limit: 30,
                     #order_by: [desc: p.id],
                     select: c
                 connections = Repo.all(q)

                render(conn, InnovitiesWeb.InnovatorView, "innovator_extended.json",
                  innovator: inno, connections_count: length(connections), token: t.token)
              _ ->
                render(conn, InnovitiesWeb.InnovatorView, "innovator_extended.json", innovator: %Innovator{
                  id: 0,
                  full_name: "",
                  picture_uri: "",
                  rating: 0,
                  country: "",
                  email: "",
                  generated_ideas_count: 0,
                  innovators_plan_id: 0,
                  description: "",
                  about_me: "",
                  education: "",
                  experience: "",
                  username: "",
                  phone: ""
              }, connections_count: 0, token: "Couldn't find innovator with this credentials!")
            end
          _ ->
            render(conn, InnovitiesWeb.InnovatorView, "innovator_extended.json", innovator: %Innovator{
              id: 0,
              full_name: "",
              picture_uri: "",
              rating: 0,
              country: "",
              email: "",
              generated_ideas_count: 0,
              innovators_plan_id: 0,
              description: "",
              about_me: "",
              education: "",
              experience: "",
              username: "",
              phone: ""
            }, connections_count: 0, token: "Unauthenticated access!")
        end
    end
  end

  def get_organization_data(conn, %{"id" => id, "token" => token} = _params) do
     case Auth.update_token_time(token) do
       {:ok, _tok = %Token{}} ->
         case Auth.find_token(token) do
           t = %Token{} ->
             case Repo.get(Organization, id) do
               org = %Organization{} ->
                 q =
                   from c in Connection,
                     where: (c.receiver_id == ^id and c.receiver_is_organization == true) or (c.sender_id == ^id and c.sender_is_organization == true),
                     #limit: 30,
                     #order_by: [desc: p.id],
                     select: c
                 connections = Repo.all(q)

                 render(conn, InnovitiesWeb.OrganizationView, "organization_extended.json",
                  organization: org, connections_count: length(connections), token: t.token)
               _ ->
                 render(conn, InnovitiesWeb.OrganizationView, "organization_extended.json", organization: %Organization{
                   id: 0,
                   name: "",
                   logo_uri: "",
                   country: "",
                   email: "",
                   complete_ideas_count: 0,
                   organizations_plan_id: 0,
                   description: "",
                   webpage: "",
                   about_us: "",
                   industry: "",
                   interested_industries: "",
                   username: "",
                   phone: "",
                   rating: 0
                 }, connections_count: 0, token: "Couldn't find organization with this credentials!")
             end
           _ ->
             render(conn, InnovitiesWeb.OrganizationView, "organization_extended.json", organization: %Organization{
               id: 0,
               name: "",
               logo_uri: "",
               country: "",
               email: "",
               complete_ideas_count: 0,
               organizations_plan_id: 0,
               description: "",
               webpage: "",
               about_us: "",
               industry: "",
               interested_industries: "",
               username: "",
               phone: "",
               rating: 0
             }, connections_count: 0, token: "Unauthenticated access!")
         end
     end
  end

  def member_login(conn, %{"email" => email, "password" => password} = _params) do
    query = from i in Innovator, where: i.email == ^email
    case Repo.one(query) do
      nil ->
        query2 = from o in Organization, where: o.email == ^email
        case Repo.one(query2) do
          nil ->
            render(conn, "login.json", login_data: %{
                id: 0,
                name: "",
                email: "",
                isOrganization: false,
                token: ""
              },
              error: "No data found!")
          org = %Organization{} ->
            case verify_password(org, password) do
              {:ok, _} ->
                case Auth.create_token() do
                  {:ok, t} ->
                    render(conn, "login.json", login_data: %{
                        id: org.id,
                        name: org.name,
                        email: org.email,
                        isOrganization: true,
                        token: t.token
                      },
                      error: "")
                  {:error, _} ->
                    render(conn, "login.json", login_data: %{
                        id: 0,
                        name: "",
                        email: "",
                        isOrganization: false,
                        token: ""
                      },
                      error: "Wait a minute and try again, please!")
                end
              {:error, _} ->
                render(conn, "login.json", login_data: %{
                    id: 0,
                    name: "",
                    email: "",
                    isOrganization: false,
                    token: ""
                  },
                  error: "Email/Password invalid!")
            end
        end
      inn = %Innovator{} ->
        case verify_password(inn, password) do
          {:ok, _} ->
            case Auth.create_token() do
              {:ok, t} ->
                render(conn, "login.json", login_data: %{
                    id: inn.id,
                    name: inn.full_name,
                    email: inn.email,
                    isOrganization: false,
                    token: t.token
                  },
                  error: "")
              {:error, _} ->
                render(conn, "login.json", login_data: %{
                    id: 0,
                    name: "",
                    email: "",
                    isOrganization: false,
                    token: ""
                  },
                  error: "Wait a minute and try again, please!")
            end
          {:error, _} ->
            render(conn, "login.json", login_data: %{
                id: 0,
                name: "",
                email: "",
                isOrganization: false,
                token: ""
              },
              error: "Email/Password invalid!")
        end
    end
  end

  def fetch_top_members(conn, _params) do
    q =
      from i in Innovator,
        where: i.rating > -1,
        limit: 3,
        order_by: [desc: i.rating],
        select: i
    top_innovators = Repo.all(q)

    q2 =
      from i in Organization,
        where: i.rating > -1,
        limit: 3,
        order_by: [desc: i.rating],
        select: i
    top_organizations = Repo.all(q2)

    render(conn, "top_members.json", innovators: top_innovators, organnizations: top_organizations)
  end

  def register_innovator(conn, %{"tariff_plan" => tariff_plan, "country" => country} = params) do

    tariff_plan_data = Repo.get_by!(InnovatorsPlan, name: tariff_plan)

    region = Locals.get_region(country)

    full_params =
      params
      |> Map.put("innovators_plan_id", tariff_plan_data.id)
      |> Map.delete("tariff_plan")
      |> Map.put("region", region)
      |> Map.put("continent", Locals.get_continent(region))

      case Auth.create_token() do
        {:ok, t = %Token{}} ->
          case Accounts.create_innovator(full_params) do
            {:ok, innovator = %Innovator{}} ->
              render(conn, "registration.json", reg_data: %{
                id: innovator.id,
                name: innovator.full_name,
                email: innovator.email,
                token: t.token}, error: "")
            {:error, _} ->
              render(conn, "registration.json", reg_data: %{
                id: 0,
                name: "",
                email: "",
                token: ""
                }, error: "Unable to register. Contact with us, please")
          end
        {:error, _} ->
          render(conn, "registration.json", reg_data: %{
            id: 0,
            name: "",
            email: "",
            token: ""
            }, error: "Wait a minute and try again, please!")
      end

  end

  def register_company(conn, %{"tariff_plan" => tariff_plan, "country" => country} = params) do

    tariff_plan_data = Repo.get_by!(OrganizationsPlan, name: tariff_plan)

    region = Locals.get_region(country)

    full_params =
      params
      |> Map.put("organizations_plan_id", tariff_plan_data.id)
      |> Map.delete("tariff_plan")
      |> Map.put("region", region)
      |> Map.put("continent", Locals.get_continent(region))

    case Auth.create_token() do
      {:ok, t = %Token{}} ->
        case Accounts.create_organization(full_params) do
          {:ok, company = %Organization{}} ->
            render(conn, "registration.json", reg_data: %{
              id: company.id,
              name: company.name,
              email: company.email,
              token: t.token
              }, error: "")
          {:error, _} ->
            render(conn, "registration.json", reg_data: %{
              id: 0,
              name: "",
              email: "",
              token: ""
              }, error: "Unable to register. Contact with us, please")
        end
      {:error, _} ->
        render(conn, "registration.json", reg_data: %{
          id: 0,
          name: "",
          email: "",
          token: ""
          }, error: "Wait a minute and try again, please!")
    end

  end

  def sign_out(conn, %{"token" => token} = _params) do
    case Auth.remove_token(token) do
      {:ok, _t = %Token{}} ->
        render(conn, "simple_response.json", response: "Sucess!")
      _ ->
        render(conn, "simple_response.json", response: "Failed!")
    end
  end

  defp verify_password(nil, _) do
    # Perform a dummy check to make user enumeration more difficult
    Bcrypt.no_user_verify()
    {:error, "Wrong email or password"}
  end

  defp verify_password(user, password) do
    if Bcrypt.verify_pass(password, user.password) do
      {:ok, user}
    else
      {:error, "Wrong email or password"}
    end
  end

  defp innovator_info_contains?(comparison_map, org = %Organization{}) do
      desc = comparison_map.desc
      about_me = comparison_map.about_me
      edu = comparison_map.edu
      exp = comparison_map.exp

      industry =
        if ((String.trim(org.industry) |> String.length()) > 0) do
          org.industry
        else
          "***"
        end
      interested_industries_list = String.split(org.interested_industries, [", ", ","])

      ii1 =
        if ( (length(interested_industries_list) > 0) and
          ((String.trim(hd(interested_industries_list)) |> String.length()) > 0) ) do
          hd(interested_industries_list)
        else
          "***"
        end

      remaining1 =
        if (length(interested_industries_list) > 0) do
          tl(interested_industries_list)
        else
          []
        end

      ii2 =
        if ( (length(remaining1) > 0) and
          ((String.trim(hd(remaining1)) |> String.length()) > 0) ) do
          hd(remaining1)
        else
          "***"
        end

      remaining2 =
        if (length(remaining1) > 0) do
          tl(remaining1)
        else
          []
        end

      ii3 =
        if ( (length(remaining2) > 0) and
          ((String.trim(hd(remaining2)) |> String.length()) > 0) ) do
          hd(remaining2)
        else
          "***"
        end

      if (String.contains?(desc, ii1) or String.contains?(about_me, ii1) or String.contains?(edu, ii1) or String.contains?(exp, ii1) or
        String.contains?(desc, ii2) or String.contains?(about_me, ii2) or String.contains?(edu, ii2) or String.contains?(exp, ii2) or
        String.contains?(desc, ii3) or String.contains?(about_me, ii3) or String.contains?(edu, ii3) or String.contains?(exp, ii3) or
        String.contains?(desc, industry) or String.contains?(about_me, industry) or String.contains?(edu, industry) or String.contains?(exp, industry)) do
        true
      else
        false
      end
  end

end
